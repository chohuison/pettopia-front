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
  
Future<Map<String, dynamic>?> refreshTokens() async {
  _getServerUrl();
    final serverUrl = _serverDbUrl+ "api/v1/jwt/refresh";
  final url = Uri.parse(serverUrl);
  String? assessToken = await _secureStorage.read(key: 'accessToken');
  String? refreshToken = await _secureStorage.read(key: 'refreshToken');
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',

      'Authorization': 'Bearer $assessToken', // JWT 토큰,
    };
  final body = json.encode({'refreshToken': refreshToken});

  final response = await http.post(url, headers: headers, body: body);

  if (response.statusCode == 200) {
    print(json.decode(response.body));
    return json.decode(response.body) as Map<String, dynamic>;
  } else {
    print('Failed to refresh tokens. Status code: ${response.statusCode}');
    return null;
  }
}


}
