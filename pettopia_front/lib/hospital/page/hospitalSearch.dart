import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pettopia_front/Menu/CustomBottomNavigatorBar.dart';
import 'package:pettopia_front/hospital/widget/hospitalList.dart';
import 'package:pettopia_front/hospital/widget/hospitalValue.dart';
import 'package:pettopia_front/hospital/widget/hospitalAppbar.dart';
import 'package:pettopia_front/hospital/widget/regionSelectBox.dart';

class HospitalSearch extends StatefulWidget {
  const HospitalSearch({Key? key}) : super(key: key);

  @override
  _HospitalSearchState createState() => _HospitalSearchState();
}

class _HospitalSearchState extends State<HospitalSearch> {
 List<Map<String, dynamic>>? _hospitalList;
  //여기 나중에 지역 바뀔때마다 병원 가져오면 될듯 
  List<Map<String, dynamic>> _fetchHospitalList(String selectedRegion) {
   
    return [
      {'name': '병원1', 'address': '주소1', 'phone': '전화번호1'},
      {'name': '병원2', 'address': '주소2', 'phone': '전화번호2'},
      {'name': '병원3', 'address': '주소3', 'phone': '전화번호3'},
       {'name': '병원4', 'address': '주소4', 'phone': '전화번호4'},
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
        resizeToAvoidBottomInset: false,
          backgroundColor: Color.fromRGBO(237, 237, 233, 1.0),
          body: Column(
            children: <Widget>[
              HospitalAppBar(page: 0),
              Container(
                height: 485.h,
                margin:
                    EdgeInsets.symmetric(vertical: 1.0.h, horizontal: 20.0.w),
                decoration: BoxDecoration(
                  color: Color(0xFFD5BDAF),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      child:  RegionSelectBox(
            onRegionSelected: (selectedRegion) {
              setState(() {
                _hospitalList = _fetchHospitalList(selectedRegion); // 선택한 지역에 따른 병원 목록 가져오기
              });
            },
          ),
          padding: EdgeInsets.fromLTRB(20.w, 10.h, 0.w, 10.h),
          height: 50.h,
        ),
                  
                    if (_hospitalList != null)
                      HospitalList(
                        hospitalList: _hospitalList!,
                      ),
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
