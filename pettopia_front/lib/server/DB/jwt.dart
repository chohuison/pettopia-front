import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // dotenv 가져오기
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pettopia_front/main.dart';

class JWT {
  String _serverDbUrl = "";
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  JWT();
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
  
Future<bool> tokenValidation() async {
  _getServerUrl();
    String? assessToken = await _secureStorage.read(key: 'accessToken');
    if(assessToken != null){
  final serverUrl = _serverDbUrl+ "api/v1/jwt/access?authHeader=Bearer $assessToken";
   
  final url = Uri.parse(serverUrl);

   Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',

      'Authorization': 'Bearer $assessToken', // JWT 토큰,
    };
   

  final response = await http.get(url, headers:headers);

  if (response.statusCode == 200) {
    print("나온 답");
    print(json.decode(response.body));
    Map<String,dynamic> responseMap = json.decode(response.body);
    if(responseMap['message']!=null){
      return true;
    }else if(responseMap['accessToken']!=null){
       await _secureStorage.delete(key: 'accessToken');
       await _secureStorage.delete(key: 'refreshToken');
           await _secureStorage.write(key: 'accessToken', value: responseMap['accessToken']);
    await _secureStorage.write(key: 'refreshToken', value: responseMap['refreshToken']);
    return true;
    }
    else{
      return false;
    }
  } else {
    return false;
  }
    }
    else{
      return false;
    }
  
}


}
