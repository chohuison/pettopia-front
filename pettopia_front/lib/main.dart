import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pettopia_front/Menu/CustomBottomNavigatorBar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //가로가 더 길어질때 생기는 오류방지 크롬으로 실행했을시 생긴다는데 혹시 모르니깐 적용해놈
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411.4, 683.4), // 디자인 기준 크기를 설정합니다.
      child: MaterialApp(
        title: "main_page",
        builder: (context, child) {
          // MediaQuery를 사용하여 텍스트 크기 조정을 비활성화합니다.
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: child!,
          );
        },
        home: Builder(
          builder: (context) {
            return Scaffold(
              backgroundColor: Color.fromRGBO(237, 237, 233, 1.0),
              resizeToAvoidBottomInset: false,

              bottomNavigationBar:
                  CustomBottomNavigatorBar(page: 2), // 예시 커스텀 바텀 네비게이션 바
            );
          },
        ),
      ),
    );
  }
}
