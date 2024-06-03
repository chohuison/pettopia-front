import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pettopia_front/hospital/page/shortRecords.dart';
import 'package:pettopia_front/server/DB/ShotRecords.dart';

class CreateDiaryCheckPopup extends StatefulWidget {
  const CreateDiaryCheckPopup({Key? key, }) : super(key: key);

  _CreateDiaryCheckPopupState createState() => _CreateDiaryCheckPopupState();
}

class _CreateDiaryCheckPopupState extends State<CreateDiaryCheckPopup> {

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(392.7272727273, 783.2727272727),
      child: MaterialApp(
        builder: (context, child) {
          //전체 창 크기 조절 이걸로 하면됨 !
          return SizedBox(
            height: 250.h,
        
            child: child,
          );
        },
        home: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close))
            ],
          ),
          body: Container(
            child: Column(
              children: [
                  SizedBox(
                  height: 20.h,
                ),
        
                Center(
                  child: Text(
                    "해당날짜에",
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                  ),
                ),
                Center(
                  child: Text(
                    "작성한 다이어리가 존재하지 않습니다.",
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 40.h,
                ),
                  Container(
                // margin: EdgeInsets.only(
                //     top: 5.h, bottom: 10.h, right: 120.w, left: 120.w),
                width: 100.w,
                height: 30.h,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 180, 178, 176),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: ElevatedButton(
                  onPressed: () {
                  Navigator.pop(context);
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xFFAFA59B)),
                  ),
                  child: Center(
                    child: Text(
                      '확인',
                      style: TextStyle(fontSize: 15.sp, color: Colors.black),
                    ),
                  ),
                ),
              ),
        
              ],
            ),
          ),
        ),
      ),
    );
  }
}
