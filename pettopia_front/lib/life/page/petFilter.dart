import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:pettopia_front/Menu/CustomBottomNavigatorBar.dart';
import 'package:pettopia_front/Menu/appbar.dart';
import 'package:pettopia_front/enum/appBarList.dart';
import 'package:pettopia_front/hospital/widget/hospitalList.dart';
import 'package:pettopia_front/hospital/widget/hospitalValue.dart';
import 'package:pettopia_front/hospital/widget/regionSelectBox.dart';
import 'package:pettopia_front/life/page/TakePictureScreen.dart';
import 'package:camera/camera.dart';

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

  @override
  void initState() {
    super.initState();
    AppBarList _appBarList = AppBarList();
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
    ImagePicker().pickImage(source: ImageSource.gallery).then((image) {
      if (image != null) {
        setState(() {
          file = image;
        });``````
      }
    });
  }

  Future<void> _initializeData() async {
    final cameras = await availableCameras();
    firstCamera = cameras.first;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411.4, 683.4),
      child: MaterialApp(
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
              AppBarContainer(page: 0, barList: _lifeAppBar),
              Container(
                  width: 500.w,
                  height: 485.h,
                  margin:
                      EdgeInsets.symmetric(vertical: 1.0.h, horizontal: 20.0.w),
                  decoration: BoxDecoration(
                    color: Color(0xFFD5BDAF),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Column(children: <Widget>[
                    Container(
                        color: Colors.grey,
                        width: 300.w,
                        height: 200.h,
                        child: (file != null)
                            ? Image.file(
                                File(file!.path),
                                fit: BoxFit.cover,
                              )
                            : const Icon(
                                Icons.image,
                                size: 50,
                                color: Colors.white,
                              )),
                    Container(
                        margin: EdgeInsets.only(top: 10.h, left: 75.w),
                        child: Row(
                          children: <Widget>[
                            _button("촬영하기", _getCamera),
                            SizedBox(width: 20.w),
                            _button("갤러리", _getGallery)
                          ],
                        ))
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
