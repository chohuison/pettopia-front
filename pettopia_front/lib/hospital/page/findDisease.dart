import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:pettopia_front/Menu/CustomBottomNavigatorBar.dart';
import 'package:pettopia_front/Menu/AppBar.dart';
import 'package:pettopia_front/enum/appBarList.dart';
import 'package:pettopia_front/hospital/widget/SimilarDiseaseList.dart';
import 'package:pettopia_front/server/AI.dart';

class FindDisease extends StatefulWidget {
  const FindDisease({Key? key}) : super(key: key);

  @override
  _FindDiseaseState createState() => _FindDiseaseState();
}

class _FindDiseaseState extends State<FindDisease>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  late List<Map<String, dynamic>>? _diseaseList = [];

  late List<Map<String, dynamic>> _hospitalAppBar;
  AppBarList _appBarList = AppBarList();
  final aiServer = AI();

  @override
  void initState() {
    super.initState();

    _hospitalAppBar = _appBarList.getHospitalAppBar();
  }

  //ai랑 연결
  void _buttonController() {
    setState(() {
      _diseaseList = [
        {'name': '쯔쯔가무시'},
        {'name': '사마귀'},
        {'name': '아토피'},
      ];
    });
    aiServer.getPetDiseaseRecommendation();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411.4, 683.4),
      builder: (context, child) {
        return MaterialApp(
          title: "Find Disease",
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
                    page: 3,
                    barList: _hospitalAppBar,
                    buttonHandler: _appBarList.hospitalAppBarHandler),
                Container(
                    width: 500.w,
                    height: 485.h,
                    margin: EdgeInsets.symmetric(
                        vertical: 1.0.h, horizontal: 20.0.w),
                    decoration: BoxDecoration(
                      color: Color(0xFFD5BDAF),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                            margin: EdgeInsets.symmetric(vertical: 10.0.h),
                            width: 340.w,
                            height: 80.h,
                            decoration: BoxDecoration(
                              color: Color(0xFFF5EBE0),
                              borderRadius: BorderRadius.circular(35),
                            ),
                            child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 20.0.w, vertical: 5.0.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "잠깐!",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 17.sp, color: Colors.red),
                                    ),
                                    Text("아직 우리 아이의 정보를 등록하지 않으셧다면?"),
                                    Text("반려 동물 정보 등록하기",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 13.sp,
                                            color: Color(0xFF3013E1)))
                                  ],
                                ))),
                        _button(_buttonController),
                        Container(
                          margin: EdgeInsets.only(
                              left: 25.w, right: 25.w, top: 9.h, bottom: 15.h),
                          height: 2.h,
                          color: Color.fromARGB(255, 200, 180, 167),
                        ),
                        Text("우리 아이는 이런 질병을 조심해 주세요"),
                        if (_diseaseList != null)
                          SilimarDiseaseList(
                            diseaseList: _diseaseList!,
                          ),
                      ],
                    )),
              ],
            ),
            bottomNavigationBar: CustomBottomNavigatorBar(page: 1),
          ),
        );
      },
    );
  }
}

Widget _button(Function controller) {
  return Container(
    margin: EdgeInsets.only(top: 3.h),
    width: 100.w,
    height: 30.h,
    decoration: BoxDecoration(
      color: Color.fromARGB(255, 180, 178, 176),
      borderRadius: BorderRadius.circular(30.0),
    ),
    child: ElevatedButton(
      onPressed: () {
        controller();
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFAFA59B)),
      ),
      child: Center(
        child: Text(
          '진단하기',
          style: TextStyle(fontSize: 13.sp, color: Colors.black),
        ),
      ),
    ),
  );
}
