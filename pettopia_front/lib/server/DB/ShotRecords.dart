import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';

class ShotRecords{
  final String serverUrl='http://10.0.2.2:8080/api/v1/shot_records/';
  
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
    final url = Uri.parse(serverUrl);
    final headers ={'Content-Type': 'application/json'};
    final body =jsonEncode(AddShotRecordRequestToJson(petPk, type, num, age));

    final response = await http.post(
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



}