import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

// HTTP 요청 및 이미지 필터 작업을 위한 클래스
class AI {
  final String serverUrl; // 서버 URL

  AI(this.serverUrl);

  // POST 요청을 보내고 응답을 처리하는 메소드
  Future<XFile?> applyPetFilter( XFile pickedImage, String species, String noseFilter, String hornsFilter) async {
    final uri = Uri.parse('$serverUrl/pet_filter');
    final request = http.MultipartRequest('POST', uri);

    // 파일 및 폼 데이터 추가
    request.files.add(await http.MultipartFile.fromPath('petImage', pickedImage.path));
    request.fields['species'] = species; // '강아지' 또는 '고양이'
    request.fields['petFilterNose'] = noseFilter; // 코 필터
    request.fields['petFilterHorns'] = hornsFilter; // 뿔 필터

    try {
      final response = await request.send(); // POST 요청 전송
      print("기다리는중");
      await Future.delayed(const Duration(seconds: 5)); 
      print("다 기다림");  
      if (response.statusCode == 200) {
        final responseData = await response.stream.toBytes(); // 응답 데이터 읽기
        final tempDir = await getTemporaryDirectory(); // 임시 디렉터리
        final tempPath = tempDir.path;
        String tempFileName = '${DateTime.now().millisecondsSinceEpoch}.png';
        String tempFilePath = '$tempPath/$tempFileName';

        await File(tempFilePath).writeAsBytes(responseData); // 응답 데이터를 파일로 저장

        return XFile(tempFilePath); // XFile 객체 반환
      } else {
        print("Failed to apply filter. Status code: ${response.statusCode}");
        return null; // 실패 시 null 반환
      }
    } catch (e) {
      print("Error applying filter: $e");
      return null; // 예외 처리 시 null 반환
    }
  }
}
