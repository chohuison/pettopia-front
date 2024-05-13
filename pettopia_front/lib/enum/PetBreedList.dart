import 'dart:math';
import 'package:flutter/material.dart';

class PetBreedList {
 

  PetBreedList();

final List<Map<String, dynamic>> _speciesList = [
  {'pk': 1, 'species': '그레이하운드'},
  {'pk': 2, 'species': '달마시안'},
  {'pk': 3, 'species': '더치 세퍼드'},
  {'pk': 4, 'species': '도베르만'},
  {'pk': 5, 'species': '골든 리트리버'},
  {'pk': 6, 'species': '라브라도 리트리버'},
  {'pk': 7, 'species': '말티즈'},
  {'pk': 8, 'species': '불독'},
  {'pk': 9, 'species': '비글'},
  {'pk': 10, 'species': '비숑 프리제'},
  {'pk': 11, 'species': '셰퍼드'},
  {'pk': 12, 'species': '슈나우저'},
  {'pk': 13, 'species': '드리버'},
  {'pk': 14, 'species': '웰시 코기'},
  {'pk': 15, 'species': '제프 잭 러셀 테리어'},
  {'pk': 16, 'species': '진돗개'},
  {'pk': 17, 'species': '차우차우'},
  {'pk': 18, 'species': '차이니스 샤페이'},
  {'pk': 19, 'species': '코카 스파니엘'},
  {'pk': 20, 'species': '테리어'},
  {'pk': 21, 'species': '포메라니안'},
  {'pk': 22, 'species': '푸들'},
  {'pk': 23, 'species': '하운드'},
  {'pk': 24, 'species': '허스키'},
  {'pk': 25, 'species': '혼합견'},
  {'pk': 26, 'species': '밀리터리언'},
  {'pk': 27, 'species': '미스티즈'},
  {'pk': 28, 'species': '기타'},
  {'pk': 29, 'species': '고려견'},
  {'pk': 30, 'species': '러시안 토이 테리어'},
  {'pk': 31, 'species': '페르시안 친칠라'},
  {'pk': 32, 'species': '시베리안 하스키'},
  {'pk': 33, 'species': '터키시 앙고라'},
  {'pk': 34, 'species': '스코티시 폴드'},
  {'pk': 35, 'species': '혼합견'},
  {'pk': 36, 'species': '기타'},
];

List<Map<String ,dynamic >> getSpecies(){
  return _speciesList;
}

}
