import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import 'package:pettopia_front/Menu/CustomBottomNavigatorBar.dart';
import 'package:pettopia_front/Menu/AppBar.dart';

import 'package:pettopia_front/enum/appBarList.dart';
import 'package:pettopia_front/hospital/widget/hospitalList.dart';
import 'package:pettopia_front/hospital/widget/hospitalValue.dart';
import 'package:pettopia_front/hospital/widget/regionSelectBox.dart';
import 'package:pettopia_front/life/page/TakePictureScreen.dart';
import 'package:camera/camera.dart';
import 'package:pettopia_front/server/AI.dart';

class PetFilter extends StatefulWidget {
  const PetFilter({Key? key}) : super(key: key);

  @override
  _PetFilterSearchState createState() => _PetFilterSearchState();
}

class _PetFilterSearchState extends State<PetFilter>
    with AutomaticKeepAliveClientMixin {
  XFile? file;

  @override
  bool get wantKeepAlive => true;

  late List<Map<String, dynamic>> _lifeAppBar;
  late CameraDescription firstCamera;
  final petFilterService = AI();
  AppBarList _appBarList = AppBarList();

  @override
  void initState() {
    super.initState();

    _lifeAppBar = _appBarList.getLifeAppBar();

    _initializeData();
  }

  Future<void> _getCamera() async {
    ImagePicker().pickImage(source: ImageSource.camera).then((image) {
      if (image != null) {
        setState(() {
          file = image;
        });
      }
    });
  }

  Future<void> _getGallery() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage == null) {
      return;
    }

    XFile? filteredImage = await petFilterService.applyPetFilter(
        pickedImage, '강이지', 'nose.png', 'horns2.png'); // 필터 적용 요청

    setState(() {
      file = filteredImage;
    });
  }

  Future<void> _initializeData() async {
    final cameras = await availableCameras();
    firstCamera = cameras.first;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411.42857142857144, 683.4285714285714),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "petfilter",
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: child!,
          );
        },
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Color.fromRGBO(237, 237, 233, 1.0),
          body: Column(
            children: <Widget>[
              CustomAppBar(
                  page: 0,
                  barList: _lifeAppBar,
                  buttonHandler: _appBarList.lifeAppBarHandler),
              Container(
                  width: 500.w,
                  height: 485.h,
                  margin:
                      EdgeInsets.symmetric(vertical: 1.0.h, horizontal: 20.0.w),
                  decoration: BoxDecoration(
                    color: Color(0xFFE3D5CA),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Column(children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 10.h, 0, 0),
                      width: 250.h,
                      height: 250.h,
                      child: (file != null)
                          ? Image.file(
                              File(file!.path),
                              fit: BoxFit.cover,
                            )
                          : const Icon(
                              Icons.camera_alt_outlined,
                              size: 50,
                              color: Colors.black,
                            ),
                      decoration: BoxDecoration(
                          color: Color(0xFFF5EBE0),
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            width: 1,
                            color: Color.fromARGB(255, 165, 142, 128),
                          )),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 10.h, left: 75.w),
                        child: Row(
                          children: <Widget>[
                            _button("촬영하기", _getCamera),
                            SizedBox(width: 20.w),
                            _button("갤러리", _getGallery)
                          ],
                        )),
                    Container(
                      margin: EdgeInsets.only(top: 10.h),
                      width: 350.w,
                      height: 150.h,
                      decoration: BoxDecoration(
                          color: Color(0xFFF5EBE0),
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            width: 1,
                            color: Color.fromARGB(255, 165, 142, 128),
                          )),
                      child: ListView(
                        children: [
                          Wrap(
                            children: [
                              _filterBtn(),
                              _filterBtn(),
                              _filterBtn(),
                              _filterBtn(),
                              _filterBtn(),
                              _filterBtn(),
                              _filterBtn(),
                              _filterBtn(),
                              _filterBtn(),
                              _filterBtn(),
                              _filterBtn(),
                              _filterBtn(),
                              _filterBtn(),
                            ],
                          )
                        ],
                      ),
                    )
                  ])),
            ],
          ),
          bottomNavigationBar: CustomBottomNavigatorBar(page: 3),
        ),
      ),
    );
  }
}

Widget _button(String buttonName, Function controller) {
  return SizedBox(
    width: 100.w,
    height: 40.h,
    child: ElevatedButton(
      onPressed: () {
        controller();
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFAFA59B)),
      ),
      child: Text(
        buttonName,
        style: TextStyle(
          fontSize: 13,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

// 일단 필터 보여주기만 했는데 연결하다가 필요하면 클래스 분리해야 할듯
Widget _filterBtn() {
  return Container(
    margin: EdgeInsets.only(bottom: 5.h, left: 3.w, right: 3.w),
    width: 60.w,
    height: 60.h,
    child: IconButton(
        onPressed: () {
          print("버튼 선택됨");
        },
        icon: Image.asset('assets/img/exFilter.png')),
  );
}
