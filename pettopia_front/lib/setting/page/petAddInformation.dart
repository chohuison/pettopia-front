import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pettopia_front/Menu/CustomBottomNavigatorBar.dart';


import 'package:pettopia_front/hospital/widget/petSeletBox.dart';
import 'package:pettopia_front/main.dart';
import 'package:pettopia_front/server/DB/Pet.dart';
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

  late int _enviorment = 0;
  late int? _exercise = 0;
  late String _eatCount = "";
  late String _snackCount = "";
  late int? _eatKind = 0;
  late String _petName = widget.petList.first['dogNm'];
  late int _petPk = widget.petList.first['petPk'];
  //medicenName과 medicenCount가 null이 아니면 이것도 db에 넣어줄거임 
  late String _mecidenName = "";
  late String _medicenCount = "";
  String errorMessage = "";

  List<Map<String, dynamic>> _medicenWidgetValue = [];
  List<Widget>containerList=[];
  List<Map<String,dynamic>> _requestMedicineList = [];
  Pet _petServer = Pet();
  void _medecinHandler(String name, String count) {
    setState(() {
         _mecidenName = name;
    _medicenCount = count;
 
    });
 
  }

  void _petNameHandler(String value, int valuePk) {
    _petName = value;
    _petPk = valuePk;
  }

  void _addMedicen(int pk, String medicenName, String medicenCount) {
    setState(() {
       _medicenWidgetValue.add({'pk':pk,'name': medicenName, 'cnt':medicenCount});

   containerList.add(_mecicenContainer(pk,medicenName,medicenCount));
   _mecidenName="";
   _medicenCount="";

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
    _eatCount = eatCount;
    _eatKind = eatKind;
    _snackCount = snackCount;
  }

  void _saveButton(){

    if(_medicenWidgetValue.length >0){

    }for(Map<String,dynamic> value in _medicenWidgetValue ){
   _requestMedicineList.add({'name':value['name'], 'cnt': int.parse(value['cnt'])});
   
    }
    print(_mecidenName);
    print(_medicenCount);
    if(_mecidenName != "" && _medicenCount!="" ){
       _requestMedicineList.add({'name':_mecidenName, 'cnt': int.parse(_medicenCount)});
    }

   Map<String, dynamic> data = {
      'petExtraInfo': {
        'environment': _enviorment,
        'exercise': _exercise,
        'foodCnt': int.parse(_eatCount),
        'foodKind': _eatKind,
        'snackCnt': int.parse(_snackCount),
      },
         'requestMedicineList':{
        'list': _requestMedicineList.length > 0 ? _requestMedicineList : [],
      }
    };
  print(data);
    _petServer.createAddPet(data, _petPk,context);
        Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyApp()),
      );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(392.7272727273, 783.2727272727),
      child: MaterialApp(
           debugShowCheckedModeBanner: false ,
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
                                      width: 330.w,
                                      height: 155.h,
                                      margin: EdgeInsets.only(
                                        // top: 5.h,
                                        left: 15.w,
                                        // right: 20.w
                                      
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
                          child: Medicen(onHandleMedicen: _medecinHandler, addMedicen:_addMedicen,)),
            
                      Container(
                        margin: EdgeInsets.only(top: 5.h, bottom: 20.h, left:120.w, right:120.w),
                        width: 100.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 180, 178, 176),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: ElevatedButton(
                          onPressed: () {_saveButton();},
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
Center(
  child: Text(errorMessage, style: TextStyle(color: Colors.red),),
)
                    
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
