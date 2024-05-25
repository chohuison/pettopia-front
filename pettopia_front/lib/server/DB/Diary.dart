// import 'dart:convert';
// import 'package:flutter_dotenv/flutter_dotenv.dart'; // dotenv 가져오기
// import 'package:http/http.dart' as http;
// import 'dart:async';
// import 'dart:io';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// class Diary {
//   String _serverDbUrl = "";
//   final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

//   Diary();
//   //env파일에 있는 serverUrl가져오기
//   Future<void> _getServerUrl() async {
//     try {
//       await dotenv.load(fileName: ".env");
//     } catch (e) {
//       print("Error loading .env file: $e"); // 오류 메시지 출력
//     }
//     _serverDbUrl = dotenv.env['DB_SERVER_URI'] ?? 'YOUR_KAKAO_APP_KEY';
//     print(_serverDbUrl);
//   }

//   //pet기본 정보 작성
//   Future<void> createDiary(Map<String, dynamic> diaryInfo) async {
//     await _getServerUrl();

//     String? assessToken = await _secureStorage.read(key: 'accessToken');
//     print("accessToken");
//     print(assessToken);
//     String finalUrl = _serverDbUrl + "api/v1/pet/info";
//     print(finalUrl);
//     final url = Uri.parse(finalUrl);
//     final headers = {
//       'Content-Type': 'application/json',
//       'Authorization': 'Bearer $assessToken',
//     };
//     final body = jsonEncode(petInfo);

//     final response = await http.post(
//       url,
//       headers: headers,
//       body: body,
//     );

//     if (response.statusCode == 201) {
//       print("Shot record created successfully!");
//     } else {
//       print("Failed to create shot record. Status code :${response.body}");
//     }
//   }

// }
