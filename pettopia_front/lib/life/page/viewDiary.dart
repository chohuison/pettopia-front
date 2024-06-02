import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:pettopia_front/Menu/CustomBottomNavigatorBar.dart';
import 'package:pettopia_front/life/widget/ModifyDiary.dart';
import 'package:pettopia_front/main.dart';
import 'package:pettopia_front/server/DB/Diary.dart';

class ViewDiary extends StatefulWidget {
  final DateTime date;
  final String name;
  final int pk;
  final Map<String, dynamic> diaryValue;

  final int diaryPk;
  const ViewDiary(
      {Key? key,
      required this.date,
      required this.name,
      required this.pk,
      required this.diaryValue,
      required this.diaryPk})
      : super(key: key);

  @override
  _ViewDiaryState createState() => _ViewDiaryState();
}

class _ViewDiaryState extends State<ViewDiary>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  late DateTime _date;
  late String _name;
  late int _petPk;
  late String _mealCount = widget.diaryValue['mealCont'].toString() + "회";
  late String _snackCount = widget.diaryValue['snackCnt'].toString() + "회";
  late String _walkCnt = widget.diaryValue['walkCnt'].toString() + "회";
  late String _conditionOfDefecation =
      _getConditionOfDefecation(widget.diaryValue['conditionOfDefecation']);
  late String _defecationText = widget.diaryValue['defecationText'];
  late String _etc = widget.diaryValue['etc'];
  late List<dynamic> _medicenList = widget.diaryValue['medicineList']['list'];
  Diary _diaryServer = Diary();

  String _getConditionOfDefecation(String value) {
    if (value == "NORMAL") {
      return "정상";
    } else if (value == "PROBLEM") {
      return "문제 있음";
    } else {
      return "배변 x";
    }
  }

  @override
  void initState() {
    super.initState();
    _date = widget.date;
    _name = widget.name;
    _petPk = widget.pk;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411.42857142857144, 683.4285714285714),
      child: MaterialApp(
           debugShowCheckedModeBanner: false ,
        title: "writeDiary",
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: child!,
          );
        },
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Color.fromRGBO(237, 237, 233, 1.0),
          body: ListView(
            children: [
              Container(
                width: 400.w,
                margin: EdgeInsets.all(15.w),
                decoration: BoxDecoration(
                  color: Color(0xFFE3D5CA),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.h),
                    Center(
                      child: Column(
                        children: [
                          Text(
                            DateFormat("yyyy년 MM월 dd일").format(_date),
                            style: TextStyle(fontSize: 20.sp),
                          ),
                          Text(
                            _name + "의 일기",
                            style: TextStyle(fontSize: 17.sp),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10.h, bottom: 15.h),
                      decoration: BoxDecoration(
                        color: Color(0xFFF5EBE0),
                        border: Border.all(
                          color: Color(0xFFD5BDAF),
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      width: 350.w,
                      child: Container(
                        margin:
                            EdgeInsets.only(top: 5.h, bottom: 5.h, left: 16.w),
                        child: Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 10.h, left: 10.w),
                              child: Row(
                                children: <Widget>[
                                  _typeContainer("밥"),
                                  Text(
                                    _mealCount,
                                    style: TextStyle(fontSize: 15.sp),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: 10.h, left: 10.w, bottom: 10.w),
                              child: Row(
                                children: <Widget>[
                                  _typeContainer("간식"),
                                  Text(
                                    _snackCount,
                                    style: TextStyle(fontSize: 15.sp),
                                  ),
                                ],
                              ),
                            ),
                            if (_medicenList.length > 0)
                              ..._medicenList.map((medicine) {
                                return _mecicenContainer(medicine['name'],
                                    medicine['cnt'].toString());
                              }).toList(),
                            Container(
                              margin: EdgeInsets.only(top: 10.h, left: 10.w),
                              child: Row(
                                children: <Widget>[
                                  _typeContainer("산책"),
                                  Text(
                                    _walkCnt,
                                    style: TextStyle(fontSize: 15.sp),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10.h, left: 10.w),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  _typeContainer("배변"),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _conditionOfDefecation,
                                        style: TextStyle(fontSize: 15.sp),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 10.h),
                                        child: Text(
                                          _defecationText,
                                          style: TextStyle(fontSize: 13.sp),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10.h, left: 10.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _typeContainer("기타"),
                                  Container(
                                    constraints:
                                        BoxConstraints(minHeight: 80.h),
                                    margin: EdgeInsets.only(
                                        top: 10.h, right: 20.w, bottom: 10.h),
                                    width: 300.w,
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Color(0xFFD5BDAF)),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Container(
                                      margin: EdgeInsets.all(10.h),
                                      child: Text(_etc),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[_button("수정"), _button("삭제")],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: CustomBottomNavigatorBar(page: 3),
        ),
      ),
    );
  }

  Widget _typeMedicenContainer(String name) {
    return Container(
        width: 80.w,
        height: 30.h,
        margin: EdgeInsets.only(
          right: 10.w,
        ),
        decoration: BoxDecoration(
          color: Color(0xFFD5BDAF),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Center(
            child: Text(
          name,
        )));
  }

  Widget _mecicenContainer(String medicenName, String count) {
    return Container(
        width: 400.w,
        height: 150.h,
        margin:
            EdgeInsets.only(left: 15.w, top: 0.h, right: 15.w, bottom: 10.h),
        decoration: BoxDecoration(
          color: Color(0xFFF5EBE0),
          borderRadius: BorderRadius.circular(40),
          border: Border.all(
            color: Color(0xFFD5BDAF), // 테두리 색
            width: 2.0, // 테두리 두께
          ),
        ),
        child: Container(
          margin: EdgeInsets.only(top: 20.h, left: 37.w),
          child: Column(
            children: [
              Text(
                "약",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
              ),
              Row(
                children: <Widget>[
                  _typeMedicenContainer("이름"),
                  Center(child: Text(medicenName))
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                children: <Widget>[
                  _typeMedicenContainer("투약 횟수"),
                  Center(child: Text(count))
                ],
              ),
            ],
          ),
        ));
  }

  Widget _typeContainer(String name) {
    return Container(
        width: 80.w,
        height: 30.h,
        margin: EdgeInsets.only(right: 15.w),
        decoration: BoxDecoration(
          color: Color(0xFFD5BDAF),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Center(
            child: Text(
          name,
        )));
  }

  Widget _button(String name) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.h),
      width: 100.w,
      height: 30.h,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 180, 178, 176),
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: ElevatedButton(
        onPressed: () async {
          if (name == "수정") {
            List<Map<String, dynamic>> medicenList =
                await _diaryServer.getMedicenList(context,_petPk);
            print("medicenList: $medicenList");
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ModifyDiary(
                        name: _name,
                        pk: _petPk,
                        diaryValue: widget.diaryValue,
                        medicenList: medicenList,
                        diaryPk: widget.diaryPk,
                      )),
            );
          } else if (name == "삭제") {
            await _diaryServer.deleteDiary(context,widget.diaryPk);
           
          }
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFAFA59B)),
        ),
        child: Center(
          child: Text(
            name,
            style: TextStyle(fontSize: 15.sp, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
