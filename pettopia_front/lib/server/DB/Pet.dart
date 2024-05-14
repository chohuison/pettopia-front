import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Pet{
  final String serverUrl = 'http://43.200.68.44:8080/api/v1/';
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  Pet();

  Future<String> getPresignedUrl() async{

  String? assessToken= await _secureStorage.read(key: 'accessToken');
  String finalUrl = serverUrl+'s3/presigned';
  print(finalUrl);
  final uri = Uri.parse(finalUrl);
  Map<String,String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',

    'Authorization': 'Bearer $assessToken',  // JWT 토큰,
  };
 final response = await http.post(uri,
  headers: headers);

if (response.statusCode == 200) {
    // UTF-8로 응답을 디코딩하고 JSON 파싱
    print(response);
    print(jsonDecode(utf8.decode(response.bodyBytes)));
    // final String jsonData = jsonDecode(utf8.decode(response.bodyBytes));
        // print("jsonData: ");
        // print(jsonData);
   
    return "jsonData"; // 결과 반환
  } else {
    throw Exception("Failed to fetch chart list. Status code: ${response.body}"); // 예외 발생
  }
  }

  Future<void> createPet(Map<String,dynamic> petInfo)async{
    
        String? assessToken= await _secureStorage.read(key: 'accessToken');
    print("accessToken");
    print(assessToken);
    String finalUrl = serverUrl+"pet/info/";
    final url = Uri.parse(finalUrl);
    final headers ={'Content-Type': 'application/json',
     'Authorization': 'Bearer $assessToken', 
   };
    final body =jsonEncode(petInfo);

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


}