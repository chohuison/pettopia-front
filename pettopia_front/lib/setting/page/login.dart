import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:pettopia_front/Menu/CustomBottomNavigatorBar.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411.4, 683.4),
      child: MaterialApp(
        title: "Login",
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
            child: Column(children: <Widget>[
              Container(
                  margin: EdgeInsets.only(left: 17.w, top: 150.h),
                  width: 240.w,
                  height: 80.h,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/img/txtLogo.png')))),
              Container(
                  margin: EdgeInsets.only(left: 12.w, top: 10.h),
                  child: Text("로그인", style: TextStyle(fontSize: 20.sp))),
              Container(
                margin: EdgeInsets.only(
                    left: 25.w, right: 25.w, top: 12.h, bottom: 15.h),
                height: 2.h,
                color: Color(0xFFD5BDAF),
              ),
              _kakaoLogin(),
              _naverLogin(),
              _googleLogin()
            ]),
          ),
          bottomNavigationBar: CustomBottomNavigatorBar(page: 4),
        ),
      ),
    );
  }
}

Widget _kakaoLogin() {
  return Container(
    width: 185.w,
    height: 50.h,
    padding: EdgeInsets.zero,
    child: IconButton(
        onPressed: () {},
        icon: Image.asset(
          'assets/img/kakao_login.png',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        )),
  );
}

Widget _naverLogin() {
  return Container(
    width: 185.w,
    height: 50.h,
    padding: EdgeInsets.zero,
    child: IconButton(
        onPressed: () {},
        icon: Image.asset(
          'assets/img/naver_login.png',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        )),
  );
}

Widget _googleLogin() {
  return Container(
    width: 185.w,
    height: 50.h,
    padding: EdgeInsets.zero,
    child: IconButton(
        onPressed: () {},
        icon: Image.asset(
          'assets/img/google_login.png',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        )),
  );
}
