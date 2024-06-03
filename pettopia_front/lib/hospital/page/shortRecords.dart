import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:pettopia_front/Menu/AppBar.dart';
import 'package:pettopia_front/enum/appBarList.dart';
import 'package:pettopia_front/Menu/CustomBottomNavigatorBar.dart';
import 'package:pettopia_front/hospital/page/shortWrite.dart';
import 'package:pettopia_front/hospital/page/viewRecords.dart';

import 'package:pettopia_front/hospital/widget/shortRecordBar.dart';

class ShortRecords extends StatefulWidget {
  const ShortRecords({Key? key}) : super(key: key);

  @override
  _ShortRecordshState createState() => _ShortRecordshState();
}

class _ShortRecordshState extends State<ShortRecords>
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

  int _index = 0;

  int _getIndex(int index) {
    _index = index;
    return index;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(392.7272727273, 783.2727272727),
      child: MaterialApp(
           debugShowCheckedModeBanner: false ,
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
                height: 550.h,
                width: 500.w,
                margin:
                    EdgeInsets.symmetric(vertical: 1.0.h, horizontal: 20.0.w),
                decoration: BoxDecoration(
                  color: Color(0xFFE3D5CA),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(10.0),
                    height: 40.h,
                    // color:Colors.blue,
                    child: ShortRecordBar(
                      indexNum: _index,
                      index: (index) {
                        setState(() {
                          _index = _getIndex(index);
                        });
                      },
                    ),
                  ),
                  Container(height: 420.h, child: buildWidget(_index))
                ])),
          ]),
          bottomNavigationBar: CustomBottomNavigatorBar(page: 1),
        ),
      ),
    );
  }
}

Widget buildWidget(int index) {
  switch (index) {
    case 1:
      return ShortWrite();
    case 2:
      return ViewRecords();
    default:
      return Container(); // 기본적으로 빈 컨테이너를 반환하거나 다른 처리를 수행할 수 있습니다.
  }
}
