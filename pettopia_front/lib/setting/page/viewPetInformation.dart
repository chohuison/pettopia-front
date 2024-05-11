import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pettopia_front/Menu/CustomBottomNavigatorBar.dart';
import 'package:pettopia_front/setting/widget/ViewpetAddInfo.dart';
import 'package:pettopia_front/setting/widget/viewPetInfo.dart';

class ViewPetInformation extends StatefulWidget {
  const ViewPetInformation({Key? key}) : super(key: key);

  @override
  _ViewPetInformationState createState() => _ViewPetInformationState();
}

class _ViewPetInformationState extends State<ViewPetInformation> {
  // int _totalContainerHeight = 1000;
  // int _medicenContainerWidget = 190;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(411.4, 683.4),
        child: MaterialApp(
          title: "petAddInformation",
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: child!,
            );
          },
          home: Scaffold(
            backgroundColor: Color.fromRGBO(237, 237, 233, 1.0),
            body: ListView(
              children: [
                Container(
                  width: 400.w,
                  // height: _totalContainerHeight.h,
                  margin: EdgeInsets.fromLTRB(15.w, 10.h, 15.w, 10.h),
                  decoration: BoxDecoration(
                    color: Color(0xFFE3D5CA),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20.h,
                      ),
                      Center(
                        child: Text(
                          "반려동물 정보 조회하기",
                          style: TextStyle(
                              fontSize: 20.sp, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                          width: 350.w,
                          child: Positioned(
                              top: 15.h,
                              child: // 반려동물 정보
                                  Container(
                                width: 343.w,
                                // height: 410.h,
                                margin:
                                    EdgeInsets.fromLTRB(3.w, 10.h, 3.w, 10.h),
                                decoration: BoxDecoration(
                                  color: Color(0xFFF5EBE0),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: ViewPetInfo(),
                              ))),
                      Container(
                          width: 350.w,
                          child: Positioned(
                              top: 15.h,
                              child: // 추가 정보
                                  Container(
                                width: 343.w,
                                // height: 410.h,
                                margin:
                                    EdgeInsets.fromLTRB(3.w, 10.h, 3.w, 10.h),
                                decoration: BoxDecoration(
                                  color: Color(0xFFF5EBE0),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: ViewPetAddInfo(),
                              )))
                    ],
                  ),
                )
              ],
            ),
            bottomNavigationBar: CustomBottomNavigatorBar(page: 4),
          ),
        ));
  }
}
