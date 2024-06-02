import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:pettopia_front/Menu/CustomBottomNavigatorBar.dart';
import 'package:geocode/geocode.dart';
import 'package:pettopia_front/hospital/widget/petSeletBox.dart';
import 'package:pettopia_front/life/widget/breedSelectBox.dart';
import 'package:pettopia_front/mainPage/page/DraggableSheet';
import 'package:geolocator/geolocator.dart';
import 'package:pettopia_front/server/DB/API.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pettopia_front/server/DB/Pet.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //가로가 더 길어질때 생기는 오류방지 크롬으로 실행했을시 생긴다는데 혹시 모르니깐 적용해놈
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const MyApp());
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

  Pet _petServer = Pet();
  late List<Map<String, dynamic>> _petList = [];

  Future<void> _getList() async {
    _petList = await _petServer.getPetList(context);
  }

  late String _petName = _petList.first['dogNm'];
  late int _petPk = _petList.first['petPk'];

  void _petNameHandler(String value, int valuePk) {
    setState(() {
      _petName = value;
      _petPk = valuePk;
    });
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    //그냥 펫 정보 잘 처리되나 확인할라고
    _getPetInfo();
  }

  //그냥 펫 정보
  Future<void> _getPetInfo() async {
    print("폰에 저장된 펫 정보들");
    String? jsonData = await _storage.read(key: 'pet');
    if (jsonData != null) {
      List<dynamic> petList = jsonDecode(jsonData);
      print(petList);
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
        Map<String, dynamic> weatherInfo =
            await _apiServer.getWeather(context,lat.toString(), lon.toString());
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
      designSize: const Size(411.4, 683.4), // 디자인 기준 크기를 설정합니다.
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
                      margin: EdgeInsets.only(top: 90.h, left: 155.w),
                      width: 170.w,
                      height: 130.h,
                      color: Color.fromARGB(255, 162, 207, 221),
                      child: _weatherUrl != ""
                          ? Image.network(_weatherUrl)
                          : Container()),
                  Container(
                    // color: Colors.yellow,
                    width: 420.w,
                    height: 600.h,
                    child: Image.asset("assets/img/mainImage.png"),
                  ),
                  // Container(
                  //   width: 150.w,
                  //   height: 100.h,
                  //   // color: Colors.blue,
                  //   // SelectBox 실행 시 예외 발생
                  //   child: PetSelectBox(
                  //       onRegionSelected: _petNameHandler, petName: _petList),
                  // ),

                  Expanded(
                    child: DraggableSheet(child: _petCard()),
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
          margin: EdgeInsets.only(top: 20.h),
          child: Text(
            "반려동물등록증",
            style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold),
          ),
        ),
        // 반려동물 사진 보여주는 Container
        Container(
          margin: EdgeInsets.fromLTRB(100.w, 20.h, 100.w, 20.h),
          color: Colors.yellow,
          width: 200.w,
          height: 200.h,
        ),
        Text(
          "뽀삐",
          style: TextStyle(fontSize: 20.sp),
        ),
        Text(
          "00000000000000000",
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
                    "생년월일: " + "2018.01.01",
                    style: TextStyle(fontSize: 15.sp),
                  ),
                  Text(
                    "종류: " + "웰시코기",
                    style: TextStyle(fontSize: 15.sp),
                  ),
                  Text(
                    "연락처: " + "010-1234-5678",
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
                    "성별: " + "여",
                    style: TextStyle(fontSize: 15.sp),
                  ),
                  Text(
                    "중성화 여부: " + "O",
                    style: TextStyle(fontSize: 15.sp),
                  ),
                  Text(
                    "보호자: " + "홍길동",
                    style: TextStyle(fontSize: 15.sp),
                  ),
                ],
              ),
            )
          ],
        ),
        Container(
          width: 150.w,
          margin: EdgeInsets.only(top: 10.h),
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
                color: Colors.green,
              )
            ],
          ),
        )
      ],
    );
  }
}
