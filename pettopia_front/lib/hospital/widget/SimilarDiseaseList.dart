import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pettopia_front/hospital/widget/SilimarDiseaseListValue.dart';

class SilimarDiseaseList extends StatefulWidget {
  final List<Map<String, dynamic>> diseaseList;
  const SilimarDiseaseList({
    Key? key,
    required this.diseaseList,
  }) : super(
          key: key,
        );

  @override
  _SilimarDiseaseListState createState() => _SilimarDiseaseListState();
}

class _SilimarDiseaseListState extends State<SilimarDiseaseList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: widget.diseaseList.length,
      itemBuilder: (BuildContext context, int index) {
        if (widget.diseaseList != null && index < widget.diseaseList.length) {
          final record = widget.diseaseList[index]!;
          return SilimarListValue(
            value: record,
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}
