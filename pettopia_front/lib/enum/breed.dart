import 'dart:math';
import 'package:flutter/material.dart';

class Breed {
  final List<String> _breednList = ["강아지", "고양이"];

  Breed();

  List<String> getBreedList() {
    return _breednList;
  }
}
