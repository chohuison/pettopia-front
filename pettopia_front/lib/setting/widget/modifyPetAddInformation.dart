import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pettopia_front/Menu/CustomBottomNavigatorBar.dart';

import 'package:pettopia_front/hospital/widget/petSeletBox.dart';
import 'package:pettopia_front/main.dart';
import 'package:pettopia_front/server/DB/Pet.dart';
import 'package:pettopia_front/setting/widget/ModifyLifeStyleHabits.dart';
import 'package:pettopia_front/setting/widget/ModifyPetEat.dart';
import 'package:pettopia_front/setting/widget/lifeStyleHablits.dart';
import 'package:pettopia_front/setting/widget/Eat.dart';
import 'package:pettopia_front/setting/widget/medicen.dart';

class ModifyPetAddInformation extends StatefulWidget {
  final int petPk;
  final Map<String, dynamic> petAddInfo;
  final List<dynamic> medicen;
  const ModifyPetAddInformation(
      {Key? key,
      required this.petPk,
      required this.medicen,
      required this.petAddInfo})
      : super(key: key);

  @override
  _ModifyPetAddInformationState createState() =>
      _ModifyPetAddInformationState();
}

class _ModifyPetAddInformationState extends State<ModifyPetAddInformation> {
  late int _enviorment = 0;
  late int _exercise = 0;
  late int _eatCount = 0;
  late int _snackCount = 0;
  late int _eatKind = 0;
  late String _mecidenName = "";
  late String _medicenCount = "";
  int widgetPk = 0;

  List<Map<String, dynamic>> _medicenWidgetValue = [];
  List<Widget> containerList = [];
  List<Map<String, dynamic>> _requestMedicineList = [];
  List<dynamic> _medicenList = [];
  Pet _petServer = Pet();

  @override
  void initState() {
    super.initState();
    _enviorment = widget.petAddInfo['environment'];
    _exercise = widget.petAddInfo['exercise'];

    _eatCount = widget.petAddInfo['foodCnt'];
    _snackCount = widget.petAddInfo['foodKind'];
    _eatKind = widget.petAddInfo['snackCnt'];
    _medicenList = widget.medicen;
    for (dynamic medicen in _medicenList) {
      containerList.add(_mecicenContainer(
          widgetPk, medicen['name'], medicen['cnt'].toString()));
      _medicenWidgetValue.add({
        'pk': widgetPk,
        'name': medicen['name'],
        'cnt': medicen['cnt'].toString()
      });
      widgetPk++;
    }
  }

  void _medecinHandler(String name, String count) {
    setState(() {
      _mecidenName = name;
      _medicenCount = count;
    });
  }

  void _addMedicen(int pk, String medicenName, String medicenCount) {
    setState(() {
      _medicenWidgetValue
          .add({'pk': pk, 'name': medicenName, 'cnt': medicenCount});

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
    });
  }

  void onHandleLifeStyleHablits(int enviorment, int exercise) {
    _enviorment = enviorment;
    _exercise = exercise;
  }

  void onHandleEat(String eatCount, int eatKind, String snackCount) {
    _eatCount = int.parse(eatCount);
    _eatKind = eatKind;
    _snackCount = int.parse(snackCount);
    print(_eatCount);
    print(_eatKind);
    print(_snackCount);
  }

  void _saveButton() {
    if (_medicenWidgetValue.length > 0) {}
    for (Map<String, dynamic> value in _medicenWidgetValue) {
      _requestMedicineList
          .add({'name': value['name'], 'cnt': int.parse(value['cnt'])});
    }
    print(_mecidenName);
    print(_medicenCount);
    if (_mecidenName != "" && _medicenCount != "") {
      _requestMedicineList
          .add({'name': _mecidenName, 'cnt': int.parse(_medicenCount)});
    }
    Map<String, dynamic> data = {
      'petExtraInfo': {
        'environment': _enviorment,
        'exercise': _exercise,
        'foodCnt': _eatCount,
        'foodKind': _eatKind,
        'snackCnt': _snackCount,
      },
         'requestMedicineList':{
        'list': _requestMedicineList.length > 0 ? _requestMedicineList : [],
      }
    };
    print(data);
    _petServer.modifyAddPetInfo(data, widget.petPk);
     Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyApp()),
      );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411.42857142857144, 683.4285714285714),
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
          body: Container(
            decoration: BoxDecoration(
              color: Color(0xFFE3D5CA),
              borderRadius: BorderRadius.circular(25),
            ),
            width: 400.w,
            margin: EdgeInsets.all(15.w),
            child: ListView(children: [
              SizedBox(
                height: 20.h,
              ),
              Center(
                child: Text(
                  "반려동물 추가 정보 수정",
                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                ),
              ),
              //생활습관 컨테이너
              Container(
                  width: 310.w,
                  height: 155.h,
                  margin: EdgeInsets.only(right: 15.w, left: 15.w, top: 5.h),
                  decoration: BoxDecoration(
                    color: Color(0xFFF5EBE0),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: ModifyLifeStyleHabits(
                      petAddInfo: widget.petAddInfo,
                      onHandleLifeStyleHabits: onHandleLifeStyleHablits)),
              //식사량 컨테이너
              Container(
                  width: 350.w,
                  height: 210.h,
                  margin: EdgeInsets.only(
                      left: 15.w, top: 10.h, right: 15.w, bottom: 10.h),
                  decoration: BoxDecoration(
                    color: Color(0xFFF5EBE0),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: ModfiyEat(
                    petAddInfo: widget.petAddInfo,
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
                margin: EdgeInsets.only(
                    top: 5.h, bottom: 10.h, right: 120.w, left: 120.w),
                width: 100.w,
                height: 30.h,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 180, 178, 176),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    _saveButton();
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xFFAFA59B)),
                  ),
                  child: Center(
                    child: Text(
                      '등록',
                      style: TextStyle(fontSize: 15.sp, color: Colors.black),
                    ),
                  ),
                ),
              ),
            ]),
          ),
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
