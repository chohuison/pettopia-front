import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pettopia_front/hospital/widget/SilimarDiseaseListValue.dart';

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
        // return SilimarListValue(
        //   value: record,
        // );
      },
    );
  }
}
