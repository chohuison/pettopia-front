import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // dotenv 가져오기
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pettopia_front/main.dart';

class Pet {
  String _serverDbUrl = "";
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  Pet();
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

//s3url
  Future<String> getPresignedUrl(int petPk) async {
    await _getServerUrl();
    print("petPk : $petPk");
    String? assessToken = await _secureStorage.read(key: 'accessToken');
    String finalUrl = _serverDbUrl + 'api/v1/s3/presigned';
    print(finalUrl);
    final uri = Uri.parse(finalUrl);
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',

      'Authorization': 'Bearer $assessToken', // JWT 토큰,
    };
    final response = await http.post(
      uri,
      headers: headers,
      body: jsonEncode(petPk),
    );

    if (response.statusCode == 200) {
      // UTF-8로 응답을 디코딩하고 JSON 파싱
      print(response);
      print(jsonDecode(utf8.decode(response.bodyBytes)));
      Map<String, dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));

      // final String jsonData = jsonDecode(utf8.decode(response.bodyBytes));
      // print("jsonData: ");
      // print(jsonData);

      return data["presigned_url"]; // 결과 반환
    } else {
      throw Exception(
          "Failed to fetch presignedUrl. Status code: ${response.body}"); // 예외 발생
    }
  }

  //s3사진 업로드//
  Future<String> s3Upload(XFile xFile, int petPk) async {
    String presignedUrl = await getPresignedUrl(petPk);
    final url = Uri.parse(presignedUrl);
    final File imageFile = File(xFile.path);

    try {
      final response = await http.put(
        url,
        body: await imageFile.readAsBytes(),
        headers: {
          'Content-Type': 'image/jpeg',
        },
      );
      return presignedUrl.split("?")[0];
    } catch (e) {
      return "error $e";
    }
  }

  //petList가져오기
  Future<List<Map<String, dynamic>>> getPetList() async {
    await _getServerUrl();

    String? assessToken = await _secureStorage.read(key: 'accessToken');
    print("accessToken");
    print(assessToken);

    String finalUrl = _serverDbUrl + "api/v1/pet/list";

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

  //pet기본 정보 작성
  Future<void> createPet(Map<String, dynamic> petInfo , bool isProfile,BuildContext context) async {
    await _getServerUrl();

    String? assessToken = await _secureStorage.read(key: 'accessToken');
    print("accessToken");
    print(assessToken);
    String finalUrl = _serverDbUrl + "api/v1/pet/info";
    print(finalUrl);
    final url = Uri.parse(finalUrl);
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $assessToken',
    };
    final body = jsonEncode(petInfo);

    final response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    if (response.statusCode == 201) {
      print("Shot record created successfully!");
      if(isProfile == false){
          Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyApp()),
      );
      }
    } else {
      print("Failed to create shot record. Status code :${response.body}");
    }
  }

  //pet기본 정보 수정
  Future<void> modifyPet(Map<String, dynamic> petInfo, int petPk,
      BuildContext context, bool isCreate) async {
    await _getServerUrl();

    String? assessToken = await _secureStorage.read(key: 'accessToken');
    print("accessToken");
    print(assessToken);
    String finalUrl = _serverDbUrl + "api/v1/pet/info/$petPk";
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

    if (response.statusCode == 201) {
      print("Shot record modify successfully!");
      if (isCreate == false) {
        await _secureStorage.delete(key: 'pet');
        List<Map<String, dynamic>> petList = await getPetList();
        List<Map<String, dynamic>> petValueList = [];
        for (Map<String, dynamic> value in petList) {
          Map<String, dynamic> petInfo =
              await getPetRegistration(value['petPk']);
          Map<String, dynamic> petAddInfo = await getAddPetInfo(value['petPk']);
          petInfo['pk'] = value['petPk'];
          if (petAddInfo['petExtraInfo']['environment'] != null) {
            petInfo['isAddInfo'] = true;
          } else {
            petInfo['isAddInfo'] = false;
          }
          petValueList.add(petInfo);
        }
        await _secureStorage.write(key: 'pet', value: jsonEncode(petValueList));
      }
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyApp()),
      );
    } else {
      print("Failed to create shot record. Status code :${response.body}");
    }
  }

