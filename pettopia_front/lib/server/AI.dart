import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pettopia_front/enum/PetBreedList.dart';
import 'package:pettopia_front/server/DB/Pet.dart';

class AI {
  String _serverAIUrl="";
  Pet _petServer = Pet();

  AI();
 Future<void> _getServerUrl() async {
    try {
      await dotenv.load(fileName: ".env");
    } catch (e) {
      print("Error loading .env file: $e"); // 오류 메시지 출력
    }
    _serverAIUrl = dotenv.env['AI_SERVER_URI'] ?? 'YOUR_KAKAO_APP_KEY';
    print(_serverAIUrl);
  }


  Future<XFile?> applyPetFilterDog( XFile pickedImage, String species, String noseFilter, String hornsFilter) async {
     await _getServerUrl();
    // final uri = Uri.parse('$_serverAIUrl/pet_filter');
    String finalUrl = _serverAIUrl+"pet_filter_dog";
     final uri = Uri.parse(finalUrl);
    print(uri);
    // final uri = Uri.parse('http://10.0.2.2:5000/pet_filter');
   
    final request = http.MultipartRequest('POST', uri);

    request.files.add(await http.MultipartFile.fromPath('petImage', pickedImage.path));
    request.fields['petFilterNose'] = noseFilter;
    request.fields['petFilterHorns'] = hornsFilter; 
    print("request: ");
    print(request);
    print(noseFilter);
    print(hornsFilter);

    try {
      final response = await request.send(); 
      print("기다리는중");
      await Future.delayed(const Duration(seconds: 5)); 
      print("다 기다림");  
      if (response.statusCode == 200) {
        final responseData = await response.stream.toBytes(); 
        print(responseData);
        final tempDir = await getTemporaryDirectory();
        final tempPath = tempDir.path;
        String tempFileName = '${DateTime.now().millisecondsSinceEpoch}.png';
        String tempFilePath = '$tempPath/$tempFileName';

        await File(tempFilePath).writeAsBytes(responseData); 

        return XFile(tempFilePath); 
      } else {
        print("Failed to apply filter. Status code: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error applying filter: $e");
      return null; 
    }
  }

    Future<XFile?> applyCatFilter( XFile pickedImage) async {
     await _getServerUrl();
    // final uri = Uri.parse('$_serverAIUrl/pet_filter');
    String finalUrl = _serverAIUrl+"pet_filter_dog";
     final uri = Uri.parse(finalUrl);
    print(uri);
    // final uri = Uri.parse('http://10.0.2.2:5000/pet_filter');
   
    final request = http.MultipartRequest('POST', uri);

    request.files.add(await http.MultipartFile.fromPath('petImage', pickedImage.path));
    request.fields['petFilterCat'] = "galsses";
 
    print("request: ");
    print(request);

    try {
      final response = await request.send(); 
      print("기다리는중");
      await Future.delayed(const Duration(seconds: 5)); 
      print("다 기다림");  
      if (response.statusCode == 200) {
        final responseData = await response.stream.toBytes(); 
        print(responseData);
        final tempDir = await getTemporaryDirectory();
        final tempPath = tempDir.path;
        String tempFileName = '${DateTime.now().millisecondsSinceEpoch}.png';
        String tempFilePath = '$tempPath/$tempFileName';

        await File(tempFilePath).writeAsBytes(responseData); 

        return XFile(tempFilePath); 
      } else {
        print("Failed to apply filter. Status code: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Error applying filter: $e");
      return null; 
    }
  }
  String _getEncodingSex(bool sexNm, bool neuterYn){
    if(sexNm == true){
      if(neuterYn == true){
        return "CM"; 
      }
      else{
        return "IM";
      }
    }
    else{
      if(neuterYn == true){
        return "SF";
      }
      else{
        return "IF";
      }
    }
  }
  String _getExersice(int value){
    if(value ==0){
      return "LOW";
    }
    else if(value == 1){
      return "MID";
    }
    else{
      return "HIGH";
    }
  }

  String _getDefaction(int value){
    if(value ==0 ){
      return "NORMAL";
    }
    else{
      return "STRANGE";
    }
  }

  String _getFoodKind(int value){
    if(value ==0){
return "FEED";
    }
    else if(value ==1){
return "FEE_FOOD";
    }
  else{
    return "FOOD";
  }
  }

  Future <Map<String, dynamic>> getPetDiseaseRecommendation(int petPk) async {
   await _getServerUrl();
   String url = _serverAIUrl+"PetDiseaseRecommend";
  final uri = Uri.parse(url);
  print(uri);
  Map<String,dynamic> petInfo = await _petServer.getPetInfo(petPk);
  Map<String,dynamic> petAddInfo = await _petServer.getAddPetInfo(petPk);
  Map<String,dynamic> petOnlyAddInfo =petAddInfo['petExtraInfo'];
  PetBreedList _petBreedList = PetBreedList();
   int currentYear = DateTime.now().year;
   String strPetBirthYear = petInfo['birth'].toString();
   String yearSubStr = strPetBirthYear.substring(0,4);
   int petBirtYear = int.parse(yearSubStr);
   int age = currentYear - petBirtYear;

  // JSON 데이터로 POST 요청을 생성
  final requestBody = {
    'species': _petBreedList.findSpeciesValue(petInfo['speciesName']),
    'breed': petInfo['speciesName'],
    'age': 2,
    'pet_class': petInfo['hair']==0?"SH":"LH",
    'sex': _getEncodingSex(petInfo['sexNm'], petInfo['neuterYn']),
    'weight': petInfo['weight'],
    'environment': petOnlyAddInfo['environment'] == 0 ?"IN_DOOR" : "OUT_DOOR",
    'exercise': _getExersice(petOnlyAddInfo['exercise']),
    'defecation': 'NORMAL',
    'food_count': petOnlyAddInfo['foodCnt'],
    'food_amount': 4,
    'snack_amount': petOnlyAddInfo['snackCnt'],
    'food_kind': _getFoodKind(petOnlyAddInfo['foodKind']),
  }; 
  print(requestBody);

  try {
    // POST 요청을 보냅니다.
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json; charset=utf-8'},
      body: jsonEncode(requestBody),
    );

    // 상태 코드가 200이면 성공으로 간주합니다.
    if (response.statusCode == 200) {
      final responseData = jsonDecode(utf8.decode(response.bodyBytes));
      print("responseData $responseData");
        List<dynamic> responseMap = responseData['response'];
        Map<String,dynamic> data = responseMap[0];
        print(responseMap);
      print(data);
  
      return  data;
    } else {
      print("Failed to get pet disease recommendation. Status code: ${response.statusCode}");
      return {};
    }
  } catch (e) {
    print("Error during request: $e");
    return {};
  }
}




  Future<List<List<int>>> applyPetColor( XFile pickedImage) async {
     await _getServerUrl();
    final uri = Uri.parse('$_serverAIUrl/pet_color');
    final request = http.MultipartRequest('POST', uri);
    print("pickedImage.path: ");
    print(pickedImage.path);

    request.files.add(await http.MultipartFile.fromPath('petImage', pickedImage.path));

    try {
      final response = await request.send(); 
    
      if (response.statusCode == 200) {
    final responseData = await response.stream.bytesToString();

     final Map<String, dynamic> parsedData = json.decode(responseData);


    // 리스트 추출
    List<List<int>> colors = List<List<int>>.from(
      parsedData['response'].map((color) => List<int>.from(color))
    );
    print(colors);

        return colors; 
      } else {
        print("Failed to apply filter. Status code: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("Error applying filter: $e");
      return []; 
    }
  }
  
}
