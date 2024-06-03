import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pettopia_front/enum/PetBreedList.dart';
import 'package:pettopia_front/server/DB/Pet.dart';

import 'package:pettopia_front/setting/widget/speciesSelectBox.dart';

class ModifyPetInformation extends StatefulWidget {
  final Function(String, String, String, String, int, int, int, int, String)
      onHandlePetInformation;
  final Map<String, dynamic> petInfo;
  final int petPk;
  const ModifyPetInformation({
    Key? key,
    required this.onHandlePetInformation,
    required this.petInfo,
    required this.petPk,
  }) : super(
          key: key,
        );

  @override
  _ModifyPetInformationState createState() => _ModifyPetInformationState();
}

class _ModifyPetInformationState extends State<ModifyPetInformation>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  late List<Map<String, dynamic>> _speciesList = [];
  late String _species = "";
  String _petNumber = "";
  String _petName = "";
  String _birth = "";
  late int _fur = 0;
  late int _sex = 0;
  late int _neutering = 0;
  PetBreedList _petBreedList = PetBreedList();
  late int _speciesPk = 1;
  late String _widght = "";
  XFile? _file;
  String _profile = "";
  int _breedPk = 1;
  String _breedName = "";
  String _wight = "";
  Pet _petServer = Pet();

  @override
  void initState() {
    super.initState();
    _breedPk = _petBreedList.findSpeciesPk(widget.petInfo['speciesName']);
    _petNumber = widget.petInfo['dogRegNo'];
    _petName = widget.petInfo['dogNm'];
    _birth = widget.petInfo['birth'].toString();
    _fur = widget.petInfo['hair'];
    _neutering = widget.petInfo['neuterYn'] == true ? 0 : 1;
    _sex = widget.petInfo['sexNm'] == true ? 0 : 1;
    _wight = widget.petInfo['weight'].toString();
    _profile = widget.petInfo['profile'];
    _speciesList = _petBreedList.getSpecies();
    _breedName = _petBreedList.speciesNameByPk(_breedPk);
  }

  void _onFurUpdate(int value) {
    setState(() {
      _fur = value;
    });
    widget.onHandlePetInformation(_profile, _petNumber, _petName, _wight,
        _breedPk, _fur, _sex, _neutering, _birth);
  }

  void _onWightUpdate(String value) {
    setState(() {
      _wight = value;
    });
    widget.onHandlePetInformation(_profile, _petNumber, _petName, _wight,
        _breedPk, _fur, _sex, _neutering, _birth);
  }

  void _onSexUpdate(int value) {
    setState(() {
      _sex = value;
    });
    print(_sex);
    widget.onHandlePetInformation(_profile, _petNumber, _petName, _wight,
        _breedPk, _fur, _sex, _neutering, _birth);
  }

  void _onnNuteringUpdate(int value) {
    setState(() {
      _neutering = value;
    });
    widget.onHandlePetInformation(_profile, _petNumber, _petName, _wight,
        _breedPk, _fur, _sex, _neutering, _birth);
  }

  void onSeleted(String value, int pk) {
    setState(() {
      _species = value;
      _breedPk = pk;
    });
    print(value);
    print(pk);
    print(_species);
    print(_speciesPk);
    widget.onHandlePetInformation(_profile, _petNumber, _petName, _wight,
        _breedPk, _fur, _sex, _neutering, _birth);
  }

  void _petNumberController(String value) {
    setState(() {
      _petNumber = value;
    });

    widget.onHandlePetInformation(_profile, _petNumber, _petName, _wight,
        _speciesPk, _fur, _sex, _neutering, _birth);
  }

  void _petNameController(String value) {
    setState(() {
      _petName = value;
    });
    print(_petName);

    widget.onHandlePetInformation(_profile, _petNumber, _petName, _widght,
        _breedPk, _fur, _sex, _neutering, _birth);
  }

  void _birthController(String value) {
    setState(() {
      _birth = value;
    });

    widget.onHandlePetInformation(_profile, _petNumber, _petName, _wight,
        _breedPk, _fur, _sex, _neutering, _birth);
  }

       Future<void> _getCamera() async {
    ImagePicker().pickImage(source: ImageSource.camera).then((image) async {
      if (image != null) {
        setState(() {
          _file = image;
        });
        String imagUrl = await _petServer.s3Upload(context, _file!, widget.petPk);
    setState(() {
      _profile = "";
      print(_profile);
  
      _profile =    _profile = '$imagUrl?${DateTime.now().millisecondsSinceEpoch}'; 
      print(_profile);
    });

    widget.onHandlePetInformation(_profile, _petNumber, _petName, _wight,
        _speciesPk, _fur, _sex, _neutering, _birth);
      }
    });
  }


  Future<void> _getGallery() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage == null) {
      return;
    }

    setState(() {
      _file = pickedImage;
    });
    String imagUrl = await _petServer.s3Upload(context, _file!, widget.petPk);
    setState(() {
      _profile = "";
      print(_profile);
  
      _profile =    _profile = '$imagUrl?${DateTime.now().millisecondsSinceEpoch}'; 
      print(_profile);
    });

    widget.onHandlePetInformation(_profile, _petNumber, _petName, _wight,
        _speciesPk, _fur, _sex, _neutering, _birth);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      SizedBox(
        height: 5.h,
      ),
      Center(
          child: Text("반려동물 정보",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.sp))),
      //사진등록부분
      Container(
          width: 300.w,
          height: 80.h,
          child: Row(
            children: <Widget>[
              //여기 나중에 강아지 프로필
              Container(
                margin: EdgeInsets.only(left: 17.w, top: 16.h),
                width: 60.w,
                height: 60.h,
                child: _profile != "" ? Image.network(_profile, key: UniqueKey()) : Container(),
                decoration: BoxDecoration(
                  // color: Colors.blue, // Background color of the container
                  border: Border.all(
                    color: Color(0xFFD5BDAF),
                    width: 2.0, // Border width
                  ),
                  borderRadius: BorderRadius.circular(10.0), // Rounded corners
                ),
              ),
              Container(
                  margin: EdgeInsets.only(left: 50.w, top: 20.h),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 5.h),
                        width: 150.w,
                        height: 25.h,
                        child: ElevatedButton(
                          onPressed: () {
                            _getCamera();
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xFFAFA59B)),
                          ),
                          child: Text(
                            "촬영하기",
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 150.w,
                        height: 25.h,
                        child: ElevatedButton(
                          onPressed: () async {
                            await _getGallery();
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xFFAFA59B)),
                          ),
                          child: Text(
                            "겔러리에서 가져오기",
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ))
            ],
          )),
      //아래 세부 입력 사항
      Container(
          margin: EdgeInsets.only(top: 5.h, bottom: 5.h, left: 16.w),
          child: Column(
            children: <Widget>[
              _textFieldContainer(
                  "번호*", _petNumber, 0, 10, _petNumberController, false),
              _textFieldContainer(
                  "이름*", _petName, 30, 10, _petNameController, false),
              _textFieldContainer("몸무게*", _wight, 30, 10, _onWightUpdate, true),
              Container(
                height: 150.h,
                margin: EdgeInsets.only(left: 18.w),
                child: Stack(
                  children: [
                    Positioned(
                        top: 40.h,
                        child: Container(
                            child: Column(
                          children: <Widget>[
                            _radio("단장모*", "단모", "장모", _fur, _onFurUpdate, 10),
                            _radio("성별*", "남", "여", _sex, _onSexUpdate, 22),
                            _radio("중성화*", "O", "X", _neutering!,
                                _onnNuteringUpdate, 24),
                          ],
                        ))),
                    Positioned(
                        child: Container(
                      // width:400.w,
                      height: 95.h,
                      // color: Colors.blue,
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(bottom: 60.h),
                            width: 90.w,
                            height: 30.h,
                            child: _typeContainer("품종*"),
                          ),
                          SpeciesSelectBox(
                            onSpeciesSelected: onSeleted,
                            petName: _speciesList,
                            petPk: _breedPk,
                            petNameValue: _breedName,
                          )
                        ],
                      ),
                    )),
                  ],
                ),
              ),
              _textFieldContainer(
                  "생년월일*", _birth, 40, 10, _birthController, true),
            ],
          ))
    ]);
  }
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

