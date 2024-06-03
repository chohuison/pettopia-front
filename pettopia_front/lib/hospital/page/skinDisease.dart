import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pettopia_front/Menu/AppBar.dart';
import 'package:pettopia_front/Menu/CustomBottomNavigatorBar.dart';
import 'package:pettopia_front/enum/appBarList.dart';
import 'package:pettopia_front/hospital/widget/skinDiseaseList.dart';
import 'package:pettopia_front/hospital/widget/skinDiseaseListValue.dart';
import 'package:pettopia_front/server/AI.dart';

class SkinDisease extends StatefulWidget {
  const SkinDisease({super.key});

  @override
  State<SkinDisease> createState() => _SkinDiseaseState();
}

class _SkinDiseaseState extends State<SkinDisease>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  XFile? file;
  late List<Map<String, dynamic>> _hospitalAppBar;
  AppBarList _appBarList = AppBarList();

  late List<Map<String, dynamic>> _diseaseList = [];
  AI _aiServer = AI();

  @override
  void initState() {
    super.initState();
    _hospitalAppBar = _appBarList.getHospitalAppBar();
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
       _aiServer.petSkinDisease(pickedImage);

    setState(() {
      file = pickedImage;
    });
  }
@override
Widget build(BuildContext context) {
  return ScreenUtilInit(
    designSize: const Size(392.7, 783.3),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "skinDisease",
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
              page: 2,
              barList: _hospitalAppBar,
              buttonHandler: _appBarList.hospitalAppBarHandler,
            ),
            Container(
              height: 485.h,
              width: 500.w,
              margin: EdgeInsets.symmetric(vertical: 1.0.h, horizontal: 20.0.w),
              decoration: BoxDecoration(
                color: Color(0xFFE3D5CA),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 5.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _button("촬영하기", _getCamera),
                        _button("사진 찾기", _getGallery),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 10.h),
                    height: 1.h,
                    color: Color.fromARGB(255, 165, 142, 128),
                  ),
                  Text("피부병이 의심되는 부위를 가까이에서 찍어주세요"),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          // 인공지능 연결해서 동적으로 생성하도록 만들어야함
                          SkinDiseaseListValue(),
                          SkinDiseaseListValue(),
                          SkinDiseaseListValue(),
                          SkinDiseaseListValue(),
                          SkinDiseaseListValue(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: CustomBottomNavigatorBar(page: 0),
      ),
    ),
  );
}


  Widget _button(String buttonName, Function controller) {
    return SizedBox(
      width: 150.w,
      height: 50.h,
      child: Container(
        margin: EdgeInsets.only(top: 10.h),
        child: ElevatedButton(
          onPressed: () {
            controller();
          },
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Color(0xFFAFA59B)),
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
      ),
    );
  }
}
