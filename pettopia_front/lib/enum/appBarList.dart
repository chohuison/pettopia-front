import 'dart:math';
import 'package:flutter/material.dart';
import 'package:pettopia_front/hospital/page/findDisease.dart';
import 'package:pettopia_front/hospital/page/hospitalSearch.dart';
import 'package:pettopia_front/hospital/page/shortRecords.dart';
import 'package:pettopia_front/life/page/petDiary.dart';
import 'package:pettopia_front/life/page/petFilter.dart';
import 'package:pettopia_front/life/page/petTip.dart';
import 'package:pettopia_front/server/DB/Pet.dart';

import 'package:pettopia_front/life/page/writeDiary.dart';

class AppBarList {
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
  Future<void> _getList() async {
    _petList = await _petServer.getPetList();
  }

  List<Map<String, dynamic>> getHospitalAppBar() {
    return _hospitalAppBar;
  }

  void hospitalAppBarHandler(int index, BuildContext context) {
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
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FindDisease()),
      );
    }
  }

  void beautyAppBarHandler(int index, BuildContext context) {
    if (index == 0) {
    } else {}
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
      await _getList();
      print("가져온 petList");
      print(_petList);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PetDiary(
                    petList: _petList,
                  )));
    }
  }

  List<Map<String, dynamic>> getLifeAppBar() {
    return _lifeAppBar;
  }

  List<Map<String, dynamic>> getBeautyAppBar() {
    return _beautyAppBar;
  }
}
