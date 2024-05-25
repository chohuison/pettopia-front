import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pettopia_front/life/widget/cntBox.dart';
import 'package:pettopia_front/life/widget/medicenSelectBox.dart';

class Medicine extends StatefulWidget {
  final Function(String, int) onHandleMedicine;
  final Function(int, String, int) addMedicine;
  final List<Map<String,dynamic>> medicenList;

  const Medicine({
    Key? key,
    required this.onHandleMedicine,
    required this.addMedicine,
    required this.medicenList,
  }) : super(key: key);

  @override
  __MedicineState createState() => __MedicineState();
}

class __MedicineState extends State<Medicine> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  int _count = 0;
  late String _name = widget.medicenList.first['name'];
  int _widgetPk = 0;
  String _errorMessage = "";
  int _medicineCnt = 0;

  void _handleName(String value) {
    setState(() {
      _name = value;
    });

    widget.onHandleMedicine(_name, _count);
  }

  void _handleMedicenCount(int value) {
    setState(() {
      _count = value;
      _medicineCnt=value;
    });
    print("name:" + _name);
    widget.onHandleMedicine(_name, _count);
  }

  void _resetMedicine() {
    setState(() {
      _count = 0;
      _medicineCnt = 0;
      _errorMessage = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // AutomaticKeepAliveClientMixin 사용 시 추가
    return Column(
      children: [
        Row(
          children: <Widget>[    Container(
              margin: EdgeInsets.only(right: 10.w, top:25.h),
              width: 150.w,
              child: MedicenSelectBox(onChangedMedicen: _handleName,medicenList:widget.medicenList, medicenName: widget.medicenList.first['name'],)
            ),
            CntBox(
              cnt: _medicineCnt,
              handleCount: _handleMedicenCount,
            ),],
        )
     ,
        Text(
          _errorMessage,
          style: TextStyle(color: Colors.red),
        ),
        Container(
          child: GestureDetector(
            onTap: () {
              print(_name);
              if ( _count != 0) {
                widget.addMedicine(_widgetPk, _name, _count);
                _widgetPk++;
                _resetMedicine();
              } else {
                setState(() {
                  _errorMessage = "약 정보를 모두 입력해주세요";
                });
              }
            },
            child: Container(
              child: Stack(
                children: [
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
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
