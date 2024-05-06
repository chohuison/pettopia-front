import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ShotRecords{
  final String serverUrl='http://10.0.2.2:8080/api/v1/shot_records/';
    final FlutterSecureStorage _secureStorage = FlutterSecureStorage();
  
  ShotRecords();
  
  Map<String,dynamic> AddShotRecordRequestToJson(int petPk, String type, int num, int age){
    return{
      'petPk':petPk,
      'type':type,
      'num':num,
      'age':age,
      
    };
  }



  Future<void> makeShotRecords(int petPk, String type, int num, int age) async{
        String? assessToken= await _secureStorage.read(key: 'accessToken');
    print("accessToken");
    print(assessToken);
    final url = Uri.parse(serverUrl);
    final headers ={'Content-Type': 'application/json',
     'Authorization': 'Bearer $assessToken', 
   };
    final body =jsonEncode(AddShotRecordRequestToJson(petPk, type, num, age));

    final response = await http.post(
    url,
    headers: headers,
    body: body,
    
  );

  if(response.statusCode == 201){
    print("Shot record created successfully!");
  }else{
    print("Failed to create shot record. Status code :${response.body}");
  }


  }

    Future<void> modifySHotCharts(int pk,int petPk, String type, int num, int age) async{
    final url = Uri.parse('$serverUrl$pk'); 
    final headers ={'Content-Type': 'application/json'};
    final body =jsonEncode(AddShotRecordRequestToJson(petPk, type, num, age));

    final response = await http.patch(
    url,
    headers: headers,
    body: body,
  );

  if(response.statusCode == 201){
    print("Shot record created successfully!");
  }else{
    print("Failed to create shot record. Status code :${response.statusCode}");
  }


  }

    Future<void> deleteShotRecord(int pk) async{
    final uri = Uri.parse('$serverUrl$pk'); 
    final response = await http.delete(uri);
  if(response.statusCode == 204){
    print("Shot record delete successfully!");
  }else{
    print("Failed to create shot record. Status code :${response.statusCode}");
  }


  }

Future<List<Map<String, dynamic>>> getChartList() async {
    String? assessToken= await _secureStorage.read(key: 'accessToken');
    print("accessToken");
    print(assessToken);
  final uri = Uri.parse(serverUrl); // 서버 URL 파싱
    Map<String,String> headers = {
    'Content-Type': 'application/json',

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