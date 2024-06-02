import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // dotenv 가져오기
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:pettopia_front/server/DB/jwt.dart';
import 'package:pettopia_front/setting/page/login.dart';
import 'package:time/time.dart';

class Tip {
  String _serverDbUrl = "";
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();
  JWT _jwt = JWT();

  Tip();
  //env파일에 있는 serverUrl가져오기
  Future<void> _getServerUrl() async {
    try {
      await dotenv.load(fileName: ".env");
    } catch (e) {
      print("Error loading .env file: $e"); // 오류 메시지 출력
    }
    _serverDbUrl = dotenv.env['DB_SERVER_URI'] ?? 'YOUR_KAKAO_APP_KEY';
    print(_serverDbUrl);
  }

 
  //팁 가져오기
  Future<List<Map<String, dynamic>>> getTip(BuildContext context,int speciesPk, String tipCategory) async {
       bool isToken = await _jwt.tokenValidation();
       if(isToken){
           await _getServerUrl();

    String? assessToken = await _secureStorage.read(key: 'accessToken');
    print("accessToken");
    print(assessToken);

    String finalUrl = _serverDbUrl + "api/v1/life/tip?petTypePk=$speciesPk&tipCategory=$tipCategory";

    final url = Uri.parse(finalUrl);
    print(url);
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $assessToken',
    };

    final response = await http.get(
      url,
      headers: headers,
    );

    if (response.statusCode == 200) {
      print(jsonDecode(utf8.decode(response.bodyBytes)));
      final Map<String, dynamic> jsonData =
          jsonDecode(utf8.decode(response.bodyBytes));
      print(jsonData);
      final List<Map<String, dynamic>> data =
          jsonData['responses'].cast<Map<String, dynamic>>(); // 타입 캐스팅
      print(data);
      return data; // 결과 반환
    } else {
      throw Exception(
          "Failed to fetch chart list. Status code: ${response.body}"); // 예외 발생
    }
       }else{    
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
    return [];

       }
 
  }


}
