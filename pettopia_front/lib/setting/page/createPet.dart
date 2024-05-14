import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pettopia_front/Menu/CustomBottomNavigatorBar.dart';
import 'package:pettopia_front/enum/LiveType.dart';
import 'package:pettopia_front/setting/widget/createPetInformationValue.dart';
import 'package:pettopia_front/setting/widget/createPetParentValue.dart';

class CreatePet extends StatefulWidget {
  const CreatePet({Key? key}) : super(key: key);

  @override
  _CreatePetState createState() => _CreatePetState();
}

class _CreatePetState extends State<CreatePet> {
  late String _breed = "";
  late String _petNumber = "";
  late String _petName = "";
  late String _birth = "";
  late LiveType _fur = LiveType.TRUE;
  late LiveType _sex = LiveType.TRUE;
  late LiveType _neutering = LiveType.TRUE;
  late String _parentName = "";
  late String _parentPhoneNum = "";

  void onHandlePetInformation(String petNum, String petName, String breed,
      LiveType fur, LiveType sex, LiveType _neutering, String birth) {
    _petNumber = petNum;
    _petName = petName;
    _breed = breed;
    _fur = fur;
    _sex = sex;
    _neutering = _neutering;
    _birth = birth;
  }

  void petParentValueHandle(String parentName, String parentPhoneNum) {
    _parentName = parentName;
    _parentPhoneNum = parentPhoneNum;
  }

//여기 나중에 저장버튼
  void _saveButtonHandle() {
    print(_petNumber);
    print(_petName);
    print(_breed);
    print(_fur);
    print(_sex);
    print(_birth);
    print(_neutering);
    print(_parentName);
    print(_parentPhoneNum);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411.4, 683.4),
      child: MaterialApp(
        title: "createPet",
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
              width: 400.w,
              height: 600.h,
              margin: EdgeInsets.only(
                  left: 15.w, top: 15.h, right: 15.w, bottom: 15.h),
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
                      "반려동물 추가 / 등록하기",
                      style: TextStyle(
                          fontSize: 20.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                  //반려동물 정보 콘테이너
                  Container(
                    margin: EdgeInsets.only(top: 5.h),
                    decoration: BoxDecoration(
                      color: Color(0xFFF5EBE0),
                      border: Border.all(
                        color: Color(0xFFD5BDAF),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    width: 350.w,
                    height: 380.h,
                    child: CreatePetInformation(
                      onHandlePetInformation: onHandlePetInformation,
                    ),
                  ),
                  //보호자 정보 콘테이너
                  Container(
                      margin: EdgeInsets.only(top: 5.h),
                      decoration: BoxDecoration(
                        color: Color(0xFFF5EBE0),
                        border: Border.all(
                          color: Color(0xFFD5BDAF),
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: CreatePetParentValue(
                          petParentValueHandle: petParentValueHandle),
                      width: 350.w,
                      height: 105.h),
                  //등록 버튼
                  Container(
                    margin: EdgeInsets.only(top: 5.h),
                    width: 100.w,
                    height: 30.h,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 180, 178, 176),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        _saveButtonHandle();
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Color(0xFFAFA59B)),
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
          bottomNavigationBar: CustomBottomNavigatorBar(page: 4),
        ),
      ),
    );
  }
}
