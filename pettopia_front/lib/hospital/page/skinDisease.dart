import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pettopia_front/Menu/AppBar.dart';
import 'package:pettopia_front/Menu/CustomBottomNavigatorBar.dart';
import 'package:pettopia_front/enum/appBarList.dart';

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

    // XFile? filteredImage = await petFilterService.applyPetFilter(
    //     pickedImage, '강이지', 'nose.png', 'horns2.png'); // 필터 적용 요청

    // setState(() {
    //   file = filteredImage;
    // });

    setState(() {
      file = pickedImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(411.42857142857144, 683.4285714285714),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "skinDisease",
          builder: (context, child) {
            return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: child!);
          },
          home: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Color.fromRGBO(237, 237, 233, 1.0),
            body: Column(
              children: <Widget>[
                CustomAppBar(
                    page: 2,
                    barList: _hospitalAppBar,
                    buttonHandler: _appBarList.hospitalAppBarHandler),
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
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 10.h, 0, 10.h),
                        width: 200.w,
                        height: 200.h,
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
                      Text("피부병이 의심되는 부위의 사진을 찍어주세요."),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _button("촬영하기", _getCamera),
                            _button("사진 찾기", _getGallery)
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 10.h),
                        height: 1.h,
                        color: Color.fromARGB(255, 165, 142, 128),
                      ),
                      Container(
                        child: Column(
                          children: [Text("이런 질병이 의심됩니다."),
                          
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            bottomNavigationBar: CustomBottomNavigatorBar(page: 0),
          ),
        ));
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
