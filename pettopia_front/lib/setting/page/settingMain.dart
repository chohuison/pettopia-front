import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pettopia_front/Menu/CustomBottomNavigatorBar.dart';
import 'package:pettopia_front/hospital/widget/hospitalList.dart';
import 'package:pettopia_front/hospital/widget/hospitalValue.dart';
import 'package:pettopia_front/hospital/widget/hospitalAppbar.dart';
import 'package:pettopia_front/hospital/widget/regionSelectBox.dart';

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
        title: "hospitalSearch",
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
              //여기 나중에 펫토피아 글씨 로고 넣기
              Container(
                  margin: EdgeInsets.only(left: 20.w, top: 80.h),
                  width: 240.w,
                  height: 80.h,
                  color: Colors.blue),
              Container(
                  margin: EdgeInsets.only(left: 20.w, top: 10.h),
                  child: Text("설정", style: TextStyle(fontSize: 20.sp))),
              Container(
                margin: EdgeInsets.only(
                    left: 25.w, right: 25.w, top: 9.h, bottom: 15.h),
                height: 2.h,
                color: Color(0xFFD5BDAF),
              ),
              _buildContainer("반려동물 추가/ 등록하기"),
              _buildContainer("반려동물 추가 정보 작성"),
              _buildContainer("반려동물 정보 조회하기"),
              _buildContainer("로그아웃"),
            ],
          ),
          bottomNavigationBar: CustomBottomNavigatorBar(page: 4),
        ),
      ),
    );
  }
}

Widget _buildContainer(String name) {
  return Container(
    margin: EdgeInsets.only(left: 25.w, right: 25.w, bottom: 15.h),
    width: 500.w,
    height: 80.h,
    decoration: BoxDecoration(
      color: Color(0xFFF5EBE0),
      border: Border.all(
        color: Color(0xFFD5BDAF),
        width: 1.0,
      ),
      borderRadius: BorderRadius.circular(50.0),
    ),
    child: ElevatedButton(
      onPressed: () {},
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
