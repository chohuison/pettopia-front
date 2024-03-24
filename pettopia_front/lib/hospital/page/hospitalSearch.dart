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
      child: MaterialApp(
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
                preferredSize: Size.fromHeight(60.0.h),
                child: Container(
                    color: Color.fromRGBO(237, 237, 233, 1.0),
                    child: Row(
                      children: <Widget>[
                        _buildIconButton('assets/hospitalIcon.png', 0),
                        _buildIconButton('assets/hospitalIcon.png', 1),
                        _buildIconButton('assets/hospitalIcon.png', 2),
                        _buildIconButton('assets/hospitalIcon.png', 3)
                      ],
                    )),
              ),
              bottomNavigationBar: CustomBottomNavigatorBar(page: 1),
            );
          },
        ),
      ),
    );
  }

  Widget _buildIconButton(String img, int index) {
    return ElevatedButton(
      onPressed: () {},
      child: Container(
         
          ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          Color(0xFFD5BDAF),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