Widget _textFieldContainer(String containerName, String labelText,
    int horizontal, int vertical, Function contorller, bool isDigit) {
  return Container(
      margin: EdgeInsets.only(bottom: 5.h),
      width: 300.w,
      height: 30.h,
      child: Row(
        children: <Widget>[
          _typeContainer(containerName),
          Container(
              width: 170.w,
              child: TextField(
                  onChanged: (text) {
                    contorller(text);
                  },
                  keyboardType: isDigit ? TextInputType.number : null,
                  decoration: InputDecoration(
                    hintText: labelText,
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: horizontal.w, vertical: vertical.h),
                    hintStyle: TextStyle(
                      fontSize: 11.0.sp,
                      color: Colors.black,
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFD5BDAF)),
                    ),
                  ))),
        ],
      ));
}

Widget _radio(String containerName, String option1, String option2,
    int selectedValue, Function(int) controller, int sizedBoxWidth) {
  return Container(
    margin: EdgeInsets.only(bottom: 5.h),
    width: 300.w,
    height: 30.h,
    child: Row(
      children: <Widget>[
        _typeContainer(containerName),
        Container(
          width: 170.w,
          child: Row(
            children: <Widget>[
              Radio<int>(
                value: 0,
                groupValue: selectedValue,
                onChanged: (int? value) {
                  if (value != null) {
                    controller(value);
                  }
                },
              ),
              Text(option1, style: TextStyle(fontSize: 13.sp)),
              SizedBox(width: sizedBoxWidth.w), // 텍스트 간격 조정
              Radio<int>(
                value: 1,
                groupValue: selectedValue,
                onChanged: (int? value) {
                  if (value != null) {
                    controller(value);
                  }
                },
              ),
              Text(option2, style: TextStyle(fontSize: 13.sp)),
            ],
          ),
        ),
      ],
    ),
  );
}
