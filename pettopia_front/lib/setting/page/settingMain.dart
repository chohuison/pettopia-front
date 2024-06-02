import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:pettopia_front/Menu/CustomBottomNavigatorBar.dart';
import 'package:pettopia_front/server/DB/Pet.dart';
import 'package:pettopia_front/server/DB/Users.dart';
import 'package:pettopia_front/server/DB/jwt.dart';
import 'package:pettopia_front/setting/page/createPet.dart';
import 'package:pettopia_front/setting/page/login.dart';
import 'package:pettopia_front/setting/page/petAddInformation.dart';
import 'package:pettopia_front/setting/page/viewPetInformation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pettopia_front/setting/widget/creatPetCheckPopup.dart';
import 'package:pettopia_front/setting/widget/createPetAddInfoPopup.dart';
import 'package:pettopia_front/setting/widget/petInfoCheckPopup.dart';

class SettingMain extends StatefulWidget {
  const SettingMain({Key? key}) : super(key: key);

  @override
  _SettingMainhState createState() => _SettingMainhState();
}

class _SettingMainhState extends State<SettingMain> {
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();
  List<Map<String, dynamic>> _petList = [];
  Map<String, dynamic> _petInfo = {};
  Map<String, dynamic> _petAddInfo = {};
  List<dynamic> _medicenList = [];
  int _height = 800;
  JWT _jwt = JWT();
  Users users = Users();

  Pet _petServer = Pet();
  Future<void> _getList() async {
    _petList = await _petServer.getPetList(context);
  }

  Future<void> _getPetInfo() async {
    _petInfo = await _petServer.getPetInfo(context,_petList.first['petPk']);
  }

  Future<void> _getPetAddInfo() async {
    Map<String, dynamic> petAddExtraInfo =
        await _petServer.getAddPetInfo(context,_petList.first['petPk']);
    _petAddInfo = petAddExtraInfo['petExtraInfo'];
    _medicenList = petAddExtraInfo['responseMedicineList']['list'];
    _height = _medicenList.length * 160 + 800;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411.42857142857144, 683.4285714285714),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "settingMain",
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
                //여기 나중에 펫토피아 글씨 로고 넣기
                Container(
                    margin: EdgeInsets.only(left: 17.w, top: 60.h),
                    width: 240.w,
                    height: 80.h,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/img/txtLogo.png')))),
                Container(
                    margin: EdgeInsets.only(left: 12.w, top: 10.h),
                    child: Text("설정", style: TextStyle(fontSize: 20.sp))),
                Container(
                  margin: EdgeInsets.only(
                      left: 25.w, right: 25.w, top: 12.h, bottom: 15.h),
                  height: 2.h,
                  color: Color(0xFFD5BDAF),
                ),
                _buildContainer(context, "반려동물 추가/ 등록하기", 0),
                _buildContainer(context, "반려동물 추가 정보 작성", 1),
                _buildContainer(context, "반려동물 정보 조회하기", 2),
                _buildContainer(context, "로그아웃", 3),
              ],
            ),
          ),
          bottomNavigationBar: CustomBottomNavigatorBar(page: 4),
        ),
      ),
    );
  }

  Widget _buildContainer(BuildContext context, String name, int index) {
    return Container(
      margin: EdgeInsets.only(left: 25.w, right: 25.w, bottom: 15.h),
      width: 500.w,
      height: 70.h,
      decoration: BoxDecoration(
        color: Color(0xFFF5EBE0),
        border: Border.all(
          color: Color(0xFFD5BDAF),
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: ElevatedButton(
        onPressed: () async {
          if (index == 0) {
   
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: PetInfoCheckPopup(),
                  surfaceTintColor: Colors.white,
                );
              },
            );
          } else if (index == 1) {
            // //추가 정보 작성이 가능한 펫들만 넘겨주기 위해
            String? jsonData = await _secureStorage.read(key: 'pet');
            if (jsonData != null) {
              List<dynamic> petInfoList = await jsonDecode(jsonData);
              if (petInfoList.length < 1) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: CreatePetCheckPopup(),
                      surfaceTintColor: Colors.white,
                    );
                  },
                );
              } else {
                List<Map<String, dynamic>> canAddInfoPetList = [];
                for (Map<String, dynamic> value in petInfoList) {
                  if (value['isAddInfo'] == false) {
                    canAddInfoPetList
                        .add({'petPk': value['pk'], 'dogNm': value['dogNm']});
                  }
                }
                print("canAddInfoPetList");
                print(canAddInfoPetList);
                if (canAddInfoPetList.length > 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PetAddInformation(
                              petList: canAddInfoPetList,
                            )),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: CreatePetAddInfoPopup(),
                        surfaceTintColor: Colors.white,
                      );
                    },
                  );
                }
              }
            } else {
              print("여기 걸림");
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: CreatePetCheckPopup(),
                    surfaceTintColor: Colors.white,
                  );
                },
              );
            }
          } else if (index == 2) {
            await _getList();
            if (_petList.length < 1) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: CreatePetCheckPopup(),
                    surfaceTintColor: Colors.white,
                  );
                },
              );
            } else {
              await _getPetInfo();
              await _getPetAddInfo();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ViewPetInformation(
                            petList: _petList,
                            petInfo: _petInfo,
                            petAddInfo: _petAddInfo,
                            medicen: _medicenList,
                            height: _height,
                          )));
            }
          } else if (index == 3) {
            await _secureStorage.deleteAll();
            await users.logoutKakao();
              Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
          }
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFF5EBE0)),
        ),
        child: Center(
          child: Text(
            name,
            style: TextStyle(fontSize: 20.sp, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
