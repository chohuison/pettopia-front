import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:pettopia_front/Menu/CustomBottomNavigatorBar.dart';
import 'package:pettopia_front/Menu/AppBar.dart';
import 'package:pettopia_front/enum/appBarList.dart';
import 'package:pettopia_front/hospital/widget/hospitalList.dart';
import 'package:pettopia_front/hospital/widget/hospitalValue.dart';

import 'package:pettopia_front/hospital/widget/regionSelectBox.dart';
import 'package:pettopia_front/server/DB/API.dart';

class HospitalSearch extends StatefulWidget {
  const HospitalSearch({Key? key}) : super(key: key);

  @override
  _HospitalSearchState createState() => _HospitalSearchState();
}

class _HospitalSearchState extends State<HospitalSearch>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  late List<Map<String, dynamic>> _hospitalAppBar;
  AppBarList _appBarList = AppBarList();
  APIServer _apiServer = APIServer();
  @override
  void initState() {
    super.initState();

    _hospitalAppBar = _appBarList.getHospitalAppBar();
  }

  List<Map<String, dynamic>> _hospitalList = [];
  //여기 나중에 지역 바뀔때마다 병원 가져오면 될듯
  void _fetchHospitalList(String selectedRegion) async {
    print(selectedRegion);
    List<Map<String, dynamic>> list =  await _apiServer.getHospitalService(context,selectedRegion);
    setState(() {
     _hospitalList = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411.4, 683.4),
      child: MaterialApp(
           debugShowCheckedModeBanner: false ,
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
              CustomAppBar(
                  page: 0,
                  barList: _hospitalAppBar,
                  buttonHandler: _appBarList.hospitalAppBarHandler),
              Container(
                  width: 500.w,
                  height: 485.h,
                  margin:
                      EdgeInsets.symmetric(vertical: 1.0.h, horizontal: 20.0.w),
                  decoration: BoxDecoration(
                    color: Color(0xFFE3D5CA),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                          top: 35.h,
                          child: Container(
                              // color: Colors.blue,
                              margin: EdgeInsets.fromLTRB(0, 17.h, 0, 20.h),
                              height: 400.h,
                              width: 370.w,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: <Widget>[
                                    if (_hospitalList != null)
                                      HospitalList(
                                        hospitalList: _hospitalList!,
                                      ),
                                  ],
                                ),
                              ))),
                      //selectBox부분
                      Positioned(
                          width: 200.w,
                          // this Container
                          child: Container(
                            // color: Colors.red,
                            height: 300.h,
                            child: RegionSelectBox(
                                    onRegionSelected: _fetchHospitalList)
                          ))
                    ],
                  )),
            ],
          ),
          bottomNavigationBar: CustomBottomNavigatorBar(page: 1),
        ),
      ),
    );
  }
}
