import 'dart:math';
import 'package:flutter/material.dart';

class PetBreedList {
 

  PetBreedList();

List<Map<String, dynamic>> _speciesList = [
  {'pk': 1, 'species': '그레이하운드', 'speciesName': 'GRE', 'speciesValue':'강아지'},
  {'pk': 2, 'species': '달마시안', 'speciesName': 'DAL','speciesValue':'강아지'},
  {'pk': 3, 'species': '더치 세퍼드', 'speciesName': 'DAS','speciesValue':'강아지'},
  {'pk': 4, 'species': '도베르만', 'speciesName': 'DOB','speciesValue':'강아지'},
  {'pk': 5, 'species': '골든 리트리버', 'speciesName': 'GOL','speciesValue':'강아지'},
  {'pk': 6, 'species': '라브라도 리트리버', 'speciesName': 'LAB','speciesValue':'강아지'},
  {'pk': 7, 'species': '말티즈', 'speciesName': 'MAL','speciesValue':'강아지'},
  {'pk': 8, 'species': '불독', 'speciesName': 'BUL','speciesValue':'강아지'},
  {'pk': 9, 'species': '비글', 'speciesName': 'BEA','speciesValue':'강아지'},
  {'pk': 10, 'species': '비숑 프리제', 'speciesName': 'BIC','speciesValue':'강아지'},
  {'pk': 11, 'species': '셰퍼드', 'speciesName': 'SHE','speciesValue':'강아지'},
  {'pk': 12, 'species': '슈나우저', 'speciesName': 'SCH','speciesValue':'강아지'},
  {'pk': 13, 'species': '드리버', 'speciesName': 'DRI','speciesValue':'강아지'},
  {'pk': 14, 'species': '웰시 코기', 'speciesName': 'WEL','speciesValue':'강아지'},
  {'pk': 15, 'species': '제프 잭 러셀 테리어', 'speciesName': 'GER','speciesValue':'강아지'},
  {'pk': 16, 'species': '진돗개', 'speciesName': 'JIN','speciesValue':'강아지'},
  {'pk': 17, 'species': '차우차우', 'speciesName': 'CHL','speciesValue':'강아지'},
  {'pk': 18, 'species': '차이니스 샤페이', 'speciesName': 'CHS','speciesValue':'강아지'},
  {'pk': 19, 'species': '코카 스파니엘', 'speciesName': 'COC','speciesValue':'강아지'},
  {'pk': 20, 'species': '테리어', 'speciesName': 'TER','speciesValue':'강아지'},
  {'pk': 21, 'species': '포메라니안', 'speciesName': 'POM','speciesValue':'강아지'},
  {'pk': 22, 'species': '푸들', 'speciesName': 'POO','speciesValue':'강아지'},
  {'pk': 23, 'species': '하운드', 'speciesName': 'HOU','speciesValue':'강아지'},
  {'pk': 24, 'species': '허스키', 'speciesName': 'HUS','speciesValue':'강아지'},
  {'pk': 25, 'species': '혼합견', 'speciesName': 'MUT','speciesValue':'강아지'},
  {'pk': 26, 'species': '밀리터리언', 'speciesName': 'MIL','speciesValue':'강아지'},
  {'pk': 27, 'species': '미스티즈', 'speciesName': 'MIS','speciesValue':'강아지'},
  {'pk': 28, 'species': '기타', 'speciesName': 'ETC','speciesValue':'고양이'},
  {'pk': 29, 'species': '고려견', 'speciesName': 'KOR','speciesValue':'고양이'},
  {'pk': 30, 'species': '러시안 토이 테리어', 'speciesName': 'RUS','speciesValue':'고양이'},
  {'pk': 31, 'species': '페르시안 친칠라', 'speciesName': 'PER','speciesValue':'고양이'},
  {'pk': 32, 'species': '시베리안 하스키', 'speciesName': 'SIA','speciesValue':'고양이'},
  {'pk': 33, 'species': '터키시 앙고라', 'speciesName': 'TUR','speciesValue':'고양이'},
  {'pk': 34, 'species': '스코티시 폴드', 'speciesName': 'SCO','speciesValue':'고양이'},
  {'pk': 35, 'species': '혼합견', 'speciesName': 'MIX','speciesValue':'고양이'},
  {'pk': 36, 'species': '기타', 'speciesName': 'ETC','speciesValue':'고양이'}
];

String findSpeciesValue(String value){
  print(value);
  for(Map<String,dynamic>species  in _speciesList){
     print(species ['speciesName']);
    if(species ['speciesName'] == value){
      return species ['speciesValue'];
    }
    
  }
  return "";
}
Map<String ,dynamic> getSpeciesByPetInfo(String species){
  Map<String,dynamic> map = {};
  String speciesName = "";
  int pk =0;
  for(Map<String,dynamic> value in _speciesList){
    if(value['species']== species){
     
      speciesName = value['speciesName'];
      pk=value['pk'];
      break;
    }
  }
  if(speciesName == ""){
    speciesName = "ETC";
    pk=36;
  }
  map={'speciesName':speciesName, 'pk':pk};
  return map;
}


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
