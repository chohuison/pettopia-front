import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pettopia_front/enum/LiveType.dart';
import 'package:pettopia_front/life/widget/cntBox.dart';

class Medicine extends StatefulWidget {
  final Function(String, int) onHandleMedicine;
  final Function(int, String, int) addMedicine;
  const Medicine({
    Key? key,
    required this.onHandleMedicine,
    required this.addMedicine,
  }) : super(
          key: key,
        );

  @override
  __MedicineStatetate createState() => __MedicineStatetate();
}

class __MedicineStatetate extends State<Medicine>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  int _count = 0;
  String _name = "";
  int _widgetPk = 0;
  String _errorMessage = "";

  void _handleName(String value) {
    setState(() {
      _name = value;
    });

    widget.onHandleMedicine(
      _name,
      _count,
    );
  }

  void _handleMedicenCount(int value) {
    setState(() {
      _count = value;
    });
    print(_count);

    widget.onHandleMedicine(
      _name,
      _count,
    );
  }

  late int _medicineCnt = 0;

  @override
  Widget build(BuildContext context) {
    super.build(context); // AutomaticKeepAliveClientMixin 사용 시 추가
    return Column(
      children: [
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 100.w, right: 10.w),
              width: 100.w,
              child: TextField(
                onChanged: (text) {
                  _handleName(text);
                },
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    hintText: "약 종류",
                    hintStyle: TextStyle(
                      fontSize: 13.sp,
                      color: Color(0xFFAFA59B),
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFD5BDAF)),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFD5BDAF)),
                    )),
              ),
            ),
            CntBox(
              cnt: _medicineCnt,
              handleCount: _handleMedicenCount,
            )
          ],
        ),
        Text(
          _errorMessage,
          style: TextStyle(color: Colors.red),
        ),
        Container(
          margin: EdgeInsets.only(top: 10.h),
          child: GestureDetector(
            onTap: () {
              print(_name);
              print(_count);
              if (_name != "" && _count != 0) {
                print("ok");
                widget.addMedicine(_widgetPk, _name, _count);
                setState(() {
                  _errorMessage = "";
                });
                _widgetPk = _widgetPk + 1;
              } else {
                setState(() {
                  _errorMessage = "약 정보를 모두 입력해주세요";
                });
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
                      size: 30.sp, // 아이콘 크기
                    ),
                  ),
                ),
                Positioned(
                    child: Container(
                        margin: EdgeInsets.only(right: 30.w, top: 5.h),
                        child: Container(
                          width: 20.w,
                          height: 20.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              // 테두리 설정
                              color: Color(0xFFD5BDAF), // 테두리 색상
                              width: 2, // 테두리 두께
                              style: BorderStyle.solid, // 테두리 스타일
                            ),
                          ),
                        )))
              ]),
            ),
          ),
        )
      ],
    );
  }
}
