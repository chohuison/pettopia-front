import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pettopia_front/enum/LiveType.dart';

class Medicen extends StatefulWidget {
  final Function(String, String) onHandleMedicen;
  final Function(int, String, String) addMedicen;
  const Medicen({
    Key? key,
    required this.onHandleMedicen,
    required this.addMedicen,
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
  int _widgetPk = 0;
  String _errorMessage = "";
  final TextEditingController _textController1 = TextEditingController();
  final TextEditingController _textController2 = TextEditingController();

  void _handleName(String value) {
    _name = value;
    widget.onHandleMedicen(
      _name,
      _count,
    );
  }

  void _handleCount(String value) {
    _count = value;
    widget.onHandleMedicen(
      _name,
      _count,
    );
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
              _textFieldName("이름", _handleName, "약 이름을 입력해주세요", false),
              _textFieldCount("투약 횟수", _handleCount, "투약 횟수를 입력해주세요", true),
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
              ),
              SizedBox(height: 20.h),
            ],
          ),
          Container(
              margin: EdgeInsets.only(right: 30.w),
              color: Color(0xFFD5BDAF),
              height: 2.h,
              width: 270.w),
          GestureDetector(
            onTap: () {
              if (_name == "" || _count == "") {
                setState(() {
                  _errorMessage = "약 정보를 모두 입력해주세요";
                });
              } else {
                widget.addMedicen(_widgetPk, _name, _count);
                setState(() {
                  _textController1.clear(); // 텍스트 필드 초기화
                  _textController2.clear(); // 텍스트 필드 초기화
                });
                _widgetPk = _widgetPk + 1;
              }
            },
            child: Container(
              child: Stack(children: [
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
                Positioned(
                    child: Container(
                        margin: EdgeInsets.only(right: 30.w, top: 5.h),
                        child: Container(
                          width: 30.w,
                          height: 30.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              // 테두리 설정
                              color: Color(0xFFD5BDAF), // 테두리 색상
                              width: 3, // 테두리 두께
                              style: BorderStyle.solid, // 테두리 스타일
                            ),
                          ),
                        )))
              ]),
            ),
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

  Widget _textFieldName(String containerName, Function controller,
      String labelText, bool isDigit) {
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
                controller: _textController1,
                keyboardType: isDigit ? TextInputType.number : null,
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

  Widget _textFieldCount(String containerName, Function controller,
      String labelText, bool isDigit) {
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
                controller: _textController2,
                keyboardType: isDigit ? TextInputType.number : null,
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
