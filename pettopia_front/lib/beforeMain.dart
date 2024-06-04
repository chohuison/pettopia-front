import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pettopia_front/main.dart'; 
import 'package:pettopia_front/server/DB/Pet.dart';

class BeforeMain extends StatefulWidget {
  final String html;
  const BeforeMain({Key? key, required this.html}) : super(key: key);

  @override
  _BeforeMainState createState() => _BeforeMainState();
}

class _BeforeMainState extends State<BeforeMain> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  late String _serverUrl="";
  Pet _petServer = Pet();

    @override
  void initState() {
    super.initState();
    init();

  }
  Future<void> init()async{
    await split(widget.html);
  }

 Future<void> _getServerUrl() async {
    try {
      await dotenv.load(fileName: ".env");
    } catch (e) {
      print("Error loading .env file: $e"); // 오류 메시지 출력
    }
    _serverUrl = dotenv.env['DB_SERVER_URI'] ?? 'YOUR_KAKAO_APP_KEY';
    print(_serverUrl);
  }

 

  Future<void> _getUserPet() async{
    List<Map<String,dynamic>> petList = await _petServer.getPetList(context);
    List<Map<String,dynamic>> petValueList = [];
    for(Map<String,dynamic> value in petList){
      Map<String,dynamic>petInfo = await _petServer.getPetRegistration(context,value['petPk']);
      Map<String,dynamic>petAddInfo = await _petServer.getAddPetInfo(context,value['petPk']);
      petInfo['pk'] = value['petPk'];
      if(petAddInfo['petExtraInfo']['environment']!= null){
        petInfo['isAddInfo'] = true;
      }
      else{
        petInfo['isAddInfo'] = false;
      }
      petValueList.add(petInfo);
    }
    await _secureStorage.write(key: 'pet', value: jsonEncode(petValueList));

  }
  
  Future<void> split(String html)async {

    print("넘어온 html");
    print(html);
    RegExp jsonPattern = RegExp(r'\{.*\}', dotAll: true); // 중괄호 포함 부분 추출
    Iterable<Match> matches = jsonPattern.allMatches(html); // 모든 일치 항목 찾기

    if (matches.isNotEmpty) {
      String jsonString = matches.first.group(0)!; // 첫 번째 일치 항목 추출
      print("Extracted JSON: $jsonString");
      String jsonStr = jsonString.replaceAll(r'\', '');

      String accessToken = "";
      String refreshToken = "";
      final parts = jsonStr.split('"');
      for (int i = 0; i < parts.length; i++) {
        print(parts[i]);
      }
      for (int i = 0; i < parts.length; i++) {
        if (parts[i] == 'accessToken') {
          accessToken = parts[i + 2]; // 값이 따옴표 사이에 있기 때문
        } else if (parts[i] == 'refreshToken') {
          refreshToken = parts[i + 2];
        }
      }
      await saveToken(accessToken, refreshToken);
       await _getUserPet();
          print("Access Token: $accessToken");
      print("Refresh Token: $refreshToken");
    // await Future.delayed(const Duration(seconds: 1)); 
     
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => MyApp()), (route) => false);
    } else {
      print("No JSON object found.");
    }


  }


  Future<void> saveToken(String accessToken, String refreshToken) async {

    await _secureStorage.deleteAll();

    await _secureStorage.write(key: 'accessToken', value: accessToken);

  }  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(411.42857142857144, 683.4285714285714),
        child: MaterialApp(
             debugShowCheckedModeBanner: false ,
            title: "beforeMain",
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: child!,
              );
            },
            home: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Color.fromRGBO(237, 237, 233, 1.0),
              body: Container()
        
  
            )));
  }
}
