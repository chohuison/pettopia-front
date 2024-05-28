import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pettopia_front/Menu/CustomBottomNavigatorBar.dart';
import 'package:geocode/geocode.dart';
import 'package:pettopia_front/mainPage/page/DraggableSheet';
import 'package:geolocator/geolocator.dart';
import 'package:pettopia_front/server/DB/API.dart';

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
  @override 
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void>_getCurrentLocation() async{
    try{
          Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      double lat = position.latitude;
      double lon = position.longitude;
      print('Latitude: $lat, Longitude: $lon');
  }catch(e){
    print("error : $e");
  }}
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411.4, 683.4), // 디자인 기준 크기를 설정합니다.
      child: MaterialApp(
        title: "main_page",
        debugShowCheckedModeBanner: false ,
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
              body: DraggableSheet(
                child: SizedBox(
                  height: 100,
                ),
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
}
