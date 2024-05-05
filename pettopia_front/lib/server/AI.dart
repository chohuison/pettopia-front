import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';


class AI {
  final String serverUrl='http://10.0.2.2:5000';

  AI();


  Future<XFile?> applyPetFilter( XFile pickedImage, String species, String noseFilter, String hornsFilter) async {
    final uri = Uri.parse('$serverUrl/pet_filter');
    final request = http.MultipartRequest('POST', uri);


    request.files.add(await http.MultipartFile.fromPath('petImage', pickedImage.path));
    request.fields['species'] = species;
    request.fields['petFilterNose'] = noseFilter;
    request.fields['petFilterHorns'] = hornsFilter; 

    try {
      final response = await request.send(); 
      print("기다리는중");
      await Future.delayed(const Duration(seconds: 5)); 
      print("다 기다림");  
      if (response.statusCode == 200) {
        final responseData = await response.stream.toBytes(); 
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

  Future<List<Map<String, dynamic>>> getPetDiseaseRecommendation() async {
  final uri = Uri.parse('$serverUrl/PetDiseaseRecommend');

  // JSON 데이터로 POST 요청을 생성
  final requestBody = {
    'species': '강아지',
    'breed': 'BEA',
    'age': 2,
    'pet_class': 'SH',
    'sex': 'IM',
    'weight': 10.4,
    'environment': 'IN_DOOR',
    'exercise': 'LOW',
    'defecation': 'NORMAL',
    'food_count': 4,
    'food_amount': 4,
    'snack_amount': 1,
    'food_kind': 'FEED',
  }; 

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
      List<Map<String,dynamic>> list = [];
      list.add(responseData['response']);
      print(list);
      return  list;
    } else {
      print("Failed to get pet disease recommendation. Status code: ${response.statusCode}");
      return [];
    }
  } catch (e) {
    print("Error during request: $e");
    return [];
  }
}



  
}
