import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:async';
import 'dart:io';

class kakaoMapServer  {

  kakaoMapServer();





Future<Map<String,dynamic>> getXY(String name) async {
 // REST_API_KEY는 실제 Kakao API 키여야 합니다.
 String restApi;
   try {
      await dotenv.load(fileName: ".env");
    } catch (e) {
      print("Error loading .env file: $e"); // 오류 메시지 출력
    }
    restApi = dotenv.env['KAKAO_REST_KEY'] ?? 'YOUR_KAKAO_APP_KEY';
    print("apikey: " + restApi);
  String REST_API_KEY = restApi;

  // Kakao API 엔드포인트 및 쿼리 설정
  String apiUrl = "https://dapi.kakao.com/v2/local/search/address.json";
  String query = name;

  // HTTP GET 요청을 보내기 위한 URL 및 헤더 설정
  Uri uri = Uri.parse(apiUrl);
  Map<String, String> queryParams = {
    "query": query,
  };
  uri = uri.replace(queryParameters: queryParams);
  Map<String, String> headers = {
    "Authorization": "KakaoAK $REST_API_KEY",
  };

  // HTTP GET 요청 보내기
  http.Response response = await http.get(uri, headers: headers);

  // 요청 결과 확인
  if (response.statusCode == 200) {
    // 요청이 성공하면 응답 출력
 // JSON 문자열을 Map으로 파싱
    Map<String, dynamic> data = json.decode(response.body);
      List<Map<String, dynamic>> documents = List<Map<String, dynamic>>.from(data['documents']);
    Map<String, dynamic> xyValue= {"x":double.parse(documents[0]['x']),"y":double.parse(documents[0]['y'])};
    print("xyvalue: ${xyValue}");
    
    // 파싱된 데이터 사용 예시
    print(documents);
    return xyValue;
  } else {
    // 요청이 실패하면 에러 출력
    print("Request failed with status: ${response.statusCode}");
    return {};
  }
}}