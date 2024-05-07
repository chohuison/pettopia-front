import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pettopia_front/enum/LiveType.dart';

class Medicen extends StatefulWidget {
  final Function(String, String) onHandleMedicen;
  const Medicen({
    Key? key,
    required this.onHandleMedicen,
  }) : super(
          key: key,
        );

  @override
  __MedicenStatetate createState() => __MedicenStatetate();
}

class __MedicenStatetate extends State<Medicen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  String _count = "";
  String _name = "";
  void _handleName(String value) {
    _name = value;
    widget.onHandleMedicen(_count, _name);
  }

  void _handleCount(String value) {
    _count = value;
    widget.onHandleMedicen(_count, _name);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // AutomaticKeepAliveClientMixin 사용 시 추가
    return Container(
      margin: EdgeInsets.only(left: 30.w),
      child: Column(
        children: [
          Column(
            children: <Widget>[
              SizedBox(
                height: 5.h,
              ),
              Center(
                child: Text(
                  "약",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
                ),
              ),
              _textField("이름", _handleName, "약 이름을 입력해주세요"),
              _textField("투약 횟수", _handleCount, "투약 횟수를 입력해주세요"),
              SizedBox(height: 20.h),
            ],
          ),
          Container(
              margin: EdgeInsets.only(right: 30.w),
              color: Color(0xFFD5BDAF),
              height: 2.h,
              width: 270.w),
              Stack(
                children: [
                    Positioned(
                      right: 25.w,
                      child: Container(
             
              child: Icon(
                Icons.add, // 플러스 아이콘
                color: Color(0xFFD5BDAF), // 아이콘 색상
                size: 40.sp, // 아이콘 크기
              ),
            ),
                    ),
                    Positioned(child: Container(
            margin: EdgeInsets.only(right: 30.w, top:5.h),
              child: Container(
            width: 30.w,
            height: 30.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all( // 테두리 설정
              color: Color(0xFFD5BDAF),// 테두리 색상
              width: 3, // 테두리 두께
              style: BorderStyle.solid, // 테두리 스타일
            ),
            ),
            
          )))
                ]
              
              )
          
        ],
      ),
    );
  }

  Widget _typeContainer(String name, int height) {
    return Container(
        width: 80.w,
        height: 30.h,
        margin: EdgeInsets.only(right: 10.w, top: height.h),
        decoration: BoxDecoration(
          color: Color(0xFFD5BDAF),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Center(
            child: Text(
          name,
        )));
  }

  Widget _textField(
      String containerName, Function controller, String labelText) {
    return Row(
      children: <Widget>[
        _typeContainer(containerName, 13),
        SizedBox(width: 10.w),
        Container(
            width: 170.w,
            child: TextField(
                onChanged: (text) {
                  controller(text);
                },
                decoration: InputDecoration(
                  hintText: labelText,
                  //  contentPadding: EdgeInsets.symmetric(horizontal: horizontal.w,vertical: vertical.h),

                  hintStyle: TextStyle(
                    fontSize: 11.0.sp,
                    color: Color(0xFFAFA59B),
                  ),
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFD5BDAF)),
                  ),
                ))),
      ],
    );
  }
}
