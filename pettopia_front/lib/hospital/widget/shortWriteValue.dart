import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:pettopia_front/Menu/hospitalAppBar.dart';
import 'package:pettopia_front/enum/appBarList.dart';
import 'package:pettopia_front/Menu/CustomBottomNavigatorBar.dart';
import 'package:pettopia_front/hospital/page/shortWrite.dart';
import 'package:pettopia_front/hospital/page/viewRecords.dart';
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

class _ShortWriteValueState extends State<ShortWriteValue> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;


 late List<Map<String,dynamic>> _hospitalAppBar;
  @override
  void initState() {
    super.initState();

  AppBarList _appBarList= AppBarList();
_hospitalAppBar=_appBarList.getHospitalAppBar();
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
            HospitalAppBar(page: 1, barList: _hospitalAppBar),
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
                        _typeContainer("날짜"),
                        Text(
                          "2024년 5월 1일",
                          style: TextStyle(fontSize: 17.sp),
                        ),
                      ]),
                      _selectBox(widget.petList, _petName, _petNameHandler),
                      _textFieldContainer(
                          "종류", "접종 종류를 알려주세요 ", 20, 10, _typeHandler, false),
                      _textFieldContainer(
                          "차시", "몇차 접종인지 알려주세요 ", 14, 10, _countHandler, true),
                      _textFieldContainer(
                          "나이", "정종 당시 나이를 알려주세요", 13, 10, _ageHandler, true),
                      _createButton(_savedButton),
                    ]))),
          ]),
          bottomNavigationBar: CustomBottomNavigatorBar(page: 1),
        ),
      ),
    );
  }
}

Widget _typeContainer(String containerName) {
  return Container(
    margin: EdgeInsets.only(right: 20.w, top: 20.h),
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

Widget _selectBox(List<String> list, String listValue, Function controller) {
  return Row(
    children: <Widget>[
      _typeContainer("이름"),
      Container(
        width: 150.w,
        height: 30.h,
        child: DropdownButtonFormField<String>(
          itemHeight: 50.h,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 1,
              ),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
          value: listValue,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "이름을 선택해주세요";
            }
            return null;
          },
          onChanged: (String? value) {
            if (controller != null) {
              controller!(value);
            }
          },
          items: list.map<DropdownMenuItem<String>>((String eachValue) {
            return DropdownMenuItem<String>(
              value: eachValue,
              child: Container(
                height: 50.h,
                child: Text(eachValue, style: TextStyle(fontSize: 10.sp)),
              ),
            );
          }).toList(),
        ),
      ),
    ],
  );
}

Widget _textFieldContainer(String containerName, String labelText,
    int horizontal, int vertical, Function contorller, bool isDigit) {
  return Row(
    children: <Widget>[
      _typeContainer(containerName),
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
