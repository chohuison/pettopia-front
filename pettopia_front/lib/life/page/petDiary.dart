import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pettopia_front/Menu/AppBar.dart';
import 'package:pettopia_front/Menu/CustomBottomNavigatorBar.dart';
import 'package:pettopia_front/enum/appBarList.dart';
import 'package:pettopia_front/hospital/widget/calendar.dart';
import 'package:pettopia_front/life/widget/diaryWidget.dart';
import 'package:pettopia_front/server/DB/Pet.dart';

class PetDiary extends StatefulWidget {
  final List<Map<String, dynamic>> petList;
  const PetDiary({Key? key, required this.petList}) : super(key: key);

  @override
  _PetDiaryState createState() => _PetDiaryState();
}

class _PetDiaryState extends State<PetDiary>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  late List<Map<String, dynamic>> _lifeAppBar;
  AppBarList _appBarList = AppBarList();

  @override
  void initState() {
    super.initState();

    _lifeAppBar = _appBarList.getLifeAppBar();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(411.4, 683.4),
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
              body: Column(
                children: <Widget>[
                  CustomAppBar(
                      page: 2,
                      barList: _lifeAppBar,
                      buttonHandler: _appBarList.lifeAppBarHandler),
                  Container(
                    height: 485.h,
                    width: 500.w,
                    margin: EdgeInsets.symmetric(
                        vertical: 1.0.h, horizontal: 20.0.w),
                    decoration: BoxDecoration(
                      color: Color(0xFFE3D5CA),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: DiaryWidget(
                      petList: widget.petList,
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: CustomBottomNavigatorBar(page: 3),
            )));
  }
}
