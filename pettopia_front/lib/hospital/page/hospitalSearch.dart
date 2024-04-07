import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pettopia_front/Menu/CustomBottomNavigatorBar.dart';
import 'package:pettopia_front/hospital/widget/hospitalAppbar.dart';
import 'package:pettopia_front/hospital/widget/regionSelectBox.dart';

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
        title: "hospitalSearch",
        builder: (context, child) {
          // MediaQuery를 사용하여 텍스트 크기 조정을 비활성화합니다.
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: child!,
          );
        },
        home: Scaffold(
          backgroundColor: Color.fromRGBO(237, 237, 233, 1.0),
          body: ListView(
            children: [
              HospitalAppBar(page: 0),
              Container(
                height: 485.h,
                  margin: EdgeInsets.symmetric(vertical: 1.0.h, horizontal: 20.0.w),
                decoration: BoxDecoration(
                  color: Color(0xFFD5BDAF),
                   borderRadius: BorderRadius.circular(25),
                ),
                child:Column(
                  children:<Widget>[
                    Container(
                         alignment: Alignment.centerLeft,
                    child:RegionSelectBox(),
                       padding: EdgeInsets.fromLTRB(20.w, 10.h, 0.w, 10.h),
                             
                              height:50.h),
                    Container(
                 
                      // color:Colors.blue,
                    
                      height:405.h
                    )
                  ],

                )
              )
            ],
          ),
          bottomNavigationBar: CustomBottomNavigatorBar(page: 1),
        ),
      ),
    );
  }
}
