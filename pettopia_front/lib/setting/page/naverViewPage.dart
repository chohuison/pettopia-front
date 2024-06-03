import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pettopia_front/Menu/CustomBottomNavigatorBar.dart';

class NaverViewPage extends StatefulWidget {
  const NaverViewPage({Key? key}) : super(key: key);

  @override
  _NaverViewPageState createState() => _NaverViewPageState();
}

class _NaverViewPageState extends State<NaverViewPage> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(392.7272727273, 783.2727272727),
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "NaverView",
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: 240.w,
                        height: 80.h,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/img/txtLogo.png')))),
                    Center(
                      child: Text(
                        "사용자 정보",
                        style: TextStyle(
                            fontSize: 25.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Center(
                      child: Text(
                        "SNS 로그인(네이버)",
                        style: TextStyle(fontSize: 17.sp),
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    _typeContainer("이름", "홍길동"),
                    _typeContainer("e-mail", "honggd@naver.com"),
                    _typeContainer("닉네임", "고길동"),
                    SizedBox(
                      height: 70.h,
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: CustomBottomNavigatorBar(page: 4),
            )));
  }

  Widget _typeContainer(String name, String state) {
    return Row(
      children: [
        Container(
            width: 80.w,
            height: 30.h,
            margin: EdgeInsets.fromLTRB(30.w, 10.h, 10.w, 0),
            decoration: BoxDecoration(
              color: Color(0xFFD5BDAF),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Center(
                child: Text(
              name,
            ))),
        Container(
            margin: EdgeInsets.fromLTRB(0, 10.h, 10.w, 0), child: Text(state))
      ],
    );
  }
}
