import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pettopia_front/Menu/AppBar.dart';
import 'package:pettopia_front/Menu/CustomBottomNavigatorBar.dart';
import 'package:pettopia_front/enum/appBarList.dart';

class PetsnalColor extends StatefulWidget {
  const PetsnalColor({Key? key}) : super(key: key);

  @override
  _PetsnalColorState createState() => _PetsnalColorState();
}

class _PetsnalColorState extends State<PetsnalColor>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  XFile? file;
  late List<Map<String, dynamic>> _beautyAppBar;
  AppBarList _appBarList = AppBarList();

  @override
  void initState() {
    super.initState();
    _beautyAppBar = _appBarList.getBeautyAppBar();
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

    // XFile? filteredImage = await petFilterService.applyPetFilter(
    //     pickedImage, '강이지', 'nose.png', 'horns2.png'); // 필터 적용 요청

    // setState(() {
    //   file = filteredImage;
    // });

    setState(() {
      file = pickedImage;
    });
  }

  Future<void> _getPetsnalColor() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              backgroundColor: Color(0xFFE3D5CA),
              content: Container(
                width: 120.w,
                height: 270.h,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 190.w),
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.close)),
                    ),
                    Container(
                        child: Column(
                      children: [
                        Container(
                          child: Text(
                            "펫스널컬러란?",
                            style: TextStyle(
                                fontSize: 18.sp, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 15.h),
                          child: Text(
                              "사람에게 퍼스널컬러가 존재하듯, 동물에게도 잘 어울리는 펫스널컬러가 존재한다는 사실 알고 계신가요? 펫토피아에서는 반려동물의 털 색깔을 분석한 후, 먼셀의 색 조화론을 이용하여 나의 반려동물에게 가장 잘 어울리는 색상 세 가지를 추천해드립니다!"),
                        )
                      ],
                    ))
                  ],
                ),
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411.4, 683.4),
      child: MaterialApp(
          title: "petsnalColor",
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
                    barList: _beautyAppBar,
                    buttonHandler: _appBarList.beautyAppBarHandler),
                Container(
                  height: 485.h,
                  width: 500.w,
                  margin:
                      EdgeInsets.symmetric(vertical: 1.0.h, horizontal: 20.0.w),
                  decoration: BoxDecoration(
                    color: Color(0xFFE3D5CA),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Column(
                    children: [
                      Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 10.h, 0, 0),
                            width: 250.w,
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
                          if (file == null)
                            Column(
                              children: [
                                _button("촬영하기", _getCamera),
                                _button("사진 찾기", _getGallery),
                                _button("펫스널컬러란?", _getPetsnalColor),
                                Container(
                                  height: 10.h,
                                ),
                                Text("- 반려동물을 가까이에서 찍어주세요."),
                                Text("- 밝은 장소에서 촬영해주세요.")
                              ],
                            )
                          else
                            Column(
                              children: [
                                Container(
                                  height: 20.h,
                                ),
                                Text(
                                  "내 반려동물에게는",
                                  style: TextStyle(fontSize: 15.sp),
                                ),
                                Container(
                                  margin:
                                      EdgeInsets.only(top: 10.h, bottom: 10.h),
                                  // Container의 color에 ai 결과값으로 받은 색상값 넣기
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 60.w,
                                        height: 60.h,
                                        decoration:
                                            BoxDecoration(color: Colors.red),
                                      ),
                                      Container(
                                        width: 60.w,
                                        height: 60.h,
                                        decoration:
                                            BoxDecoration(color: Colors.green),
                                      ),
                                      Container(
                                        width: 60.w,
                                        height: 60.h,
                                        decoration:
                                            BoxDecoration(color: Colors.blue),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  "이런 색이 어울려요.",
                                  style: TextStyle(fontSize: 15.sp),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10.h),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      _button("다시 촬영", _getCamera),
                                      _button("갤러리", _getGallery)
                                    ],
                                  ),
                                )
                              ],
                            )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            bottomNavigationBar: CustomBottomNavigatorBar(page: 0),
          )),
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
