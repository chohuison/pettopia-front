import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:pettopia_front/Menu/CustomBottomNavigatorBar.dart';
import 'package:pettopia_front/setting/page/createPet.dart';

class SettingMain extends StatefulWidget {
  const SettingMain({Key? key}) : super(key: key);

  @override
  _SettingMainhState createState() => _SettingMainhState();
}

class _SettingMainhState extends State<SettingMain> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411.4, 683.4),
      child: MaterialApp(
        title: "settingMain",
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: child!,
          );
        },
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Color.fromRGBO(237, 237, 233, 1.0),
          body: Container(
            width:400.w,
            height:600.h,
            margin: EdgeInsets.only(
                left: 15.w, top: 15.h, right: 15.w, bottom: 15.h),
            decoration: BoxDecoration(
              color: Color(0xFFE3D5CA),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              children: <Widget>[
                //여기 나중에 펫토피아 글씨 로고 넣기
                Container(
                    margin: EdgeInsets.only(left: 17.w, top: 80.h),
                    width: 240.w,
                    height: 80.h,
                    color: Colors.blue),
                Container(
                    margin: EdgeInsets.only(left: 12.w, top: 10.h),
                    child: Text("설정", style: TextStyle(fontSize: 20.sp))),
                Container(
                  margin: EdgeInsets.only(
                      left: 25.w, right: 25.w, top: 9.h, bottom: 15.h),
                  height: 2.h,
                  color: Color(0xFFD5BDAF),
                ),
                _buildContainer(context, "반려동물 추가/ 등록하기", 0),
                _buildContainer(context, "반려동물 추가 정보 작성", 1),
                _buildContainer(context, "반려동물 정보 조회하기", 2),
                _buildContainer(context, "로그아웃", 3),
              ],
            ),
          ),
          bottomNavigationBar: CustomBottomNavigatorBar(page: 4),
        ),
      ),
    );
  }
}

Widget _buildContainer(BuildContext context, String name, int index) {
  return Container(
    margin: EdgeInsets.only(left: 25.w, right: 25.w, bottom: 15.h),
    width: 500.w,
    height: 70.h,
    decoration: BoxDecoration(
      color: Color(0xFFF5EBE0),
      border: Border.all(
        color: Color(0xFFD5BDAF),
        width: 1.0,
      ),
      borderRadius: BorderRadius.circular(30.0),
    ),
    child: ElevatedButton(
      onPressed: () {
        if (index == 0) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreatePet()),
          );
        }
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFF5EBE0)),
      ),
      child: Center(
        child: Text(
          name,
          style: TextStyle(fontSize: 20.sp, color: Colors.black),
        ),
      ),
    ),
  );
}
