import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pettopia_front/hospital/widget/SilimarDiseaseListValue.dart';

class SilimarDiseaseList extends StatefulWidget {
  final Map<String, dynamic> diseaseValue;
  const SilimarDiseaseList({
    Key? key,
    required this.diseaseValue,
  }) : super(
          key: key,
        );

  @override
  _SilimarDiseaseListState createState() => _SilimarDiseaseListState();
}

class _SilimarDiseaseListState extends State<SilimarDiseaseList> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 20.h),
        decoration: BoxDecoration(
          color: Color(0xFFF5EBE0),
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: Color(0xFFD5BDAF), // 테두리 색상
            width: 2.0.w, // 테두리 두께
          ),
        ),
        child: Column(
          children: <Widget>[
            //반려 동물 정보
            Container(
                child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  widget.diseaseValue['breed'],
                  style:
                      TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10.h,
                ),
                _Row("나이: ", widget.diseaseValue['age'].toString(), "단장모: ",
                    widget.diseaseValue['pet_class']),
                _Row("성별: ", widget.diseaseValue['sex'], "몸무게: ",
                    widget.diseaseValue['weight'].toString()),
                _Row("운동 강도: ", widget.diseaseValue['exercise'], "생활 환경: ",
                    widget.diseaseValue['environment']),
                _Row("배변 상태: ", widget.diseaseValue['defecation'], "식사량: ",
                    widget.diseaseValue['food_count']),
                _mealContainer("식사 종류: ", widget.diseaseValue['food_kind'])
              ],
            )),
            //질병 정보
            Container(
              margin: EdgeInsets.only(
                  left: 30.w, right: 30.w, top: 20.h, bottom: 20.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(
                  color: Color(0xFFD5BDAF), // 테두리 색상
                  width: 2.0.w, // 테두리 두께
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  _diseaseRow(
                    "질병 명: ",
                    widget.diseaseValue['disease_name'].toString(),
                  ),
                  _diseaseRow("CRP: ", widget.diseaseValue['CRP'].toString()),
                  _diseaseRow(" IgG: ", widget.diseaseValue['IgG'].toString()),
                  _diseaseRow("AFP: ", widget.diseaseValue['AFP'].toString()),
                  _diseaseRow(
                      "stress: ", widget.diseaseValue['stress'].toString()),
                ],
              ),
            )
          ],
        ));
  }

  Widget _Row(String name1, String value1, String name2, String value2) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 20.w,
        ),
        Container(
          width: 160.w,
          //color: Colors.blue,
          child: Row(
            children: [
              Text(
                name1,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(value1),
            ],
          ),
        ),
        SizedBox(width: 20.w),
        Row(
          children: [
            Text(
              name2,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(value2),
          ],
        ),
      ],
    );
  }

  Widget _mealContainer(String name, String value) {
    return Row(children: [
      SizedBox(
        width: 20.w,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    ]);
  }

  Widget _diseaseRow(String name, String value) {
    return Container(
      width: 270.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }
}
