import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:pettopia_front/Menu/CustomBottomNavigatorBar.dart';
import 'package:pettopia_front/Menu/appbar.dart';
import 'package:pettopia_front/enum/appBarList.dart';
import 'package:pettopia_front/hospital/widget/hospitalList.dart';
import 'package:pettopia_front/hospital/widget/hospitalValue.dart';
import 'package:pettopia_front/hospital/widget/regionSelectBox.dart';

class PetFilter extends StatefulWidget   {
  const PetFilter({Key? key}) : super(key: key);

  @override
  _PetFilterSearchState createState() => _PetFilterSearchState();
}

class _PetFilterSearchState extends State<PetFilter> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;


 late List<Map<String,dynamic>> _lifeAppBar;
  @override
  void initState() {
    super.initState();

  AppBarList _appBarList= AppBarList();
_lifeAppBar=_appBarList.getLifeAppBar();
  }
  
 

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
            AppBarContainer(page: 0, barList: _lifeAppBar),
              Container(
                width:500.w,
                height: 485.h,
                margin:
                    EdgeInsets.symmetric(vertical: 1.0.h, horizontal: 20.0.w),
                decoration: BoxDecoration(
                  color: Color(0xFFD5BDAF),
                  borderRadius: BorderRadius.circular(25),
                ),
              
              ),
            ],
          ),
          bottomNavigationBar: CustomBottomNavigatorBar(page: 3),
        ),
      ),
    );
  }
}
