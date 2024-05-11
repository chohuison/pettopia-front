import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:pettopia_front/Menu/CustomBottomNavigatorBar.dart';
import 'package:pettopia_front/enum/appBarList.dart';
import 'package:pettopia_front/Menu/AppBar.dart';

class PetTip extends StatefulWidget {
  const PetTip({Key? key}) : super(key: key);

  @override
  _PetTipState createState() => _PetTipState();
}

class _PetTipState extends State<PetTip> with AutomaticKeepAliveClientMixin {
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
            title: "petTip",
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: child!,
              );
            },
            home: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Color.fromRGBO(237, 237, 233, 1.0),
              bottomNavigationBar: CustomBottomNavigatorBar(page: 1),
              body: Column(
                children: <Widget>[
                  CustomAppBar(
                      page: 1,
                      barList: _lifeAppBar,
                      buttonHandler: _appBarList.lifeAppBarHandler),
                  Container(
                    width: 500.w,
                    height: 485.h,
                    margin: EdgeInsets.symmetric(
                        vertical: 1.0.h, horizontal: 20.0.w),
                    decoration: BoxDecoration(
                      color: Color(0xFFE3D5CA),
                      borderRadius: BorderRadius.circular(25),
                    ),
                  )
                ],
              ),
            )));
  }
}
