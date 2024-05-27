import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pettopia_front/Menu/CustomBottomNavigatorBar.dart';
import 'package:pettopia_front/setting/widget/createPetInformationValue.dart';
import 'package:pettopia_front/setting/widget/createPetParentValue.dart';
import 'package:pettopia_front/server/DB/Pet.dart';
import 'package:pettopia_front/main.dart';

class CreatePet extends StatefulWidget {
  const CreatePet({Key? key}) : super(key: key);

  @override
  _CreatePetState createState() => _CreatePetState();
}

class _CreatePetState extends State<CreatePet> {
  late int _breedPk = 1;
  late String _petNumber = "";
  late String _petName = "";
  late String _birth = "";
  late int _fur = 0;
  late int _sex = 0;
  late int _neutering = 0;
  late String _parentName = "";
  late String _parentPhoneNum = "";
  late String _wight = "";
  Pet _pet = Pet();
  late String errMesg = "";
  String _profile = "";
  XFile? _file = null;

  void onHandlePetInformation(
      String profile,String petNum, String petName, String wight, int breedPk, int fur, int sex, int neutering, String birth) {
    _profile=profile;
    _petNumber = petNum;
    _petName = petName;
    _breedPk = breedPk;
    _fur = fur;
    _sex = sex;
    _wight = wight;
    _neutering = neutering;
    _birth = birth;
  }

  void onHandleXfile(XFile xfile){
    _file=xfile;
  }

  void petParentValueHandle(String parentName, String parentPhoneNum) {
    _parentName = parentName;
    _parentPhoneNum = parentPhoneNum;
  }

  bool _getBoolType(int value) {
    return value == 0;
  }

  Future<void> _saveButtonHandle() async {
    
    if (_petNumber == "" ||
        _petName == "" ||
        _birth == "" ||
        _parentName == "" ||
        _parentPhoneNum == "") {
      setState(() {
        errMesg = "필수 입력값을 모두 입력해주세요!";
      });
    } else {
      Map<String, dynamic> petInfo = {
        'dogRegNo':_petNumber,
        'dogNm': _petName,
        'speciesPk': _breedPk,
        'hair': _fur,
        'sexNm': _getBoolType(_sex),
        'neuterYn': _getBoolType(_neutering),
        'birth': int.parse(_birth),
        'weight': double.parse(_wight),
        'protectorName': _parentName,
        'protectorPhoneNum': _parentPhoneNum
      };
        print(petInfo);
      await _pet.createPet(petInfo);
      List<Map<String,dynamic>> petList = await _pet.getPetList();
      int petPk =0;
      for(Map<String,dynamic> pet in petList){
        if(pet['dogNm']== petInfo['dogNm']){
          petPk=pet['petPk'];
          print("여기서 petPk: $petPk");
        }
      }
      if(_file != null){
        String presignedUrl = await _pet.s3Upload(_file!, petPk);
        print(presignedUrl);
        setState(() {
          _profile= presignedUrl;
        });
        print("profile: $_profile");
        petInfo['profile'] = _profile;
        print(petInfo);
     
        await _pet.modifyPet(petInfo, petPk);
      }


  
      //     if(_profile != ""){
      //   petInfo['profile'] = _profile;
      // }
    
    
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyApp()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411.42857142857144, 683.4285714285714),
      builder: (context, child) {
        return MediaQuery(
          
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: child!,
        );
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color.fromRGBO(237, 237, 233, 1.0),
        body: ListView(
          children: [
            Container(
              width: 400.w,
              height: 680.h,
              margin: EdgeInsets.all(15.w),
              decoration: BoxDecoration(
                color: Color(0xFFE3D5CA),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20.h),
                  Center(
                    child: Text(
                      "반려동물 추가 / 등록하기",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // 반려동물 정보 콘테이너
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
                    height: 450.h,
                    child: CreatePetInformation(
                      onHandlePetInformation: onHandlePetInformation,
                      xfileHandle:onHandleXfile,
                    ),
                  ),
                  // 보호자 정보 콘테이너
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
                      petParentValueHandle: petParentValueHandle,
                    ),
                    width: 350.w,
                    height: 110.h,
                  ),
                  // 필수 입력값 입력하지 않은 경우
                  Center(
                    child: Text(
                      errMesg,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  // 등록 버튼
                  Container(
                    margin: EdgeInsets.only(top: 5.h),
                    width: 100.w,
                    height: 30.h,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 180, 178, 176),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: ElevatedButton(
                      onPressed: _saveButtonHandle,
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
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: CustomBottomNavigatorBar(page: 4),
      ),
    );
  }
}
