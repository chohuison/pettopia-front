import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pettopia_front/Menu/CustomBottomNavigatorBar.dart';

class HospitalSearch extends StatefulWidget {
  const HospitalSearch({Key? key}) : super(key: key);

  @override
  _HospitalSearchState createState() => _HospitalSearchState();
}


class _HospitalSearchState extends State<HospitalSearch> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411.4, 683.4), // 디자인 기준 크기를 설정합니다.
      child:  MaterialApp(
        title: "hospital",
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
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(60.0.h), // ScreenUtil을 사용하여 높이 설정
                child: AppBar(
                  title: Text('병원 찾기 페이지'),
                  centerTitle: true,
                  backgroundColor: Colors.blue, // 색상을 직접 지정합니다.
                ),
              ),
              bottomNavigationBar: CustomBottomNavigatorBar(page: 1),
            );
          },
        ),
      ),
    );
  }
}

