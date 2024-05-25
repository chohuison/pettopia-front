import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:pettopia_front/Menu/CustomBottomNavigatorBar.dart';

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
                            style: TextStyle(fontSize: 22.sp),
                          ),
                          Text(
                            _name + "의 일기",
                            style: TextStyle(fontSize: 17.sp),
                          )
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
