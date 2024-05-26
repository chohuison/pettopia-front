import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // dotenv 가져오기
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:time/time.dart';

class Diary {
  String _serverDbUrl = "";
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  Diary();
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

  //다이어리 등록
  Future<void> createDiary(int petPk, Map<String, dynamic> diaryInfo) async {
    await _getServerUrl();

    String? assessToken = await _secureStorage.read(key: 'accessToken');
    print("accessToken");
    print(assessToken);
    String finalUrl = _serverDbUrl + "api/v1/life/diary/$petPk";
    print(finalUrl);
    final url = Uri.parse(finalUrl);
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $assessToken',
    };
    // final body = jsonEncode(
    //   {
    //     'petPk': petPk,
    //     'addDiaryRequest': diaryInfo,
    //   });
    final body = jsonEncode(diaryInfo);

    final response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    if (response.statusCode == 201) {
      print("Shot record created successfully!");
    } else {
      print("Failed to create shot record. Status code :${response.body}");
    }
  }

  //약 정보 가져오기
  Future<List<Map<String, dynamic>>> getMedicenList(int petPk) async {
    await _getServerUrl();

    String? assessToken = await _secureStorage.read(key: 'accessToken');
    print("accessToken");
    print(assessToken);

    String finalUrl = _serverDbUrl + "api/v1/medicine/$petPk";

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

      final List<Map<String, dynamic>> data =
          jsonData['list'].cast<Map<String, dynamic>>(); // 타입 캐스팅
      print(data);
      return data; // 결과 반환
    } else {
      throw Exception(
          "Failed to fetch chart list. Status code: ${response.body}"); // 예외 발생
    }
  }

  //다이어리 리스트 조회
  Future<Map<String, dynamic>> getDiary(int petPk, DateTime date) async {
    await _getServerUrl();
    print("프론트 원래 날짜 $date");
    String dateStr = DateFormat("yyyy-MM-dd").format(date);
    print("프론트 날짜 $dateStr");

    String? assessToken = await _secureStorage.read(key: 'accessToken');
    print("accessToken");
    print(assessToken);

    String finalUrl = _serverDbUrl + "api/v1/life/diary/list/$petPk";
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
      final List<dynamic> jsonData =
          jsonDecode(utf8.decode(response.bodyBytes));
      Map<String, dynamic> diary = {};
      int diaryPk = 0;
      if (jsonData.length > 0) {
        for (dynamic value in jsonData) {
          if (value['calendarDate'].toString() == dateStr.toString()) {
            diary = value;
            diaryPk = value['diaryPk'];
          }
        }
      }
      print(diary);
      Map<String, dynamic> diaryValue = {};
      if (diary.length > 0) { diaryValue = await getDiaryValue(diaryPk);}
     
      print(diaryValue);
      return diaryValue; // 결과 반환
    } else {
      throw Exception(
          "Failed to fetch chart list. Status code: ${response.body}"); // 예외 발생
    }
  }

  //다이어리 값 조회
  Future<Map<String, dynamic>> getDiaryValue(int diaryPk) async {
    await _getServerUrl();

    String? assessToken = await _secureStorage.read(key: 'accessToken');
    print("accessToken");
    print(assessToken);

    String finalUrl = _serverDbUrl + "api/v1/life/diary/$diaryPk";
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
      if(jsonData.length>0){
        jsonData['diaryPk'] = diaryPk;
      }
      print(jsonData);
      return jsonData;
    } else {
      throw Exception(
          "Failed to fetch chart list. Status code: ${response.body}"); // 예외 발생
    }
  }
//다이어리 수정
    Future<void> modifyDiary(int diaryPk,Map<String, dynamic> petInfo) async {
    await _getServerUrl();

    String? assessToken = await _secureStorage.read(key: 'accessToken');
    print("accessToken");
    print(assessToken);
    String finalUrl = _serverDbUrl + "api/v1/life/diary/$diaryPk";
    print(finalUrl);
    final url = Uri.parse(finalUrl);
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $assessToken',
    };
    final body = jsonEncode(petInfo);

    final response = await http.patch(
      url,
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      print("Shot record modify successfully!");
    } else {
      print("Failed to create shot record. Status code :${response.body}");
    }
  }
//다이어리 삭제
   Future<void> deleteDiary(int diaryPk) async{
         String? assessToken= await _secureStorage.read(key: 'accessToken');
    print("accessToken");
    print(assessToken);
     final headers ={'Content-Type': 'application/json',
     'Authorization': 'Bearer $assessToken', };
            await _getServerUrl();
    String serverUrl  = _serverDbUrl+"api/v1/life/diary/$diaryPk";
    final uri = Uri.parse(serverUrl); 
    
    final response = await http.delete(uri,
     headers: headers,);
  if(response.statusCode == 204){
    print("Shot record delete successfully!");
  }else{
    print("Failed to create shot record. Status code :${response.statusCode}");
  }


  }
}
