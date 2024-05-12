import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class APIServer {
  final String serverUrl = 'http://10.0.2.2:8080/api/v1/map/hospital/';

  APIServer();
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  Future<List<Map<String, dynamic>>> getHospitalService() async {
    String? assessToken = await _secureStorage.read(key: 'accessToken');
    print("accessToken");
    print(assessToken);
    final uri = Uri.parse(serverUrl); // 서버 URL 파싱
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',

      'Authorization': 'Bearer $assessToken', // JWT 토큰,
    };

    final response = await http.get(uri, headers: headers); // GET 요청 보내기

    if (response.statusCode == 200) {
      // UTF-8로 응답을 디코딩하고 JSON 파싱
      print(jsonDecode(utf8.decode(response.bodyBytes)));
      final List<dynamic> jsonData =
          jsonDecode(utf8.decode(response.bodyBytes));
      print("jsonData: ");
      print(jsonData);
      print("총 개수는");
      print(jsonData.length);
      final List<Map<String, dynamic>> data =
          jsonData.cast<Map<String, dynamic>>();
      ;

      return data; // 결과 반환
    } else {
      throw Exception(
          "Failed to fetch chart list. Status code: ${response.body}"); // 예외 발생
    }
  }
}
