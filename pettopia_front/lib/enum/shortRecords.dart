import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pettopia_front/Menu/CustomBottomNavigatorBar.dart';
import 'package:pettopia_front/hospital/widget/hospitalAppbar.dart';


class ShortRecords extends StatefulWidget {
  const ShortRecords({Key? key}) : super(key: key);

  @override
  _ShortRecordshState createState() => _ShortRecordshState();
}

class _ShortRecordshState extends State<ShortRecords> {

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411.4, 683.4),
      child: MaterialApp(
        title: "shortRecords",
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: child!,
          );
        },
        home: Scaffold(
          backgroundColor: Color.fromRGBO(237, 237, 233, 1.0),
          body:Column(
            children: <Widget>[
              HospitalAppBar(page: 1),
               Container(
                height: 485.h,
                
                margin:
                    EdgeInsets.symmetric(vertical: 1.0.h, horizontal: 20.0.w),
                decoration: BoxDecoration(
                  color: Color(0xFFD5BDAF),
                  borderRadius: BorderRadius.circular(25),
                ),
            
          padding: EdgeInsets.fromLTRB(20.w, 10.h, 0.w, 10.h),
      
        ),
              ]),
             
          bottomNavigationBar: CustomBottomNavigatorBar(page: 1),
        ),
      ),
    );
  }
}

