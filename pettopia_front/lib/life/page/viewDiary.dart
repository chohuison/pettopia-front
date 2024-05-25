import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:pettopia_front/Menu/CustomBottomNavigatorBar.dart';
import 'package:pettopia_front/life/page/modifyDiary.dart';

class ViewDiary extends StatefulWidget {
  final DateTime date;
  final String name;
  final int pk;
  const ViewDiary(
      {Key? key, required this.date, required this.name, required this.pk})
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

  @override
  void initState() {
    super.initState();
    _date = widget.date;
    _name = widget.name;
    _petPk = widget.pk;
  }

  // ToDo: _modify, _delete
  Future<void> _modify() async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ModifyDiary()));
  }

  Future<void> _delete() async {}

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411.4, 683.4),
      child: MaterialApp(
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
                          )
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
                                    "2회",
                                    style: TextStyle(fontSize: 15.sp),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10.h, left: 10.w),
                              child: Row(
                                children: <Widget>[
                                  _typeContainer("간식"),
                                  Text(
                                    "1회",
                                    style: TextStyle(fontSize: 15.sp),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10.h, left: 10.w),
                              child: Row(
                                children: <Widget>[
                                  _typeContainer("약"),
                                  Text(
                                    "구충제 3회",
                                    style: TextStyle(fontSize: 15.sp),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10.h, left: 10.w),
                              child: Row(
                                children: <Widget>[
                                  _typeContainer("산책"),
                                  Text(
                                    "1회",
                                    style: TextStyle(fontSize: 15.sp),
                                  )
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
                                        "배변 X",
                                        style: TextStyle(fontSize: 15.sp),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 10.h),
                                        child: Text(
                                          "변비 예상",
                                          style: TextStyle(fontSize: 13.sp),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10.h, left: 10.w),
                              child: Row(
                                children: <Widget>[
                                  _typeContainer("산책"),
                                  Text(
                                    "1회",
                                    style: TextStyle(fontSize: 15.sp),
                                  )
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
                                        new BoxConstraints(minHeight: 80.h),
                                    margin: EdgeInsets.only(
                                        top: 10.h, right: 20.w, bottom: 10.h),
                                    width: 300.w,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(0xFFD5BDAF)),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Container(
                                        margin: EdgeInsets.all(10.h),
                                        child: Text("test")),
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
                        children: <Widget>[
                          _button("수정", _modify),
                          _button("삭제", _delete)
                        ],
                      ),
                    )
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

Widget _button(String name, Function buttonFunc) {
  return Container(
    margin: EdgeInsets.only(bottom: 15.h),
    width: 100.w,
    height: 30.h,
    decoration: BoxDecoration(
      color: Color.fromARGB(255, 180, 178, 176),
      borderRadius: BorderRadius.circular(30.0),
    ),
    child: ElevatedButton(
      onPressed: () {
        buttonFunc;
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