//반려동물 추가정보 작성
  Future<void> createAddPet(
      Map<String, dynamic> petInfo, int petPk, BuildContext context) async {
    await _getServerUrl();
    String? assessToken = await _secureStorage.read(key: 'accessToken');
    print("accessToken");
    print(assessToken);
    String finalUrl = _serverDbUrl + "api/v1/pet/extrainfo/$petPk";
    final url = Uri.parse(finalUrl);
    print(finalUrl);
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $assessToken',
    };
    final body = jsonEncode(petInfo);

    final response = await http.post(
      url,
      headers: headers,
      body: body,
    );

    if (response.statusCode == 201) {
      print("Shot record created successfully!");
      String? jsonData = await _secureStorage.read(key: 'pet');
      if (jsonData != null) {
        List<dynamic> appPetList = jsonDecode(jsonData);
        List<Map<String, dynamic>> newPetList = [];
        for (Map<String, dynamic> value in appPetList) {
          if (value['pk'] == petPk) {
            value['isAddInfo'] = true;
            newPetList.add(value);
          } else {
            newPetList.add(value);
          }
          newPetList.add(value);
        }
        await _secureStorage.delete(key: 'pet');
        await _secureStorage.write(key: 'pet', value: jsonEncode(newPetList));

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyApp()),
        );
      }
    } else {
      print("Failed to create addinfo record. Status code :${response.body}");
    }
  }

  //반려동물 기본 정보 가져오기
  Future<Map<String, dynamic>> getPetInfo(int petPk) async {
    await _getServerUrl();

    String? assessToken = await _secureStorage.read(key: 'accessToken');
    print("accessToken");
    print(assessToken);

    String finalUrl = _serverDbUrl + "api/v1/pet/info/$petPk";

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

      print(jsonData);
      return jsonData; // 결과 반환
    } else {
      throw Exception(
          "Failed to fetch chart list. Status code: ${response.body}"); // 예외 발생
    }
  }

  //반려동물 추가 정보 가져오기
  Future<Map<String, dynamic>> getAddPetInfo(int petPk) async {
    await _getServerUrl();

    String? assessToken = await _secureStorage.read(key: 'accessToken');
    print("accessToken");
    print(assessToken);

    String finalUrl = _serverDbUrl + "api/v1/pet/extrainfo/$petPk";

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

      print(jsonData);
      return jsonData; // 결과 반환
    } else {
      throw Exception(
          "Failed to fetch chart list. Status code: ${response.body}"); // 예외 발생
    }
  }

//pet추가 정보 수정
  Future<void> modifyAddPetInfo(Map<String, dynamic> petInfo, int petPk) async {
    await _getServerUrl();

    String? assessToken = await _secureStorage.read(key: 'accessToken');
    print("accessToken");
    print(assessToken);
    String finalUrl = _serverDbUrl + "api/v1/pet/extrainfo/$petPk";
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

    if (response.statusCode == 201) {
      print("Shot record modify successfully!");
    } else {
      print("Failed to create shot record. Status code :${response.body}");
    }
  }

  //반려동물 api 등록증 조회
  Future<Map<String, dynamic>> getAPIPetInfo(
      String dogRegNo, String ownerName) async {
    await _getServerUrl();

    String? assessToken = await _secureStorage.read(key: 'accessToken');
    print("accessToken");
    print(assessToken);

    String finalUrl =
        _serverDbUrl + "api/v1/map/pet?dogRegNo=$dogRegNo&ownernm=$ownerName";

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
      // print(jsonDecode(utf8.decode(response.bodyBytes)));
      final Map<String, dynamic> jsonData =
          jsonDecode(utf8.decode(response.bodyBytes));

      print(jsonData);
      return jsonData;
    } else {
      print("Failed to get petInfo Status code :${response.body}");
      return {};
    }
  }

  //반려동물 등록증 정보 가져오기
  Future<Map<String, dynamic>> getPetRegistration(int petPk) async {
    await _getServerUrl();

    String? assessToken = await _secureStorage.read(key: 'accessToken');
    print("accessToken");
    print(assessToken);

    String finalUrl =
        _serverDbUrl + "api/v1/pet/pet_registration_certificate/$petPk";

    final url = Uri.parse(finalUrl);
    print(finalUrl);
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

      print(jsonData);
      return jsonData; // 결과 반환
    } else {
      throw Exception(
          "Failed to fetch chart list. Status code: ${response.body}"); // 예외 발생
    }
  }
}
