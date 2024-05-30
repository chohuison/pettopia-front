import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:pettopia_front/hospital/page/shortRecords.dart';


class ShotRecords{
    String _serverDbUrl="";
  final String serverUrl='/api/v1/shot_records/';
    final FlutterSecureStorage _secureStorage = FlutterSecureStorage();
  
  ShotRecords();

   Future<void> _getServerUrl() async {
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    print("Error loading .env file: $e"); // 오류 메시지 출력
  }
  _serverDbUrl = dotenv.env['DB_SERVER_URI'] ?? 'YOUR_KAKAO_APP_KEY';
  print(_serverDbUrl);
}
  
  Map<String,dynamic> AddShotRecordCreateRequestToJson(int petPk, String type, int num, int age, DateTime createAt){
    return{
      'petPk':petPk,
      'type':type,
      'num':num,
      'age':age,
      'createAt' : createAt.toIso8601String().split('T').first,
      
    };
  }

Map<String,dynamic> AddShotRecordRequestToJson(int petPk, String type, int num, int age){
    return{
      'petPk':petPk,
      'type':type,
      'num':num,
      'age':age,
      
    };
  }



  Future<void> makeShotRecords(int petPk, String type, int num, int age, DateTime createAt,BuildContext context) async{
    
        String? assessToken= await _secureStorage.read(key: 'accessToken');
    print("accessToken");
    print(assessToken);
     await _getServerUrl();
    String finalUrl = _serverDbUrl+"api/v1/shot_records/";
    final url = Uri.parse(finalUrl);
    final headers ={'Content-Type': 'application/json',
     'Authorization': 'Bearer $assessToken', 
   };
    final body =jsonEncode(AddShotRecordCreateRequestToJson(petPk, type, num, age,createAt));

    final response = await http.post(
    url,
    headers: headers,
    body: body,
    
  );

  if(response.statusCode == 201){
    print("Shot record created successfully!");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ShortRecords()),
      );
  }else{
    print("Failed to create shot record. Status code :${response.body}");
  }


  }

    Future<void> modifySHotCharts(int pk,int petPk, String type, int num, int age,BuildContext context) async{
         String? assessToken= await _secureStorage.read(key: 'accessToken');
    print("accessToken");
    print(assessToken);
         await _getServerUrl();
    String serverUrl  = _serverDbUrl+"api/v1/shot_records/$pk";
    final url = Uri.parse(serverUrl); 
    final headers ={'Content-Type': 'application/json',
     'Authorization': 'Bearer $assessToken', };
    final body =jsonEncode(AddShotRecordRequestToJson(petPk, type, num, age));

    final response = await http.patch(
    url,
    headers: headers,
    body: body,
  );

  if(response.statusCode == 201){
    print("Shot record created successfully!");
     Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ShortRecords()),
      );
  }else{
    print("Failed to create shot record. Status code :${response.body}");
  }


  }

    Future<void> deleteShotRecord(int pk,BuildContext context) async{
         String? assessToken= await _secureStorage.read(key: 'accessToken');
    print("accessToken");
    print(assessToken);
     final headers ={'Content-Type': 'application/json',
     'Authorization': 'Bearer $assessToken', };
            await _getServerUrl();
    String serverUrl  = _serverDbUrl+"api/v1/shot_records/$pk";
    final uri = Uri.parse(serverUrl); 
    
    final response = await http.delete(uri,
     headers: headers,);
  if(response.statusCode == 204){
    print("Shot record delete successfully!");
     Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ShortRecords()),
      );
  }else{
    print("Failed to create shot record. Status code :${response.statusCode}");
  }


  }

Future<List<Map<String, dynamic>>> getChartList() async {
      await _getServerUrl();
    String? assessToken= await _secureStorage.read(key: 'accessToken');
    print("accessToken");
    print(assessToken);
    String serverUrl = _serverDbUrl+"api/v1/shot_records/";
    print(serverUrl);
  final uri = Uri.parse(serverUrl); // 서버 URL 파싱
    Map<String,String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',

    'Authorization': 'Bearer $assessToken',  // JWT 토큰,
  };

  final response = await http.get(uri,
  headers: headers); // GET 요청 보내기

  if (response.statusCode == 200) {
    // UTF-8로 응답을 디코딩하고 JSON 파싱
    print(jsonDecode(utf8.decode(response.bodyBytes)));
    final List<dynamic> jsonData = jsonDecode(utf8.decode(response.bodyBytes));
        print("jsonData: ");
        print(jsonData);
    final List<Map<String, dynamic>> data = jsonData.cast<Map<String, dynamic>>(); // 타입 캐스팅

    return data; // 결과 반환
  } else {
    throw Exception("Failed to fetch chart list. Status code: ${response.body}"); // 예외 발생
  }
}


}