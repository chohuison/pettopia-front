import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pettopia_front/main.dart';
import 'package:pettopia_front/server/DB/jwt.dart';
import 'package:pettopia_front/setting/page/login.dart';

class APIServer {


  APIServer();


  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();
 String _serverDbUrl="";
   JWT _jwt = JWT();
    Future<void> _getServerUrl() async {
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    print("Error loading .env file: $e"); // 오류 메시지 출력
  }
  _serverDbUrl = dotenv.env['DB_SERVER_URI'] ?? 'YOUR_KAKAO_APP_KEY';
  print(_serverDbUrl);
}


 Future<List<Map<String, dynamic>>> getHospitalService(BuildContext context, String address) async {
  String? assessToken = await _secureStorage.read(key: 'accessToken');
  print("accessToken");
  print(assessToken);
  bool isToken = await _jwt.tokenValidation();
  print(isToken);
  
  if (isToken) {
    print(address);
    await _getServerUrl();
    final serverUrl = _serverDbUrl + "api/v1/map/hospital/$address";
    print(serverUrl);
    final uri = Uri.parse(serverUrl); // 서버 URL 파싱
    
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $assessToken', // JWT 토큰,
    };

    final response = await http.get(uri, headers: headers); // GET 요청 보내기

    if (response.statusCode == 200) {
      // UTF-8로 응답을 디코딩하고 JSON 파싱
      print(jsonDecode(utf8.decode(response.bodyBytes)));
      final List<dynamic> jsonData = jsonDecode(utf8.decode(response.bodyBytes));
      print("jsonData: ");
      print(jsonData);
      print("총 개수는");
      print(jsonData.length);
      final List<Map<String, dynamic>> data = jsonData.cast<Map<String, dynamic>>();
      
      return data;
    } else {
      throw Exception("Failed to fetch chart list. Status code: ${response.body}"); // 예외 발생
    }
  } else {
    // isToken이 false인 경우 로그인 화면으로 이동
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
    return []; // 빈 리스트 반환 또는 예외 발생시킴
  }
}
   Future<List<Map<String, dynamic>>> getBeautyService(BuildContext context,String address) async {
    String? assessToken = await _secureStorage.read(key: 'accessToken');
  print("accessToken");
  print(assessToken);
  bool isToken = await _jwt.tokenValidation();
  print(isToken);
  
  if (isToken) {
    print(address);
    await _getServerUrl();
    final serverUrl = _serverDbUrl + "api/v1/map/beauty/$address";
    print(serverUrl);
    final uri = Uri.parse(serverUrl); // 서버 URL 파싱
    
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $assessToken', // JWT 토큰,
    };

    final response = await http.get(uri, headers: headers); // GET 요청 보내기

    if (response.statusCode == 200) {
      // UTF-8로 응답을 디코딩하고 JSON 파싱
      print(jsonDecode(utf8.decode(response.bodyBytes)));
      final List<dynamic> jsonData = jsonDecode(utf8.decode(response.bodyBytes));
      print("jsonData: ");
      print(jsonData);
      print("총 개수는");
      print(jsonData.length);
      final List<Map<String, dynamic>> data = jsonData.cast<Map<String, dynamic>>();
      
      return data;
    } else {
      throw Exception("Failed to fetch chart list. Status code: ${response.body}"); // 예외 발생
    }
  } else {
    // isToken이 false인 경우 로그인 화면으로 이동
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
    return []; // 빈 리스트 반환 또는 예외 발생시킴
  }
  }
Future <Map<String, dynamic>> getWeather(BuildContext context, String lat, String lon) async {
    String? assessToken = await _secureStorage.read(key: 'accessToken');
    print("accessToken");
    print(assessToken);
    await _getServerUrl();
      bool isToken = await _jwt.tokenValidation();
  print("날씨에서 : $isToken");
  if(isToken){
    final serverUrl = _serverDbUrl+ "api/v1/map/weather?lat=$lat&lon=$lon";
    print(serverUrl);
    final uri = Uri.parse(serverUrl); // 서버 URL 파싱
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',

      'Authorization': 'Bearer $assessToken', // JWT 토큰,
    };

    final response = await http.get(uri, headers: headers); // GET 요청 보내기

    if (response.statusCode == 200) {
      // UTF-8로 응답을 디코딩하고 JSON 파싱
      print(jsonDecode(utf8.decode(response.bodyBytes)));
      final Map<String,dynamic>jsonData =
          jsonDecode(utf8.decode(response.bodyBytes));
      print("jsonData: ");
      print(jsonData);
   ;
  

      return jsonData; // 결과 반환
    } else {
      throw Exception(
          "Failed to fetch chart list. Status code: ${response.body}"); // 예외 발생
    }
  }else{
      Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
    return {};
  }

}
}