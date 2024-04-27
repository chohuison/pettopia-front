import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:pettopia_front/Menu/CustomBottomNavigatorBar.dart';
import 'package:pettopia_front/Menu/hospitalAppBar.dart';
import 'package:pettopia_front/enum/appBarList.dart';

class FindDisease extends StatefulWidget {
  const FindDisease({Key? key}) : super(key: key);

  @override
  _FindDiseaseState createState() => _FindDiseaseState();
}

class _FindDiseaseState extends State<FindDisease>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  late List<Map<String, dynamic>> _hospitalAppBar;

  @override
  void initState() {
    super.initState();
    AppBarList _appBarList = AppBarList();
    _hospitalAppBar = _appBarList.getHospitalAppBar();
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
                HospitalAppBar(page: 3, barList: _hospitalAppBar),
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
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: 25.w, right: 25.w, top: 9.h, bottom: 15.h),
                          height: 2.h,
                          color:  Color(0xFFD5BDAF),
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
