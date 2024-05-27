import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:pettopia_front/Menu/CustomBottomNavigatorBar.dart';
import 'package:pettopia_front/enum/appBarList.dart';
import 'package:pettopia_front/Menu/AppBar.dart';
import 'package:pettopia_front/life/widget/breedBar.dart';

import 'package:pettopia_front/life/widget/tipList.dart';
import 'package:pettopia_front/life/widget/breedSelectBox.dart';
import 'package:pettopia_front/server/DB/Tip.dart';

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
  String _selectedBreed="";
  String _tipCategory="";
  int breedPk =0;
  Tip _tipServer = Tip();
  void _fetchBreedList(String selectedBreed) {
    print(selectedBreed);
    setState(() {
    _selectedBreed =selectedBreed;
    if(selectedBreed == "강아지"){
      breedPk=1;
   
    
    }else{
      breedPk=2;
    }
       _tipList=[];
    });
  }

  String getTipCategory(int index){
    if(index ==1 ){
      return "DANGEROUSFOOD";
    }
    else if (index == 2){
      return "DYSTROPY";
    }
    else if (index ==3){
      return "VACCINATION";
    }
    else{
      return "TRAINING";
    }
  }


  bool _isSelected = false;
  int _index = 0;

  Future<void> _getIndex(int index)async {
    _index = index;
    String tipCategory = getTipCategory(index);
    List<Map<String,dynamic>> list = await _tipServer.getTip(breedPk, tipCategory);
    setState(() {
      _tipList=list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(411.42857142857144, 683.4285714285714),
        child: MaterialApp(
             debugShowCheckedModeBanner: false ,
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
                                                  _getIndex(index);
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
                                  height: 380.h,
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
