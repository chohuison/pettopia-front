import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ViewPetAddInfo extends StatefulWidget {
  const ViewPetAddInfo({Key? key}) : super(key: key);

  @override
  _ViewPetAddInfoState createState() => _ViewPetAddInfoState();
}

class _ViewPetAddInfoState extends State<ViewPetAddInfo>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
        width: 300.w,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 5.h,
            ),
            Center(
              child: Text(
                "추가 정보",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
              ),
            ),
            Container(
              width: 280.w,
              child: Column(
                children: <Widget>[
                  _typeContainer("생활환경", "실내"),
                  _typeContainer("운동강도", "중(매일 30분 이하)"),
                  _typeContainer("식사", "3회(전용 사료 + 사람 음식)"),
                  _typeContainer("간식", "2회"),
                  _typeContainer("약", "O"),
                  // ToDo
                  // 약 동적생성해야 함
                ],
              ),
            ), // -> 보호자 정보 end

            Container(
              // margin: EdgeInsets.fromLTRB(0, 10.h, 0, 10.h),
              child: _modifyButton(),
            )
          ],
        ));
  }

  Widget _typeContainer(String name, String state) {
    return Row(
      children: [
        Container(
            width: 80.w,
            height: 30.h,
            margin: EdgeInsets.fromLTRB(0, 10.h, 10.w, 0),
            decoration: BoxDecoration(
              color: Color(0xFFD5BDAF),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Center(
                child: Text(
              name,
            ))),
        Container(
            margin: EdgeInsets.fromLTRB(0, 10.h, 10.w, 0), child: Text(state))
      ],
    );
  }

  Widget _modifyButton() {
    return Container(
      height: 30.h,
      width: 100.w,
      margin: EdgeInsets.fromLTRB(0, 10.h, 10.w, 15.h),
      child: ElevatedButton(
        onPressed: () {},
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFAFA59B)),
        ),
        child: Center(
          child: Text(
            '수정',
            style: TextStyle(fontSize: 15.sp, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
