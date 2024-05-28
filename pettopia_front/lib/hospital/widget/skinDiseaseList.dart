import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pettopia_front/life/widget/breedValue.dart';

class SkinDiseaseList extends StatefulWidget {
  const SkinDiseaseList({
    Key? key,
  }) : super(
          key: key,
        );

  @override
  _SkinDiseaseListState createState() => _SkinDiseaseListState();
}

class _SkinDiseaseListState extends State<SkinDiseaseList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          width: 100.w,
          height: 50.h,
          color: Colors.grey,
        );
      },
    );
  }
}
