import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pettopia_front/hospital/widget/hospitalValue.dart';

class HospitalList extends StatefulWidget {
  final List<Map<String, dynamic>> hospitalList;
  const HospitalList({
    Key? key,
    required this.hospitalList,
  }) : super(
          key: key,
        );

  @override
  _HospitalListState createState() => _HospitalListState();
}

class _HospitalListState extends State<HospitalList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: widget.hospitalList.length,
      itemBuilder: (BuildContext context, int index) {
        if (widget.hospitalList != null && index < widget.hospitalList.length) {
          final record = widget.hospitalList[index]!;
          return HospitalValue(
            value: record,
          );
        } else {
          // hospitalList가 null이거나 index가 범위를 벗어나는 경우에 대한 처리
          return SizedBox(); // 혹은 다른 처리를 수행할 수 있음
        }
      },
    );
  }
}
