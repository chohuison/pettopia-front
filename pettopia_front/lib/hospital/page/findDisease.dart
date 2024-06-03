import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:pettopia_front/Menu/CustomBottomNavigatorBar.dart';
import 'package:pettopia_front/Menu/AppBar.dart';
import 'package:pettopia_front/enum/appBarList.dart';
import 'package:pettopia_front/hospital/widget/SimilarDiseaseList.dart';
import 'package:pettopia_front/hospital/widget/petSeletBox.dart';
import 'package:pettopia_front/server/AI.dart';

class FindDisease extends StatefulWidget {
  final List<Map<String, dynamic>> petList;
  const FindDisease({Key? key, required this.petList}) : super(key: key);

  @override
  _FindDiseaseState createState() => _FindDiseaseState();
}

class _FindDiseaseState extends State<FindDisease>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  late  Map<String,dynamic> _diseaseValue = {};

  late List<Map<String, dynamic>> _hospitalAppBar;
  AppBarList _appBarList = AppBarList();
  final aiServer = AI();
  late String _petName = widget.petList.first['dogNm'];
  late int _petPk =widget.petList.first['petPk'];

  @override
  void initState() {
    super.initState();

    _hospitalAppBar = _appBarList.getHospitalAppBar();
  }

  //ai랑 연결
  void _buttonController() async {
   Map<String,dynamic> _findDiseae =
        await aiServer.getPetDiseaseRecommendation(context,_petPk);
    
    if (mounted)
      setState(() {
        _diseaseValue = _findDiseae;
      });
  }

  void handlePetList(String petName, int petPk) {
    setState(() {
      _petName = petName;
      _petPk = petPk;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(392.7, 783.3),
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Find Disease",
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
                    page: 3,
                    barList: _hospitalAppBar,
                    buttonHandler: _appBarList.hospitalAppBarHandler),
                Container(
                    width: 500.w,
                    height: 485.h,
                    margin: EdgeInsets.symmetric(
                        vertical: 1.0.h, horizontal: 20.0.w),
                    decoration: BoxDecoration(
                      color: Color(0xFFE3D5CA),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top:15.h),
                          child: Row(
                          children: <Widget>[
                           PetSelectBox(
                                  onRegionSelected: handlePetList,
                                  petName: widget.petList),
                            _button(_buttonController),
                          ],
                        ),
                        ),
                       
                        Text("우리 아이와 비슷한 아이는 이런 지병이 있어요"),
                        if (_diseaseValue['breed'] != null)
                          SilimarDiseaseList(
                            diseaseValue: _diseaseValue!,
                          ),
                      ],
                    )),
              ],
            ),
            bottomNavigationBar: CustomBottomNavigatorBar(page: 1),
          ),
        );
      },
    );
  }
}

Widget _button(Function controller) {
  return Container(
    margin: EdgeInsets.only(left: 10.w, bottom: 20.w),
    width: 100.w,
    height: 30.h,
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
          '진단하기',
          style: TextStyle(fontSize: 13.sp, color: Colors.black),
        ),
      ),
    ),
  );
}
