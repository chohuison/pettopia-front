import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pettopia_front/Menu/CustomBottomNavigatorBar.dart';
import 'package:pettopia_front/hospital/page/hospitalList.dart';
import 'package:pettopia_front/hospital/page/hospitalValue.dart';
import 'package:pettopia_front/hospital/widget/hospitalAppbar.dart';
import 'package:pettopia_front/hospital/widget/regionSelectBox.dart';

class HospitalSearch extends StatefulWidget {
  const HospitalSearch({Key? key}) : super(key: key);

  @override
  _HospitalSearchState createState() => _HospitalSearchState();
}

class _HospitalSearchState extends State<HospitalSearch> {
  late List<Map<String, dynamic>>? hospitalList;

@override
void initState() {
  super.initState();
  //연결하면서 병원 종류 가져오기 
  hospitalList ??= [
    {'name': '구미옥계동물병원', 'address': '경북 구미시 산호대로 31길 10', 'phone': '0507-****-****'},
    {'name': '구미옥계동물병원', 'address': '경북 구미시 산호대로 31길 10', 'phone': '0507-****-****'}
  ];
}

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
          backgroundColor: Color.fromRGBO(237, 237, 233, 1.0),
        body: Column(
          children:<Widget>[
            HospitalAppBar(page: 0),
              Container(
                height: 485.h,
                margin: EdgeInsets.symmetric(vertical: 1.0.h, horizontal: 20.0.w),
                decoration: BoxDecoration(
                  color: Color(0xFFD5BDAF),
                  borderRadius: BorderRadius.circular(25),
                ),
                 child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      child: RegionSelectBox(),
                      padding: EdgeInsets.fromLTRB(20.w, 10.h, 0.w, 10.h),
                      height: 50.h,
                    ),
                     HospitalList(hospitalList: hospitalList!,)
                  ],
                ),
              ),
             
            ],

              ),
             

          

      
          bottomNavigationBar: CustomBottomNavigatorBar(page: 1),
        ),
      ),
    );
  }
}
