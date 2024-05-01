import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pettopia_front/Menu/CustomBottomNavigatorBar.dart';

import 'package:pettopia_front/enum/LiveType.dart';
import 'package:pettopia_front/setting/widget/lifeStyleHablits.dart';


class PetAddInformation extends StatefulWidget {
  const PetAddInformation({Key? key}) : super(key: key);

  @override
  _PetAddInformationState createState() => _PetAddInformationState();
}

class _PetAddInformationState extends State<PetAddInformation> {

  late LiveType _enviorment = LiveType.TRUE;
   late LiveType? _exercise=LiveType.TRUE;

   void onHandleLifeStyleHablits(LiveType enviorment, LiveType exercise){
    _enviorment = enviorment;
    _exercise = exercise;
  }

  
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
          resizeToAvoidBottomInset: false,
          backgroundColor: Color.fromRGBO(237, 237, 233, 1.0),
          body: Container(
              width: 400.w,
              height: 600.h,
              margin: EdgeInsets.only(
                  left: 15.w, top: 15.h, right: 15.w, bottom: 15.h),
              decoration: BoxDecoration(
                color: Color(0xFFE3D5CA),
                borderRadius: BorderRadius.circular(25),
              ),
              child:Column(
                children: <Widget>[
                   SizedBox(
                    height: 20.h,
                  ),
                  Center(
                    child: Text(
                      "반려동물 추가 정보 작성",
                      style: TextStyle(
                          fontSize: 20.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                  //셀렉트 박스
                  Container(
                    width:100.w,
                    height:35.h,
                    color: Colors.black,
                  ),
                  //생활 습관 컨테이너
                  Container(
                     width: 350.w,
              height: 125.h,
              margin: EdgeInsets.only(
                  left: 15.w, top: 15.h, right: 15.w, bottom: 10.h),
              decoration: BoxDecoration(
                color: Color(0xFFF5EBE0),
                borderRadius: BorderRadius.circular(25),
              ),
              child:LifeStyleHabits(onHandleLifeStyleHabits:onHandleLifeStyleHablits)
                  ),
                  //식사량 컨테이너
                      Container(
                     width: 350.w,
              height: 165.h,
              margin: EdgeInsets.only(
                  left: 15.w, top: 0.h, right: 15.w, bottom: 10.h),
              decoration: BoxDecoration(
                color: Color(0xFFF5EBE0),
                borderRadius: BorderRadius.circular(25),
              ),
                  ),
                  //약 컨테이너
                    Container(
                     width: 350.w,
              height: 125.h,
              margin: EdgeInsets.only(
                  left: 15.w, top: 0.h, right: 15.w, bottom: 5.h),
              decoration: BoxDecoration(
                color: Color(0xFFF5EBE0),
                borderRadius: BorderRadius.circular(25),
              ),
                  ),
                     Container(
                    margin: EdgeInsets.only(top: 5.h),
                    width: 100.w,
                    height: 30.h,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 180, 178, 176),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Color(0xFFAFA59B)),
                      ),
                      child: Center(
                        child: Text(
                          '등록',
                          style:
                              TextStyle(fontSize: 15.sp, color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              )
          ),
          bottomNavigationBar: CustomBottomNavigatorBar(page: 4),
        ),
      ),
    );
  }
}
