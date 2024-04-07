import 'dart:math';
import 'package:flutter/material.dart';

class Region{
  final List<String>_regionList = [
    "강남구",
    "강동구",
    "강서구",
    "강북구",
    "관악구",
    "구로구",
    "금천구",
    "노원구",
    "동대문구",
    "도봉구",
    "동작구",
    "마포구",
    "서대문구",
    "성동구",
    "성북구",
    "서초구",
    "송파구",
    "영등포구",
    "용산구",
    "양천구",
    "은평구",
    "종로구",
    "중구",
    "중랑구"
  ];

  Region();

  List<String> getRegionList(){
    return _regionList;
  }
  }