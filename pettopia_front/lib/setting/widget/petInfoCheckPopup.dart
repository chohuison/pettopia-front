import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pettopia_front/enum/PetBreedList.dart';
import 'package:pettopia_front/hospital/page/shortRecords.dart';
import 'package:pettopia_front/server/DB/Pet.dart';
import 'package:pettopia_front/server/DB/ShotRecords.dart';
import 'package:pettopia_front/setting/page/createPet.dart';

class PetInfoCheckPopup extends StatefulWidget {
  const PetInfoCheckPopup({
    Key? key,
  }) : super(key: key);

  _PetInfoCheckPopupState createState() => _PetInfoCheckPopupState();
}

class _PetInfoCheckPopupState extends State<PetInfoCheckPopup> {
  Map<String, dynamic> _petInfo = {};
  String _dogRegNo = "";
  String _ownerName = "";
  String _errorMessage = "";
  Pet _petServer = Pet();
  PetBreedList _petBreedList = PetBreedList();

  void _handlePetInfo() async {
    if (_dogRegNo == "" || _ownerName == "") {
      setState(() {
        _errorMessage = "반려동물 등록 번호와 주인 이름 둘 다 모두 입력해주세요";
      });
    } else {
      Map<String, dynamic> petInfo =
          await _petServer.getAPIPetInfo(context, _dogRegNo, _ownerName);
      setState(() {
        _petInfo = petInfo;
      });
      if (petInfo['dogRegNo'] != null) {
        Map<String, dynamic> species =
            _petBreedList.getSpeciesByPetInfo(petInfo['kindNm']);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CreatePet(
                    petInfo: petInfo,
                    parentName: _ownerName,
                    speciesName: species['speciesName'],
                    speciesPk: species['pk'],
                  )),
        );
      } else {
        setState(() {
          _errorMessage = "일치하는 정보가 없습니다. 수동 등록 해주세요";
        });
      }
    }
  }

  void _createPetHandler() {
    List<Map<String, dynamic>> species = _petBreedList.getSpecies();
    String speciesName = species.first['speciesName'];
    print("수동 등록");
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CreatePet(
                petInfo: {},
                parentName: _ownerName,
                speciesName: speciesName,
                speciesPk: 1,
              )),
    );
  }

  void _dogRegNoController(String value) {
    _dogRegNo = value;
  }

  void _ownerNameController(String value) {
    _ownerName = value;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(392.7272727273, 783.2727272727),
      child: MaterialApp(
           debugShowCheckedModeBanner: false,
        builder: (context, child) {
          //전체 창 크기 조절 이걸로 하면됨 !
          return SizedBox(
            height: 430.h,
            width: 320.w,
            child: child,
          );
        },
        home: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close))
            ],
          ),
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 5.h,
                  ),
                  Center(
                    child: Text(
                      "반려동물 등록증을",
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Center(
                    child: Text(
                      "만드셨습니까 ?",
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10.h),
                    child: Column(
                      children: [
                        _textFieldContainer("반려동물\n등록번호", "반려동물 등록번호를 입력해주세요",
                            _dogRegNoController),
                        _textFieldContainer(
                            "보호자 이름", "보호자 이름을 입력해주세요", _ownerNameController),
                      ],
                    ),
                  ),
                  Text(
                    _errorMessage,
                    style: TextStyle(color: Colors.red),
                  ),
                  _button("정보 조회하기", _handlePetInfo),
                  SizedBox(
                    height: 10.h,
                  ),
                  _button("수동 등록하기", _createPetHandler),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _typeContainer(String name) {
    return Container(
        width: 80.w,
        height: 60.h,
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

  Widget _textFieldContainer(
      String containerName, String labelText, Function contorller) {
    return Container(
        margin: EdgeInsets.only(top: 5.h, bottom: 5.h),
        width: 320.w,
        height: 70.h,
        child: Row(
          children: <Widget>[
            _typeContainer(containerName),
            Container(
                width: 160.w,
                child: TextField(
                    onChanged: (text) {
                      contorller(text);
                    },
                    decoration: InputDecoration(
                      hintText: labelText,
                      hintStyle: TextStyle(
                        fontSize: 13.0.sp,
                        color: Color(0xFFAFA59B),
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFD5BDAF)),
                      ),
                    ))),
          ],
        ));
  }

  Widget _button(String buttonName, Function funtion) {
    return Container(
      // margin: EdgeInsets.only(
      //     top: 5.h, bottom: 10.h, right: 120.w, left: 120.w),
      width: 200.w,
      height: 30.h,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 180, 178, 176),
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: ElevatedButton(
        onPressed: () {
          funtion();
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFAFA59B)),
        ),
        child: Center(
          child: Text(
            buttonName,
            style: TextStyle(fontSize: 15.sp, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
