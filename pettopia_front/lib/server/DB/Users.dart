import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pettopia_front/server/DB/jwt.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Users{
  
  Users();

  String _serverDbUrl= "";
    JWT _jwt = JWT();
      final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

    Future<void> _getServerUrl() async {
    try {
      await dotenv.load(fileName: ".env");
    } catch (e) {
      print("Error loading .env file: $e"); // 오류 메시지 출력
    }
    _serverDbUrl = dotenv.env['DB_SERVER_URI'] ?? 'YOUR_KAKAO_APP_KEY';
    print(_serverDbUrl);
  }

  
void launchLogin() async {
  const loginUrl = 'http://10.0.2.2:8080/oauth2/authorization/kakao'; 
  try{
      await launch(loginUrl);
  }
  catch(e){
    print(e);
  }
  // final url = Uri.parse("http://10.0.2.2:8080/login/oauth2/code/kakao?code=rHkpvsI-Lf0WjqI7_ClAugTa00IH9sGc7wtPqDd2ayjs7JUDsy13-7MsErYKPXKXAAABj0hj-oMSmUam6ZdnFg&state=JQ5UNChsF6ToMApIg8KgKAGI5B9E8X4OFEThRorDZTg%3D");
  // final response =await http.get(url);
  //     print(jsonDecode(utf8.decode(response.bodyBytes)));
}

  Future<void> logoutKakao() async {
        await _getServerUrl();
            bool isToken = await _jwt.tokenValidation();
            if(isToken){
              String? assessToken = await _secureStorage.read(key: 'accessToken');
       String finalUrl = _serverDbUrl + "api/v1/user/logout/kakao";
    final response = await http.post(
      Uri.parse(finalUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $assessToken',
      },
    );

    if (response.statusCode == 200) {
      // 로그아웃 성공 처리
      print('Logged out from Kakao successfully');
    } else {
      // 로그아웃 실패 처리
      print('Failed to logout: ${response.body}');
    }
            }else{

            }
   
  }





}