import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ViewPetInfo extends StatefulWidget {
  const ViewPetInfo({Key? key}) : super(key: key);

  @override
  _ViewPetInfoState createState() => _ViewPetInfoState();
}

class _ViewPetInfoState extends State<ViewPetInfo>
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

            // 반려동물 정보
            Center(
              child: Text(
                "반려동물 정보",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
              ),
            ),
            Container(
              //decoration: BoxDecoration(color: Colors.yellow),
              width: 300.w,
              height: 100.h,
              child: Row(
                children: <Widget>[
                  // 사진, 이름, 품종, 등록번호
                  Container(
                      //decoration: BoxDecoration(color: Colors.green),
                      height: 100.h,
                      child: Row(
                        children: [
                          // 반려동물 사진
                          Container(
                            margin: EdgeInsets.fromLTRB(10.w, 0, 10.w, 0),
                            width: 80.w,
                            height: 80.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                //color: Colors.brown,
                                border: Border.all(
                                    width: 2.w, color: Color(0xFFE3D5CA))),
                          ),
                          // 이름, 품종, 등록번호
                          Container(
                            width: 170.w,
                            //color: Colors.green,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "뽀삐",
                                  style: TextStyle(fontSize: 15.sp),
                                ),
                                Text(
                                  "(말티즈)",
                                  style: TextStyle(fontSize: 15.sp),
                                ),
                                Text("000000000000"),
                              ],
                            ),
                          )
                        ],
                      )),
                ],
              ),
            ),
            //성별, 중성화
            Container(
              width: 280.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _typeContainer("성별", "남"),
                  _typeContainer("중성화", "O")
                ],
              ),
            ),
            // 반려동물 생년월일
            Container(
              width: 280.w,
              child: _typeContainer("생년월일", "2018-01-01"),
              margin: EdgeInsets.only(bottom: 10.h),
            ), // -> 반려동물 정보 end

            // 보호자 정보
            Center(
              child: Text(
                "보호자 정보",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
              ),
            ),
            Container(
              width: 280.w,
              child: Column(
                children: <Widget>[
                  _typeContainer("이름", "변아영"),
                  _typeContainer("연락처", "010-1234-5678"),
                  _typeContainer("생년월일", "2002-06-04")
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
