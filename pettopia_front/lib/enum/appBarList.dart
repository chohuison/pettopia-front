import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:pettopia_front/beauty/page/beautyMap.dart';
import 'package:pettopia_front/beauty/page/petsnalColor.dart';
import 'package:pettopia_front/hospital/page/findDisease.dart';
import 'package:pettopia_front/hospital/page/hospitalSearch.dart';
import 'package:pettopia_front/hospital/page/shortRecords.dart';
import 'package:pettopia_front/hospital/page/skinDisease.dart';
import 'package:pettopia_front/hospital/widget/cnaPetFindDesisePopUp.dart';
import 'package:pettopia_front/life/page/petDiary.dart';
import 'package:pettopia_front/life/page/petFilter.dart';
import 'package:pettopia_front/life/page/petSpeacker.dart';
import 'package:pettopia_front/life/page/petTip.dart';
import 'package:pettopia_front/server/DB/Pet.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pettopia_front/life/page/writeDiary.dart';

class AppBarList {
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  List<Map<String, dynamic>> _hospitalAppBar = [
    {'imgUrl': 'assets/img/hospitalIcon.png', 'title': '병원찾기'},
    {'imgUrl': 'assets/img/hospitalIcon.png', 'title': '명냥접종'},
    {'imgUrl': 'assets/img/hospitalIcon.png', 'title': '피부병'},
    {'imgUrl': 'assets/img/hospitalIcon.png', 'title': '질병찾기'},
  ];

  late List<Map<String, dynamic>> _petList = [];
  Pet _petServer = Pet();

  List<Map<String, dynamic>> _lifeAppBar = [
    {'imgUrl': 'assets/img/hospitalIcon.png', 'title': '펫필터'},
    {'imgUrl': 'assets/img/hospitalIcon.png', 'title': '반려동물팁'},
    {'imgUrl': 'assets/img/hospitalIcon.png', 'title': '펫다이어리'},
    {'imgUrl': 'assets/img/hospitalIcon.png', 'title': '펫스피커'},
  ];

  List<Map<String, dynamic>> _beautyAppBar = [
    {'imgUrl': 'assets/img/hospitalIcon.png', 'title': '펫스널컬러'},
    {'imgUrl': 'assets/img/hospitalIcon.png', 'title': '미용실 찾기'},
  ];

  AppBarList();
  Future<void> _getList(BuildContext context) async {
    _petList = await _petServer.getPetList(context);
  }

  List<Map<String, dynamic>> getHospitalAppBar() {
    return _hospitalAppBar;
  }

  Future<void> hospitalAppBarHandler(int index, BuildContext context) async {
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HospitalSearch()),
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ShortRecords()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SkinDisease()),
      );
    } else if (index == 3) {
      List<Map<String, dynamic>> petList = await _getPetIsAddList();
      if (petList.length > 0) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => FindDisease(
                    petList: petList,
                  )),
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: CanFindDiseasePopUP(),
              surfaceTintColor: Colors.white,
            );
          },
        );
      }
    }
  }

  Future<List<Map<String, dynamic>>> _getPetIsAddList() async {
    List<Map<String, dynamic>> result = [];
    String? jsonData = await _storage.read(key: 'pet');
    if (jsonData != null) {
      List<dynamic> defaultPetList = jsonDecode(jsonData);
      for (dynamic value in defaultPetList) {
        if (value['isAddInfo'] == true) {
          result.add({'petPk': value['pk'], 'dogNm': value['dogNm']});
        }
      }
    }
    return result;
  }

  void beautyAppBarHandler(int index, BuildContext context) {
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PetsnalColor()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BeautyMapSearch()),
      );
    }
  }

  Future<void> lifeAppBarHandler(int index, BuildContext context) async {
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PetFilter()),
      );
    } else if (index == 1) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => PetTip()));
    } else if (index == 2) {
      await _getList(context);
      print("가져온 petList");
      print(_petList);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PetDiary(
                    petList: _petList,
                  )));
    } else if (index == 3) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => PetSpeaker()));
    }
  }

  List<Map<String, dynamic>> getLifeAppBar() {
    return _lifeAppBar;
  }

  List<Map<String, dynamic>> getBeautyAppBar() {
    return _beautyAppBar;
  }
}
