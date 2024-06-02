import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainSelectBox extends StatefulWidget {
  final void Function(String selectValue, int selectValuePk)? onRegionSelected;
  final List<dynamic> petName;

  const MainSelectBox(
      {Key? key, required this.onRegionSelected, required this.petName})
      : super(key: key);

  @override
  _MainSelectBoxState createState() => _MainSelectBoxState();
}

class _MainSelectBoxState extends State<MainSelectBox>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  bool _isOpen = false;
  late String _selectBoxValue = "";
  late int _selectBoxValuePk = 0;

  @override
  void initState() {
    super.initState();
    print(widget.petName);
    _selectBoxValue = widget.petName.first['dogNm'];
    _selectBoxValuePk = widget.petName.first['pk'];
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Container(
        width: 150.w,
        height: 70.h,
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 5.h, left: 20.w),
              child: Row(
                children: <Widget>[
                  Container(
                      width: 100.w,
                      height: 30.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black, width: 1),
                      ),
                      child: Center(
                          child: Text(
                        _selectBoxValue,
                        style: TextStyle(
                          color: Colors.black, // 글자 색상 설정
                          fontSize: 14.sp, // 글자 크기 설정
                        ),
                      ))),
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          _isOpen = !_isOpen;
                        });
                      },
                      child: Container(
                        width: 30.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black, width: 1),
                        ),
                        child: Icon(
                          _isOpen
                              ? Icons.arrow_drop_up
                              : Icons.arrow_drop_down, // 상태에 따라 아이콘 변경
                        ),
                      )),
                ],
              ),
            ),
            if (_isOpen)
              Container(
                margin: EdgeInsets.only(right: 10.w),
                width: 100.w,
                height: 30.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 1),
                ),
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  itemCount: widget.petName.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (widget.petName != null &&
                        index < widget.petName.length) {
                      final record = widget.petName[index]['dogNm']!;
                      return GestureDetector(
                          onTap: () {
                            setState(() {
                              _isOpen = !_isOpen;
                              _selectBoxValue = record;
                              _selectBoxValuePk = widget.petName[index]['pk'];
                            });
                            widget.onRegionSelected!(
                                _selectBoxValue, _selectBoxValuePk);
                          },
                          child: Center(
                              child: Text(
                            record,
                            style: TextStyle(
                              color: Colors.black, // 글자 색상 설정
                              fontSize: 14.sp, // 글자 크기 설정
                            ),
                          )));
                    }
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                ),
              )
          ],
        ));
  }
}
