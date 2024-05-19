import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pettopia_front/Menu/CustomBottomNavigatorBar.dart';

import 'package:pettopia_front/enum/LiveType.dart';
import 'package:pettopia_front/hospital/widget/petSeletBox.dart';
import 'package:pettopia_front/setting/widget/lifeStyleHablits.dart';
import 'package:pettopia_front/setting/widget/Eat.dart';
import 'package:pettopia_front/setting/widget/medicen.dart';

class PetAddInformation extends StatefulWidget {
  final List<Map<String, dynamic>> petList;
  const PetAddInformation({Key? key, required this.petList}) : super(key: key);

  @override
  _PetAddInformationState createState() => _PetAddInformationState();
}

class _PetAddInformationState extends State<PetAddInformation> {
  int _totalContainerHeight = 750;
  int _medicenContainerWidget = 190;
  late LiveType _enviorment = LiveType.TRUE;
  late LiveType? _exercise = LiveType.TRUE;
  late int? _eatCount = 0;
  late int? _snackCount = 0;
  late LiveType? _eatKind = LiveType.TRUE;
  late String _petName = widget.petList.first['dog_nm'];
  late int _petPk = widget.petList.first['pk'];
  //medicenName과 medicenCount가 null이 아니면 이것도 db에 넣어줄거임
  late String _mecidenName = "";
  late String _medicenCount = "";

  List<Map<String, dynamic>> _medicenWidgetValue = [];
  List<Widget> containerList = [];

  void _medecinHandler(String name, String count) {
    _mecidenName = name;
    _medicenCount = count;
  }

  void _petNameHandler(String value, int valuePk) {
    _petName = value;
    _petPk = valuePk;
  }

  void _addMedicen(int pk, String medicenName, String medicenCount) {
    setState(() {
      _medicenWidgetValue.add(
          {'pk': pk, 'medicenName': medicenName, 'medicenCount': medicenCount});
      _totalContainerHeight = _totalContainerHeight + 190;
      _medicenContainerWidget = _medicenContainerWidget + 190;
      containerList.add(_mecicenContainer(pk, medicenName, medicenCount));
    });
  }

  void _deleteMedicen(int pk) {
    setState(() {
      containerList.removeWhere((widget) {
        if (widget.key is ValueKey) {
          return (widget.key as ValueKey).value == pk;
        }
        return false;
      });
    });
    setState(() {
      _medicenWidgetValue.removeWhere((item) => item['pk'] == pk);
      _medicenContainerWidget = _medicenContainerWidget - 190;
      _totalContainerHeight = _totalContainerHeight - 190;
    });
  }

  void onHandleLifeStyleHablits(LiveType enviorment, LiveType exercise) {
    _enviorment = enviorment;
    _exercise = exercise;
  }

  void onHandleEat(String eatCount, LiveType eatKind, String snackCount) {
    _eatCount = int.parse(eatCount);
    _eatKind = eatKind;
    _snackCount = int.parse(snackCount);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411.4, 683.4),
      child: MaterialApp(
        title: "petAddInformation",
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: child!,
          );
        },
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Color.fromRGBO(237, 237, 233, 1.0),
          body: ListView(children: [
            Container(
                width: 400.w,
                height: _totalContainerHeight.h,
                margin: EdgeInsets.only(
                  left: 15.w,
                  right: 15.w,
                ),
                decoration: BoxDecoration(
                  color: Color(0xFFE3D5CA),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20.h,
                    ),
                    Center(
                      child: Text(
                        "반려동물 추가 정보 작성",
                        style: TextStyle(
                            fontSize: 20.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      height: 210.h,
                      width: 350.w,
                      child: Stack(
                        children: [
                          Positioned(
                            top: 45.h,
                            child: //생활 습관 컨테이너
                                Container(
                                    width: 343.w,
                                    height: 155.h,
                                    margin: EdgeInsets.only(
                                      // top: 5.h,
                                      left: 3.w,
                                      right: 15.w,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF5EBE0),
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: LifeStyleHabits(
                                        onHandleLifeStyleHabits:
                                            onHandleLifeStyleHablits)),
                          ),
                          Positioned(
                            child: Container(
                                height: 100.h,
                                width: 150.w,
                                // color: Colors.black,
                                child: PetSelectBox(
                                    onRegionSelected: _petNameHandler,
                                    petName: widget.petList)),
                          )
                        ],
                      ),
                    ),

                    //식사량 컨테이너
                    Container(
                        width: 350.w,
                        height: 210.h,
                        margin: EdgeInsets.only(
                            left: 15.w, top: 0.h, right: 15.w, bottom: 10.h),
                        decoration: BoxDecoration(
                          color: Color(0xFFF5EBE0),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Eat(
                          onHandleEat: onHandleEat,
                        )),
                    ...containerList,
                    //약 컨테이너
                    Container(
                        width: 350.w,
                        height: 210.h,
                        margin: EdgeInsets.only(
                            left: 15.w, top: 0.h, right: 15.w, bottom: 10.h),
                        decoration: BoxDecoration(
                          color: Color(0xFFF5EBE0),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Medicen(
                          onHandleMedicen: _medecinHandler,
                          addMedicen: _addMedicen,
                        )),

                    Container(
                      margin: EdgeInsets.only(top: 5.h),
                      width: 100.w,
                      height: 30.h,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 180, 178, 176),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFFAFA59B)),
                        ),
                        child: Center(
                          child: Text(
                            '등록',
                            style:
                                TextStyle(fontSize: 15.sp, color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ]),
          bottomNavigationBar: CustomBottomNavigatorBar(page: 4),
        ),
      ),
    );
  }

  Widget _typeContainer(String name) {
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

  Widget _mecicenContainer(int pk, String medicenName, String count) {
    return Container(
        key: ValueKey(pk),
        width: 350.w,
        height: 170.h,
        margin:
            EdgeInsets.only(left: 15.w, top: 0.h, right: 15.w, bottom: 10.h),
        decoration: BoxDecoration(
          color: Color(0xFFF5EBE0),
          borderRadius: BorderRadius.circular(25),
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
                children: <Widget>[_typeContainer("이름"), Text(medicenName)],
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                children: <Widget>[_typeContainer("투약 횟수"), Text(count)],
              ),
              _medicenDeleteButton(pk)
            ],
          ),
        ));
  }

  Widget _medicenDeleteButton(int pk) {
    return Container(
      height: 30.h,
      width: 100.w,
      margin: EdgeInsets.only(right: 20.w, top: 10.h),
      child: ElevatedButton(
        onPressed: () {
          _deleteMedicen(pk);
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFAFA59B)),
        ),
        child: Center(
          child: Text(
            '삭제',
            style: TextStyle(fontSize: 15.sp, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
