import 'dart:math';
import 'package:flutter/material.dart';

class PetBreedList {
 

  PetBreedList();

List<Map<String, dynamic>> _speciesList = [
  {'pk': 1, 'species': '그레이하운드', 'speciesName': 'GRE'},
  {'pk': 2, 'species': '달마시안', 'speciesName': 'DAL'},
  {'pk': 3, 'species': '더치 세퍼드', 'speciesName': 'DAS'},
  {'pk': 4, 'species': '도베르만', 'speciesName': 'DOB'},
  {'pk': 5, 'species': '골든 리트리버', 'speciesName': 'GOL'},
  {'pk': 6, 'species': '라브라도 리트리버', 'speciesName': 'LAB'},
  {'pk': 7, 'species': '말티즈', 'speciesName': 'MAL'},
  {'pk': 8, 'species': '불독', 'speciesName': 'BUL'},
  {'pk': 9, 'species': '비글', 'speciesName': 'BEA'},
  {'pk': 10, 'species': '비숑 프리제', 'speciesName': 'BIC'},
  {'pk': 11, 'species': '셰퍼드', 'speciesName': 'SHE'},
  {'pk': 12, 'species': '슈나우저', 'speciesName': 'SCH'},
  {'pk': 13, 'species': '드리버', 'speciesName': 'DRI'},
  {'pk': 14, 'species': '웰시 코기', 'speciesName': 'WEL'},
  {'pk': 15, 'species': '제프 잭 러셀 테리어', 'speciesName': 'GER'},
  {'pk': 16, 'species': '진돗개', 'speciesName': 'JIN'},
  {'pk': 17, 'species': '차우차우', 'speciesName': 'CHL'},
  {'pk': 18, 'species': '차이니스 샤페이', 'speciesName': 'CHS'},
  {'pk': 19, 'species': '코카 스파니엘', 'speciesName': 'COC'},
  {'pk': 20, 'species': '테리어', 'speciesName': 'TER'},
  {'pk': 21, 'species': '포메라니안', 'speciesName': 'POM'},
  {'pk': 22, 'species': '푸들', 'speciesName': 'POO'},
  {'pk': 23, 'species': '하운드', 'speciesName': 'HOU'},
  {'pk': 24, 'species': '허스키', 'speciesName': 'HUS'},
  {'pk': 25, 'species': '혼합견', 'speciesName': 'MUT'},
  {'pk': 26, 'species': '밀리터리언', 'speciesName': 'MIL'},
  {'pk': 27, 'species': '미스티즈', 'speciesName': 'MIS'},
  {'pk': 28, 'species': '기타', 'speciesName': 'ETC'},
  {'pk': 29, 'species': '고려견', 'speciesName': 'KOR'},
  {'pk': 30, 'species': '러시안 토이 테리어', 'speciesName': 'RUS'},
  {'pk': 31, 'species': '페르시안 친칠라', 'speciesName': 'PER'},
  {'pk': 32, 'species': '시베리안 하스키', 'speciesName': 'SIA'},
  {'pk': 33, 'species': '터키시 앙고라', 'speciesName': 'TUR'},
  {'pk': 34, 'species': '스코티시 폴드', 'speciesName': 'SCO'},
  {'pk': 35, 'species': '혼합견', 'speciesName': 'MIX'},
  {'pk': 36, 'species': '기타', 'speciesName': 'ETC'}
];


List<Map<String ,dynamic >> getSpecies(){
  return _speciesList;
}
String findSpeciesBySpeciesName(String speciesName) {
  // 주어진 speciesName과 일치하는 항목을 찾기 위해 리스트를 순회합니다.
  for (var pet in _speciesList) {
    if (pet['speciesName'] == speciesName) {
      return pet['species']; // 일치하는 species 값을 반환합니다.
    }
  }
  // 일치하는 값이 없으면 null을 반환합니다.
  return "";
}

int findSpeciesPk(String speciesName){
   for (var pet in _speciesList) {
    if (pet['speciesName'] == speciesName) {
      return pet['pk']; // 일치하는 species 값을 반환합니다.
    }
  }

  return 1;
}

String getSpicesNmae(String species){
   String speciesVlue = findSpeciesBySpeciesName(species);
return speciesVlue;
}

String speciesNameByPk (int pk){
    // 주어진 speciesName과 일치하는 항목을 찾기 위해 리스트를 순회합니다.
  for (var pet in _speciesList) {
    if (pet['pk'] == pk) {
      return pet['speciesName']; // 일치하는 species 값을 반환합니다.
    }
  }
  // 일치하는 값이 없으면 null을 반환합니다.
  return "";
}

}
