import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class GoggleLogin extends StatefulWidget {
  const GoggleLogin({Key? key}) : super(key: key);

  @override
  _GoggleLoginState createState() => _GoggleLoginState();
}

class _GoggleLoginState extends State<GoggleLogin> {

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411.42857142857144, 683.4285714285714),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "GoggleLogin",
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
            width: 400.w,
            height: 600.h,
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
                    margin: EdgeInsets.only(left: 17.w, top: 60.h),
                    width: 240.w,
                    height: 80.h,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/img/txtLogo.png')))),
                Container(
                    margin: EdgeInsets.only(left: 12.w, top: 10.h),
                    child: Text("설정", style: TextStyle(fontSize: 20.sp))),
                Container(
                  margin: EdgeInsets.only(
                      left: 25.w, right: 25.w, top: 12.h, bottom: 15.h),
                  height: 2.h,
                  color: Color(0xFFD5BDAF),
                ),
            
              ],
            ),
          ),

        ),
      ),
    );
  }


}
