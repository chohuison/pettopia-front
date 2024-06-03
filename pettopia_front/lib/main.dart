import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:pettopia_front/Menu/CustomBottomNavigatorBar.dart';
import 'package:geocode/geocode.dart';
import 'package:pettopia_front/enum/PetBreedList.dart';
import 'package:pettopia_front/hospital/widget/petSeletBox.dart';
import 'package:pettopia_front/life/widget/breedSelectBox.dart';
import 'package:pettopia_front/mainPage/page/DraggableSheet';
import 'package:geolocator/geolocator.dart';
import 'package:pettopia_front/mainPage/widget/mainSelectBox.dart';
import 'package:pettopia_front/server/DB/API.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pettopia_front/server/DB/Pet.dart';
import 'package:pettopia_front/server/DB/jwt.dart';
import 'package:pettopia_front/setting/page/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //가로가 더 길어질때 생기는 오류방지 크롬으로 실행했을시 생긴다는데 혹시 모르니깐 적용해놈
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  JWT _jwt = JWT();
  final _storage = FlutterSecureStorage();
  String? assessToken = await _storage.read(key: 'accessToken');
  if (assessToken != null) {
    bool isToken = await _jwt.tokenValidation();
    if (isToken == true) {
      runApp(const MyApp());
    } else {
      print("여어기걸림");
      runApp(const Login());
    }
  } else {
    print("여기걸림");
    runApp(const Login());
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  APIServer _apiServer = APIServer();
  late String _weatherUrl = "";
  final _storage = FlutterSecureStorage();
  final PetBreedList _petBreedList = PetBreedList();
  late List<dynamic> petList = [];
  late String _petName = "";
  late int _petPk = 0;
  late String _profile = "";
  late String _dogRegNo = "";
  late String _speciesName = "";
  late String _sexNm = "";
  late String _neuterYn = "";
  late int _birth = 0;
  late String _protectorName = "";
  late String _protectorPhoneNum = "";
  late Map<String, dynamic> _curretnPetValue = {};

  @override
  void initState() {
    super.initState();

    _getPetInfo();
    _getCurrentLocation();
    //그냥 펫 정보 잘 처리되나 확인할라고
  }

  //그냥 펫 정보
  Future<void> _getPetInfo() async {
    String? jsonData = await _storage.read(key: 'pet');

    if (jsonData != null) {
      setState(() {
        petList = jsonDecode(jsonData);
      });
      if (petList.length > 0) {
        setState(() {
          _curretnPetValue = petList[0];
          print("폰에 저장된 펫 정보들");
          print(petList);
          _petName = petList[0]['dogNm'];
          _petPk = petList[0]['pk'];
        });
      }
    }
  }

  void _petNameHandler(
      String value, int valuePk, Map<String, dynamic> petValue) {
    setState(() {
      _petName = value;
      _petPk = valuePk;
      _curretnPetValue = petValue;
    });
  }

  String getSex(bool value) {
    if (value == true) {
      return "남";
    } else {
      return "여";
    }
  }

  String getNeuterYn(bool value) {
    if (value == true) {
      return "O";
    } else {
      return "X";
    }
  }

  Future<void> _getCurrentLocation() async {
    if (await isCheckedWeather()) {
      print("다시 날씨 정보 가져옴");
      try {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        double lat = position.latitude;
        double lon = position.longitude;
        print('Latitude: $lat, Longitude: $lon');
        Map<String, dynamic> weatherInfo = await _apiServer.getWeather(
            context, lat.toString(), lon.toString());
        setState(() {
          String imgUrl = weatherInfo['icon'];
          _weatherUrl = "https://openweathermap.org/img/wn/$imgUrl@2x.png";
        });
        Map<String, dynamic> value = {
          'imgUrl': _weatherUrl,
          'time': DateTime.now().toString()
        };
        String? jsonData = await _storage.read(key: 'weather');
        if (jsonData == null) {
          await _storage.write(key: 'weather', value: jsonEncode(value));
        } else {
          await _storage.delete(key: 'weather');
          await _storage.write(key: 'weather', value: jsonEncode(value));
        }
      } catch (e) {
        print("error : $e");
      }
    } else {
      print("기존 날씨 정보 사용");
      String? jsonData = await _storage.read(key: 'weather');
      setState(() {
        _weatherUrl = jsonDecode(jsonData!)['imgUrl'];
        print(_weatherUrl);
      });
    }
  }

  Future<bool> isCheckedWeather() async {
    String? jsonData = await _storage.read(key: 'weather');
    if (jsonData == null) {
      return true;
    } else {
      Map<String, dynamic> weatherData = jsonDecode(jsonData);
      DateTime weatherTime = DateTime.parse(weatherData['time']);
      print(weatherTime);
      DateTime currentTime = DateTime.now();
      print(currentTime);
      Duration difference = currentTime.difference(weatherTime);
      if (difference.inMinutes > 30) {
        return true;
      } else {
        return false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(392.7272727273, 783.2727272727), // 디자인 기준 크기를 설정합니다.
      child: MaterialApp(
        title: "main_page",
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          // MediaQuery를 사용하여 텍스트 크기 조정을 비활성화합니다.
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: child!,
          );
        },
        home: Builder(
          builder: (context) {
            return Scaffold(
              body: Stack(
                children: [
                  // 날씨 API Container
                  Container(
                      margin: EdgeInsets.only(top: 110.h, left: 150.w),
                      width: 170.w,
                      height: 140.h,
                      color: Color.fromARGB(255, 162, 207, 221),
                      child: _weatherUrl != ""
                          ? Image.network(_weatherUrl)
                          : Container()),
                  Container(
                    // color: Colors.yellow,
                    width: 600.w,
                    height: 800.h,
                    child: Image.asset("assets/img/mainImage.png"),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 400.h, left: 90.w),
                    child: Row(
                      children: [
                        Container(
                          width: 120.w,
                          height: 120.h,
                          child: Image.asset("assets/img/icon/main_dog.png"),
                        ),
                        Container(
                          width: 120.w,
                          height: 120.h,
                          child: Image.asset("assets/img/icon/main_cat.png"),
                        )
                      ],
                    ),
                  ),
                  if (petList.length > 0)
                    Container(
                      margin: EdgeInsets.only(top: 50.h, left: 20.w),
                      child: MainSelectBox(
                          onRegionSelected: _petNameHandler, petName: petList),
                    ),
                  if (petList.length > 0)
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                          height: 700.h,
                          child: DraggableSheet(child: _petCard())),
                    ),
                ],
              ),
              backgroundColor: Color.fromRGBO(237, 237, 233, 1.0),
              resizeToAvoidBottomInset: false,

              bottomNavigationBar:
                  CustomBottomNavigatorBar(page: 2), // 예시 커스텀 바텀 네비게이션 바
            );
          },
        ),
      ),
    );
  }

  Widget _petCard() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 40.h),
          child: Text(
            "반려동물등록증",
            style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold),
          ),
        ),
        //   반려동물 사진 보여주는 Container
        Container(
          margin: EdgeInsets.fromLTRB(100.w, 20.h, 100.w, 20.h),
          // color: Colors.yellow,
          width: 200.w,
          height: 200.h,
          child: _curretnPetValue['profile'] != ""
              ? Image.network(_curretnPetValue['profile']!)
              : Icon(
                  Icons.error,
                  size: 50.0,
                  color: Colors.red,
                ),
        ),
        Text(
          _curretnPetValue['dogNm'],
          style: TextStyle(fontSize: 20.sp),
        ),
        Text(
          _curretnPetValue['dogRegNo'],
          style: TextStyle(fontSize: 17.sp),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 160.w,
              height: 100.h,
              // color: Colors.blue,
              margin: EdgeInsets.only(top: 10.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "생년월일: " + _curretnPetValue['birth'].toString(),
                    style: TextStyle(fontSize: 15.sp),
                  ),
                  Text(
                    "종류: " +
                        _petBreedList.findSpeciesBySpeciesName(
                            _curretnPetValue['speciesName']),
                    style: TextStyle(fontSize: 15.sp),
                  ),
                  Text(
                    "연락처: " + _curretnPetValue['protectorPhoneNum'],
                    style: TextStyle(fontSize: 15.sp),
                  ),
                ],
              ),
            ),
            Container(
              width: 100.w,
              height: 100.h,
              // color: Colors.green,
              margin: EdgeInsets.only(top: 10.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "성별: " + getSex(_curretnPetValue['sexNm']),
                    style: TextStyle(fontSize: 15.sp),
                  ),
                  Text(
                    "중성화 여부: " + getNeuterYn(_curretnPetValue['neuterYn']),
                    style: TextStyle(fontSize: 15.sp),
                  ),
                  Text(
                    "보호자: " + _curretnPetValue['protectorName'],
                    style: TextStyle(fontSize: 15.sp),
                  ),
                ],
              ),
            )
          ],
        ),
        Container(
          width: 150.w,
          margin: EdgeInsets.only(top: 70.h),
          //color: Colors.blue,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    DateFormat("yyyy.MM.dd").format(DateTime.now()),
                    style: TextStyle(fontSize: 15.sp),
                  ),
                  Text(
                    "펫토피아",
                    style: TextStyle(fontSize: 15.sp),
                  ),
                ],
              ),
              // 멍냥이들 발바닥 젤리 그림 들어갈 자리
              Container(
                  width: 50.w,
                  height: 50.h,
                  child: Image.asset("assets/img/icon/pettopia.png"))
            ],
          ),
        )
      ],
    );
  }
}
