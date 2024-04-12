import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShortWriteValue extends StatefulWidget {
  const ShortWriteValue({
    Key? key,
  }) : super(key: key);

  @override
  _ShortWriteValueState createState() => _ShortWriteValueState();
}

class _ShortWriteValueState extends State<ShortWriteValue>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Column(children: <Widget>[
      SizedBox(
  height: 5.h,
),
      Container(
          height: 30.h,
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 30.w,
              ),

              Container(
                width: 65.w,
                height: 30.h,
                decoration: BoxDecoration(
                  color: Color(0xFF9F8678),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  // 텍스트를 수평 및 수직으로 가운데로 정렬합니다.
                  child: Text(
                    "날짜",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 30.w,
              ),
              Text("2023년 3월 1일 금요일")
            ],
          )
          ),

SizedBox(
  height: 10.h,
),

Container(
          height: 30.h,
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 30.w,
              ),
              
              Container(
                width: 65.w,
                height: 30.h,
                decoration: BoxDecoration(
                  color: Color(0xFF9F8678),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  // 텍스트를 수평 및 수직으로 가운데로 정렬합니다.
                  child: Text(
                    "이름",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 30.w,
              ),
              Text("2023년 3월 1일 금요일")
            ],
          )
          ),
SizedBox(
  height: 10.h,
),
          Container(
          height: 30.h,
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 30.w,
              ),
              
              Container(
                width: 65.w,
                height: 30.h,
                decoration: BoxDecoration(
                  color: Color(0xFF9F8678),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  // 텍스트를 수평 및 수직으로 가운데로 정렬합니다.
                  child: Text(
                    "종류",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 30.w,
              ),
              Text("2023년 3월 1일 금요일")
            ],
          )
          ),
SizedBox(
  height: 10.h,
),
          Container(
          height: 30.h,
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 30.w,
              ),
              
              Container(
                width: 65.w,
                height: 30.h,
                decoration: BoxDecoration(
                  color: Color(0xFF9F8678),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  // 텍스트를 수평 및 수직으로 가운데로 정렬합니다.
                  child: Text(
                    "차시",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 30.w,
              ),
              Text("2023년 3월 1일 금요일")
            ],
          )
          ),
SizedBox(
  height: 10.h,
),
          Container(
          height: 30.h,
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 30.w,
              ),
              
              Container(
                width: 65.w,
                height: 30.h,
                decoration: BoxDecoration(
                  color: Color(0xFF9F8678),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  // 텍스트를 수평 및 수직으로 가운데로 정렬합니다.
                  child: Text(
                    "나이",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 30.w,
              ),
              Text("2023년 3월 1일 금요일")
            ],
          )
          ),
          
      
    ]);
  }
}
