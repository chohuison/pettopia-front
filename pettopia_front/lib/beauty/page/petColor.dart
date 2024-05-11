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

class PetColor extends StatefulWidget {
  const PetColor({Key? key}) : super(key: key);

  @override
  _PetColorState createState() => _PetColorState();
}

class _PetColorState extends State<PetColor>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  late List<Map<String, dynamic>> _beautyAppBar;
  AppBarList _appBarList = AppBarList();
  APIServer _apiServer = APIServer();
  @override
  void initState() {
    super.initState();
    

    _beautyAppBar = _appBarList.getBeautyAppBar();
    print(_beautyAppBar);
  }

  List<Map<String, dynamic>>? _hospitalList;
  //여기 나중에 지역 바뀔때마다 병원 가져오면 될듯
  void _fetchHospitalList(String selectedRegion){
  
    _apiServer.getHospitalService();
    setState(() {
      _hospitalList= [
      {'name': '병원1', 'address': '주소1', 'phone': '전화번호1'},
      {'name': '병원2', 'address': '주소2', 'phone': '전화번호2'},
      {'name': '병원3', 'address': '주소3', 'phone': '전화번호3'},
      {'name': '병원4', 'address': '주소4', 'phone': '전화번호4'},
    ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411.4, 683.4),
      child: MaterialApp(
        title: "beautySearch",
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
                  barList: _beautyAppBar,
                  buttonHandler: _appBarList.beautyAppBarHandler),
              Container(
                width: 500.w,
                height: 485.h,
                margin:
                    EdgeInsets.symmetric(vertical: 1.0.h, horizontal: 20.0.w),
                decoration: BoxDecoration(
                  color: Color(0xFFD5BDAF),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Stack(
                  children: [
                    Positioned(
                        top:35.h,
                        child: Container(
                      //  color: Colors.blue,
                       height: 440.h,
                       width: 370.w,
                       child:Column(
                        children:<Widget> [
                       if (_hospitalList != null)
                      HospitalList(
                        hospitalList: _hospitalList!,
                      ),

                        ],

                       )
                      
                    )),
                    //selectBox부분 
                    Positioned(
                    
                      width: 200.w,
                      child: Container(
                      // color: Colors.red,
                      height: 300.h,
                       child: RegionSelectBox(onRegionSelected: _fetchHospitalList),
                     
                    ))
                  ],
                )
              ),
            ],
          ),
          bottomNavigationBar: CustomBottomNavigatorBar(page: 0),
        ),
      ),
    );
  }
}
