import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:pettopia_front/Menu/AppBar.dart';
import 'package:pettopia_front/enum/appBarList.dart';
import 'package:pettopia_front/Menu/CustomBottomNavigatorBar.dart';
import 'package:pettopia_front/hospital/page/shortWrite.dart';
import 'package:pettopia_front/hospital/page/viewRecords.dart';
import 'package:pettopia_front/hospital/widget/petSeletBox.dart';
import 'package:pettopia_front/hospital/widget/shortRecordBar.dart';

class ShortWriteValue extends StatefulWidget {
  final DateTime selectedDay;
  final List<String> petList;
  const ShortWriteValue(
      {Key? key, required this.selectedDay, required this.petList})
      : super(key: key);

  @override
  _ShortWriteValueState createState() => _ShortWriteValueState();
}

class _ShortWriteValueState extends State<ShortWriteValue>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  late List<Map<String, dynamic>> _hospitalAppBar;
  AppBarList _appBarList = AppBarList();
  @override
  void initState() {
    super.initState();

    _hospitalAppBar = _appBarList.getHospitalAppBar();
  }

  late String _petName = widget.petList.first;
  late String _type = "";
  late int _count = 0;
  late int _age = 0;

  void _petNameHandler(String value) {
    _petName = value;
  }

  void _typeHandler(String value) {
    _type = value;
  }

  void _countHandler(String value) {
    _count = int.parse(value);
  }

  void _ageHandler(String value) {
    _age = int.parse(value);
  }

  void _savedButton() {
    print("작동");
    print(_type);
    print(_count);
    print(_age);
  }

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
          resizeToAvoidBottomInset: false,
          backgroundColor: Color.fromRGBO(237, 237, 233, 1.0),
          body: Column(children: <Widget>[
            CustomAppBar(
                page: 1,
                barList: _hospitalAppBar,
                buttonHandler: _appBarList.hospitalAppBarHandler),
            Container(
                height: 485.h,
                width: 500.w,
                margin:
                    EdgeInsets.symmetric(vertical: 1.0.h, horizontal: 20.0.w),
                decoration: BoxDecoration(
                  color: Color(0xFFD5BDAF),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Container(
                    margin: EdgeInsets.only(
                        bottom: 30.h, right: 30.w, top: 50.h, left: 30.w),
                    height: 300.h,
                    child: Column(children: <Widget>[
                      Row(children: <Widget>[
                        _typeContainer("날짜",0),
                        Text(
                          "2024년 5월 1일",
                          style: TextStyle(fontSize: 17.sp),
                        ),
                      ]),
                      Container(
                        height: 120.h,
                        child: Stack(children: [
                          Positioned(
                            top: 50.h,
                            child: Container(
                              width: 300.w,
                              height: 70.h,
                              child: _textFieldContainer("종류", "접종 종류를 알려주세요 ",
                                  20, 10, _typeHandler, false,0),
                            ),
                          ),
                          //petSelctBox
                          Positioned(
                              child: Container(
                                  width: 300.w,
                                  height: 100.h,
                                  // color: Colors.blue,
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(
                                            right: 20.w,
                                            top: 20.h,
                                            bottom: 45.w),
                                        width: 80.w,
                                        height: 40.h,
                                        decoration: BoxDecoration(
                                          color: Color(0xFF9F8678),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "이름",
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                      PetSelectBox(
                                          onRegionSelected: _petNameHandler,
                                          petName: widget.petList)
                                    ],
                                  ))),
                        ]),
                      ),
                      _textFieldContainer(
                          "차시", "몇차 접종인지 알려주세요 ", 14, 10, _countHandler, true,10),
                      _textFieldContainer(
                          "나이", "정종 당시 나이를 알려주세요", 13, 10, _ageHandler, true,10),
                      _createButton(_savedButton),
                    ]))),
          ]),
          bottomNavigationBar: CustomBottomNavigatorBar(page: 1),
        ),
      ),
    );
  }
}

Widget _typeContainer(String containerName, int leftMargin) {
  return Container(
    margin: EdgeInsets.only(right: 20.w, top: 20.h, left:leftMargin.w),
    width: 80.w,
    height: 40.h,
    decoration: BoxDecoration(
      color: Color(0xFF9F8678),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Center(
      child: Text(
        containerName,
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    ),
  );
}

Widget _textFieldContainer(String containerName, String labelText,
    int horizontal, int vertical, Function contorller, bool isDigit, int leftMargin) {
  return Row(
    children: <Widget>[
      _typeContainer(containerName,leftMargin),
      Container(
          width: 170.w,
          child: TextField(
              onChanged: (text) {
                contorller(text);
              },
              keyboardType: isDigit ? TextInputType.number : null,
              decoration: InputDecoration(
                hintText: labelText,
                contentPadding: EdgeInsets.symmetric(
                    horizontal: horizontal.w, vertical: vertical.h),
                hintStyle: TextStyle(
                  fontSize: 11.0.sp,
                  color: Color(0xFFAFA59B),
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFD5BDAF)),
                ),
              ))),
    ],
  );
}

Widget _createButton(Function controller) {
  return Container(
    margin: EdgeInsets.only(top: 35.h),
    width: 150.w,
    height: 50.h,
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
          '등록',
          style: TextStyle(fontSize: 15.sp, color: Colors.black),
        ),
      ),
    ),
  );
}
