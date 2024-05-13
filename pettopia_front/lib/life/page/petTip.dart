import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:pettopia_front/Menu/CustomBottomNavigatorBar.dart';
import 'package:pettopia_front/enum/appBarList.dart';
import 'package:pettopia_front/Menu/AppBar.dart';
import 'package:pettopia_front/life/widget/breedBar.dart';

import 'package:pettopia_front/life/widget/tipList.dart';
import 'package:pettopia_front/life/widget/breedSelectBox.dart';

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

  // ToDo
  // DB에서 tip List 가져오도록 수정해야 함
  var _tipList;
  void _fetchBreedList(String selectedBreed) {
    setState(() {
      _tipList = [
        {'tip': 'tip1'},
        {'tip': 'tip2'},
        {'tip': 'tip3'},
        {'tip': 'tip4'},
      ];
    });
  }

  bool _isSelected = false;
  int _index = 0;

  int _getIndex(int index) {
    _index = index;
    return index;
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
                      child: Stack(
                        children: [
                          Positioned(
                              top: 35.h,
                              // category button
                              child: Container(
                                  //color: Colors.blue,
                                  margin: EdgeInsets.fromLTRB(0, 25.h, 0, 20.h),
                                  height: 50.h,
                                  width: 370.w,
                                  child: Container(
                                    child: Column(
                                      children: <Widget>[
                                        if (_tipList != null)
                                          TipBar(
                                            indexNum: _index,
                                            index: (index) {
                                              setState(
                                                () {
                                                  _isSelected = true;
                                                  _index = _getIndex(index);
                                                },
                                              );
                                            },
                                          ),
                                      ],
                                    ),
                                  ))),
                          // selectBox
                          Positioned(
                              width: 200.w,
                              child: Container(
                                // color: Colors.red,
                                height: 150.h,
                                child: BreedSelectBox(
                                    onRegionSelected: _fetchBreedList),
                              )),
                          //ToDo
                          //카테고리 별로 나오도록 만들어야됨
                          Positioned(
                              top: 80.h,
                              // tip list
                              child: Container(
                                  //color: Colors.blue,
                                  margin: EdgeInsets.fromLTRB(0, 25.h, 0, 0),
                                  height: 400.h,
                                  width: 370.w,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: <Widget>[
                                        if (_isSelected)
                                          TipList(
                                            breed: _index,
                                            tipList: _tipList,
                                          )
                                      ],
                                    ),
                                  ))),
                        ],
                      ))
                ],
              ),
              bottomNavigationBar: CustomBottomNavigatorBar(page: 3),
            )));
  }
}
