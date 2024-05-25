import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pettopia_front/Menu/CustomBottomNavigatorBar.dart';
import 'package:pettopia_front/life/widget/cntBox.dart';
import 'package:intl/intl.dart';
import 'package:pettopia_front/life/widget/medicine.dart';
import 'package:pettopia_front/main.dart';
import 'package:pettopia_front/server/DB/Pet.dart';

class WriteDiary extends StatefulWidget {
  final DateTime date;
  final String name;
  final int pk;
  const WriteDiary(
      {Key? key, required this.date, required this.name, required this.pk})
      : super(key: key);

  @override
  _WriteDiaryState createState() => _WriteDiaryState();
}

class _WriteDiaryState extends State<WriteDiary>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  late DateTime _date;
  late String _name;
  late int _petPk;
  late int _mealCnt = 0;
  late int _snackCnt = 0;
  late int _walkCnt = 0;
  late String _mecidenName = "";
  late int _medicenCount = 0;
  late bool _isWalk = false;
  late bool _isMedicine = false;
  late int _defecationCondition = 0;
  late String _defecationDescription = "";
  late String _etc = "";
  late String errMesg = "";
  XFile? _file;
  String _profile = "";
  Pet _pet = Pet();

  List<Map<String, dynamic>> _medicenWidgetValue = [];
  List<Widget> containerList = [];

  @override
  void initState() {
    super.initState();
    _date = widget.date;
    _name = widget.name;
    _petPk = widget.pk;
  }

  void _mealCountHandle(int count) {
    setState(() {
      _mealCnt = count;
    });
  }

  void _snackCountHandle(int count) {
    setState(() {
      _snackCnt = count;
    });
  }

  void _medecinHandler(String name, int count) {
    setState(() {
      _mecidenName = name;
      _medicenCount = count;
    });
  }

  void _medecinCountHandle(int count) {
    setState(() {
      _medicenCount = count;
    });
  }

  void _addMedicine(int pk, String medicenName, int medicenCount) {
    print(medicenName);
    setState(() {
      _medicenWidgetValue.add(
          {'pk': pk, 'medicenName': medicenName, 'medicenCount': medicenCount});
      containerList.add(_medicineContainer(pk, medicenName, medicenCount));
    });
  }

  void _updateIsWalk(bool newValue) {
    setState(() {
      _isWalk = newValue;
    });
  }

  void _walkCountHandle(int count) {
    setState(() {
      _walkCnt = count;
    });
  }

  void _updateDefecation(int deficationCondition) {
    setState(() {
      _defecationCondition = deficationCondition;
    });
  }

  void _updateDefecationDes(String description) {
    setState(() {
      _defecationDescription = description;
    });
  }

  void _updateEtc(String etc) {
    _etc = etc;
  }

  void _updateIsMedicine(bool newValue) {
    setState(() {
      _isMedicine = newValue;
    });
  }

  Future<void> _saveButtonHandle() async {
    // if (_mealCnt == null ||
    //     _snackCnt == null ||
    //     _isWalk == null ||
    //     _defecationCondition == null) {
    //   setState(() {
    //     errMesg = "필수 입력값을 모두 입력해주세요!";
    //   });
    // } else {
    //   Map<String, dynamic> petInfo = {
    //     // 작성해야 함
    //   };
    //   if (_file != null) {
    //     _profile = await _pet.seUploat(_file!);
    //     petInfo['profile'] = _profile;
    //   }

    //   print(petInfo);
    //   _pet.createPet(petInfo);

    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (context) => MyApp()),
    //   );
    // }

    print("DateTime: " + _date.toString());
    print("Name: " + _name);
    print("PetPk: " + _petPk.toString());
    print("MealCnt: " + _mealCnt.toString());
    print("SnackCnt: " + _snackCnt.toString());
    print("WalkCnt: " + _walkCnt.toString());
    print("DefecationCondition: " + _defecationCondition.toString());
    print("DefecationDescription: " + _defecationCondition.toString());
    print("Etc: " + _etc.toString());
    print("medicine Value: " + _medicenWidgetValue.toString());

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyApp()),
    );
  }

  void _deleteMedicine(int pk) {
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
                    SizedBox(
                      height: 20.h,
                    ),
                    Center(
                      child: Text(
                        "다이어리 작성",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5.h, bottom: 15.h),
                      decoration: BoxDecoration(
                        color: Color(0xFFF5EBE0),
                        border: Border.all(
                          color: Color(0xFFD5BDAF),
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      width: 350.w,
                      child: Container(
                        margin:
                            EdgeInsets.only(top: 5.h, bottom: 5.h, left: 16.w),
                        child: Column(
                          children: <Widget>[
                            Container(
                                margin: EdgeInsets.only(top: 10.h, left: 10.w),
                                child: Row(
                                  children: <Widget>[
                                    _typeContainer("날짜"),
                                    Text(
                                        // DateFormat 쓰려면 flutter pub add intl 해야함
                                        DateFormat("yyyy년 MM월 dd일")
                                            .format(_date))
                                  ],
                                )),
                            Container(
                                margin: EdgeInsets.only(top: 10.h, left: 10.w),
                                child: Row(
                                  children: <Widget>[
                                    _typeContainer("이름"),
                                    Text(_name)
                                  ],
                                )),
                            Container(
                                margin: EdgeInsets.only(top: 10.h, left: 10.w),
                                child: Row(
                                  children: <Widget>[
                                    _typeContainer("밥 *"),
                                    CntBox(
                                      cnt: _mealCnt,
                                      handleCount: _mealCountHandle,
                                    )
                                  ],
                                )),
                            Container(
                                margin: EdgeInsets.only(top: 10.h, left: 10.w),
                                child: Row(
                                  children: <Widget>[
                                    _typeContainer("간식 *"),
                                    CntBox(
                                      cnt: _snackCnt,
                                      handleCount: _snackCountHandle,
                                    )
                                  ],
                                )),
                            //약
                            Container(
                              margin: EdgeInsets.only(top: 10.h, left: 10.w),
                              child: Column(
                                children: [
                                  Row(
                                    children: <Widget>[
                                      _typeContainer("약 *"),
                                      _radio(_isMedicine, _updateIsMedicine)
                                    ],
                                  ),
                                  ...containerList,
                                  if (_isMedicine == true)
                                    Medicine(
                                        onHandleMedicine: _medecinHandler,
                                        addMedicine: _addMedicine),
                                ],
                              ),
                            ),

                            Container(
                                margin: EdgeInsets.only(top: 10.h, left: 10.w),
                                child: Row(
                                  children: <Widget>[
                                    _typeContainer("산책 *"),
                                    _radio(_isWalk, _updateIsWalk)
                                  ],
                                )),
                            if (_isWalk)
                              CntBox(
                                cnt: _walkCnt,
                                handleCount: _walkCountHandle,
                              ),
                            Container(
                                margin: EdgeInsets.only(top: 10.h, left: 10.w),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    _typeContainer("배변 *"),
                                    _defecationRadio(_defecationCondition,
                                        _updateDefecation),
                                  ],
                                )),
                            _defecationDes(
                                _defecationDescription, _updateDefecationDes),
                            Container(
                              margin: EdgeInsets.only(top: 10.h, left: 10.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _typeContainer("기타"),
                                  _etcBox(_etc, _updateEtc)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // 등록 버튼
                    Container(
                      margin: EdgeInsets.only(bottom: 15.h),
                      width: 100.w,
                      height: 30.h,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 180, 178, 176),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: ElevatedButton(
                        onPressed: _saveButtonHandle,
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
                ),
              )
            ],
          ),
          bottomNavigationBar: CustomBottomNavigatorBar(page: 3),
        ),
      ),
    );
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

  Widget _radio(bool isSelectO, Function(bool) updateFunction) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Row(
          children: [
            Row(
              children: [
                Radio<bool>(
                  activeColor: Color.fromARGB(255, 151, 133, 122),
                  value: true,
                  groupValue: isSelectO,
                  onChanged: (bool? value) {
                    updateFunction(value!);
                  },
                ),
                Text('O'),
              ],
            ),
            Row(
              children: [
                Radio<bool>(
                  activeColor: Color.fromARGB(255, 151, 133, 122),
                  value: false,
                  groupValue: isSelectO,
                  onChanged: (bool? value) {
                    updateFunction(value!);
                  },
                ),
                Text('X'),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _defecationRadio(int defication, Function(int) updateCondition) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 30.h,
              child: Row(
                children: [
                  Radio<int>(
                    activeColor: Color.fromARGB(255, 151, 133, 122),
                    value: 0,
                    groupValue: defication,
                    onChanged: (int? value) {
                      updateCondition(value!);
                    },
                  ),
                  Text('정상'),
                ],
              ),
            ),
            Container(
              height: 30.h,
              child: Row(
                children: [
                  Radio<int>(
                    activeColor: Color.fromARGB(255, 151, 133, 122),
                    value: 1,
                    groupValue: defication,
                    onChanged: (int? value) {
                      updateCondition(value!);
                    },
                  ),
                  Text('문제 있음'),
                ],
              ),
            ),
            Container(
              height: 30.h,
              child: Row(
                children: [
                  Radio<int>(
                    activeColor: Color.fromARGB(255, 151, 133, 122),
                    value: 2,
                    groupValue: defication,
                    onChanged: (int? value) {
                      updateCondition(value!);
                    },
                  ),
                  Text('배변 X'),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _defecationDes(String description, Function(String) updateDes) {
    return Container(
      margin: EdgeInsets.only(left: 90.w, right: 10.w),
      width: 170.w,
      child: TextField(
        onChanged: (text) {
          updateDes(text);
        },
        textAlign: TextAlign.center,
        decoration: InputDecoration(
            hintText: "배변 상태를 입력해주세요.",
            hintStyle: TextStyle(
              fontSize: 13.sp,
              color: Color(0xFFAFA59B),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFD5BDAF)),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFD5BDAF)),
            )),
      ),
    );
  }

  Widget _etcBox(String etc, Function(String) updateEtc) {
    return Container(
      margin: EdgeInsets.only(top: 10.h, right: 20.w, bottom: 10.h),
      width: 300.w,
      child: TextField(
        onChanged: (text) {
          updateEtc(text);
        },
        maxLines: null,
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFD5BDAF)),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFD5BDAF)),
                borderRadius: BorderRadius.all(Radius.circular(15)))),
      ),
    );
  }

  Widget _medicineContainer(int pk, String name, int count) {
    return Container(
        margin: EdgeInsets.only(left: 100.w, bottom: 10.h),
        key: ValueKey(pk),
        child: Row(
          children: [
            Container(
                margin: EdgeInsets.only(left: 10.w, right: 10.w),
                child: Text(name)),
            Container(
                margin: EdgeInsets.only(left: 10.w, right: 10.w),
                child: Text(count.toString() + "회")),
            _medicenDeleteButton(pk)
          ],
        ));
  }

  Widget _medicenDeleteButton(int pk) {
    return Container(
      height: 30.h,
      width: 80.w,
      margin: EdgeInsets.only(right: 20.w),
      child: ElevatedButton(
        onPressed: () {
          _deleteMedicine(pk);
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
