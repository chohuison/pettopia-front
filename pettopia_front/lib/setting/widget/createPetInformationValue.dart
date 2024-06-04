import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import 'package:pettopia_front/enum/PetBreedList.dart';
import 'package:pettopia_front/server/DB/Pet.dart';

import 'package:pettopia_front/setting/widget/speciesSelectBox.dart';

class CreatePetInformation extends StatefulWidget {
  final Function(String,String, String, String, int, int, int, int, String)
      onHandlePetInformation;
  final Function(XFile) xfileHandle;
  final String dogNumber;
  final String petName;
  final int sex;
  final int neuterYn;
  final String speciesName;
  final int speciesPk;
  const CreatePetInformation({
    Key? key,
    required this.onHandlePetInformation,
    required this.xfileHandle,
    required this.dogNumber,
    required this.petName,
    required this.sex,
    required this.neuterYn,
    required this.speciesName,
    required this.speciesPk,

  }) : super(
          key: key,
        );

  @override
  _CreatePetInformationState createState() => _CreatePetInformationState();
}

class _CreatePetInformationState extends State<CreatePetInformation>
    with AutomaticKeepAliveClientMixin {
 @override
  bool get wantKeepAlive => true;
  late List<Map<String, dynamic>> _speciesList = _petBreedList.getSpecies();
  late String _species = widget.speciesName;
  late String _petNumber = widget.dogNumber;
  late String _petName = widget.petName;
  String _birth = "";
  late int _fur = 0;
  late int _sex = widget.sex;
  late int _neutering = widget.neuterYn;
  PetBreedList _petBreedList = PetBreedList();
  late int _speciesPk = widget.speciesPk;
  late String _widght = "";
  XFile? _file = null;
  String _profile = "";
  Pet _petServer = Pet();
  late String _petNumberLabelText = widget.dogNumber!= ""? widget.dogNumber : "반려동믈 등록 번호를 입력해주세요";
  late String _petNameLabelText = widget.petName!=""? widget.petName:"이름을 입력해주세요";
  late bool _isPet = widget.petName != ""? true:false;



  void _onFurUpdate(int value) {
    setState(() {
      _fur = value!;
    });
    widget.onHandlePetInformation(_profile,_petNumber, _petName, _widght, _speciesPk,
        _fur, _sex, _neutering, _birth);
  }

  void _onWightUpdate(String value) {
    setState(() {
      _widght = value;
    });
   widget.onHandlePetInformation(_profile,_petNumber, _petName, _widght, _speciesPk,
        _fur, _sex, _neutering, _birth);
  }

  void _onSexUpdate(int value) {
    setState(() {
      _sex = value;
    });
   widget.onHandlePetInformation(_profile,_petNumber, _petName, _widght, _speciesPk,
        _fur, _sex, _neutering, _birth);
  }

  void _onnNuteringUpdate(int value) {
    setState(() {
      _neutering = value;
    });
   widget.onHandlePetInformation(_profile,_petNumber, _petName, _widght, _speciesPk,
        _fur, _sex, _neutering, _birth);
  }

  void onSeleted(String value, int pk) {
    setState(() {
      _species = value;
      _speciesPk = pk;
    });
    print(value);
    print(pk);
    print(_species);
   widget.onHandlePetInformation(_profile,_petNumber, _petName, _widght, _speciesPk,
        _fur, _sex, _neutering, _birth);
  }

  void _petNumberController(String value) {
    setState(() {
      _petNumber = value;
    });

   widget.onHandlePetInformation(_profile,_petNumber, _petName, _widght, _speciesPk,
        _fur, _sex, _neutering, _birth);
  }

  void _petNameController(String value) {
    setState(() {
      _petName = value;
    });
    print(_petName);

   widget.onHandlePetInformation(_profile,_petNumber, _petName, _widght, _speciesPk,
        _fur, _sex, _neutering, _birth);
  }

  void _birthController(String value) {
   setState(() {
      _birth = value;
   });
   
   widget.onHandlePetInformation(_profile,_petNumber, _petName, _widght, _speciesPk,
        _fur, _sex, _neutering, _birth);
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
    widget.xfileHandle(_file!);
    //  _profile = await _petServer.seUploat(_file!);
    // widget.onHandlePetInformation(_profile,_petNumber, _petName, _widght, _speciesPk,
    //     _fur, _sex, _neutering, _birth);

  }
     Future<void> _getCamera() async {
    ImagePicker().pickImage(source: ImageSource.camera).then((image) {
      if (image != null) {
        setState(() {
          _file = image;
        });
      }
       widget.xfileHandle(_file!);
    });
       
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
                decoration: BoxDecoration(
                  // color: Colors.blue, // Background color of the container
                  border: Border.all(
                    color: Color(0xFFD5BDAF),
                    width: 2.0, // Border width
                  ),
                  borderRadius: BorderRadius.circular(10.0), // Rounded corners
                ),
                child: _file == null ? Container() : Image.file(File(_file!.path),
                fit:BoxFit.cover)
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
                          onPressed: () {
                            _getGallery();
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
              _textFieldContainer("번호*", _petNumberLabelText,
                  _petNumberController, false,_isPet),
              _textFieldContainer(
                  "이름*", _petNameLabelText, _petNameController, false,_isPet),
              _textFieldContainer(
                  "몸무게*", "몸무게 입력해주세요",  _onWightUpdate, true,false),
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
                          _radio("단장모*", "단모", "장모", _fur!, _onFurUpdate, 10),
                            _radio("성별*", "남", "여", _sex!, _onSexUpdate, 22),
                            _radio("중성화*", "O", "X", _neutering!,
                                _onnNuteringUpdate, 24),
                          ],
                        ))),
                    Positioned(
                        child: Container(
                      // width: 400,
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
                            petNameValue: _species,
                            petPk: _speciesPk,
                          )
                        ],
                      ),
                    )),
                  ],
                ),
              ),
              _textFieldContainer(
                  "생년월일*", "YYYYMMDD", _birthController, true,false),
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
    Function contorller, bool isDigit, bool isPet) {
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
                  
                    hintStyle: TextStyle(
                      fontSize: 11.0.sp,
                      color:isPet==true?Colors.black: Color(0xFFAFA59B),
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
