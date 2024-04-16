import 'dart:math';
import 'package:flutter/material.dart';

class AppBarList{
  List<Map<String,dynamic>> _hospitalAppBar=[
    {'imgUrl':'assets/img/hospitalIcon.png','title':'병원찾기'},
     {'imgUrl':'assets/img/hospitalIcon.png','title':'명냥접종'},
       {'imgUrl':'assets/img/hospitalIcon.png','title':'피부병'},
         {'imgUrl':'assets/img/hospitalIcon.png','title':'질병찾기'},
     
    ];

     List<Map<String,dynamic>> _lifeAppBar=[
    {'imgUrl':'assets/img/hospitalIcon.png','title':'펫필터'},
     {'imgUrl':'assets/img/hospitalIcon.png','title':'반려동물팁'},
       {'imgUrl':'assets/img/hospitalIcon.png','title':'펫다이어리'},
         {'imgUrl':'assets/img/hospitalIcon.png','title':'펫스피커'},
     
    ];

  AppBarList();

   List<Map<String,dynamic>> getHospitalAppBar(){
    return _hospitalAppBar;
  }

  List<Map<String,dynamic>> getLifeAppBar(){
    return _lifeAppBar;
  }
  }