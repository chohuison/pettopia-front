import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pettopia_front/hospital/page/hospitalMap.dart';
import 'package:pettopia_front/hospital/page/kakaoMap.dart';
import 'package:pettopia_front/server/kakaoMapServer.dart';

class HospitalValue extends StatefulWidget {
  final Map<String, dynamic> value;

  const HospitalValue({
    Key? key,
    required this.value,
  }) : super(key: key);

  @override
  _HospitalValueState createState() => _HospitalValueState();
}

class _HospitalValueState extends State<HospitalValue> {
  late Map<String, dynamic> xyValue;
  bool _isTapped = false;
  final kakaoMapServer _kakaoServer = kakaoMapServer();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411.4, 683.4),
      builder: (context, child) {
        return Container(
          margin: EdgeInsets.only(
            top: 0.0.h,
            left: 10.0.w,
            right: 10.w,
            bottom: 10.h,
          ),
          width: 350.w,
          height: _isTapped ? 350.h : 90.h,
          decoration: BoxDecoration(
            color: Color(0xFFF5EBE0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            children: [
              Row(
                children: <Widget>[
                  Container(
                    width: 250.w,
                    margin: EdgeInsets.only(
                      top: 15.0.h,
                      left: 10.0.w,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.value['name'],
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.value['address'],
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                        Text(
                          widget.value['phoneNumber'],
                          style: TextStyle(
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      xyValue =
                          await _kakaoServer.getXY(widget.value['address']);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HospitalMap(
                                  xyValue: xyValue, value: widget.value)));

                      // setState(() {
                      //   _isTapped = !_isTapped;
                      // });
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                        top: 5.0.h,
                        left: 15.0.w,
                        bottom: 5.h,
                      ),
                      width: 50.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: Color(0xFFAFA59B),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      // 여기에 아이콘을 추가할 수 있습니다
                    ),
                  ),
                ],
              ),
              if (_isTapped)
                Expanded(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 10.h, 0, 0),
                    color: Colors.transparent,
                    child: KakaoMap(
                      x: xyValue['x'],
                      y: xyValue['y'],
                      name: widget.value['name'],
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
