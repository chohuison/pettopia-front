import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pettopia_front/Menu/AppBar.dart';
import 'package:pettopia_front/Menu/CustomBottomNavigatorBar.dart';
import 'package:pettopia_front/enum/appBarList.dart';
import 'package:pettopia_front/hospital/widget/calendar.dart';
import 'package:pettopia_front/hospital/widget/petSeletBox.dart';
import 'package:pettopia_front/life/page/writeDiary.dart';
import 'package:pettopia_front/server/DB/Pet.dart';
import 'package:pettopia_front/setting/widget/diaryCalendar.dart';

class DiaryWidget extends StatefulWidget {
  final List<Map<String, dynamic>> petList;
  const DiaryWidget({
    Key? key,
    required this.petList,
  }) : super(key: key);

  @override
  _DiaryWidgetState createState() => _DiaryWidgetState();
}

class _DiaryWidgetState extends State<DiaryWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  late DateTime _date = DateTime.now();
  late String _name = "";
  late String _petName = widget.petList.first['dogNm'];
  late int _petPk = widget.petList.first['petPk'];
  Pet _petServer = new Pet();


  @override
  void initState() {
    super.initState();
  }

  void _petNameHandler(String value, int valuePk) {
    setState(() {
      _petName = value;
      _petPk = valuePk;
    });
  }

  void onHandleDate(DateTime date) {
    _date = date;
  }

  Future<void> _writeDiary() async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => WriteDiary()));
  }

  Future<void> _viewDiary() async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => WriteDiary()));
  }

 
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 10.h),
        child: Column(
          children: [
            DiaryCalendar(onHandleDate: onHandleDate),
            Row(
              children: [
                // SelectBox Container
                Container(
                  margin: EdgeInsets.fromLTRB(20.w, 20.h, 0, 0),
                  width: 150.w,
                  height: 100.h,
                  // color: Colors.blue,
                  // SelectBox 실행 시 예외 발생
                  child: PetSelectBox(
                      onRegionSelected: _petNameHandler,
                      petName: widget.petList),
                ),
                Column(
                  children: [
                    _button("다이어리 작성", _writeDiary),
                    _button("다이어리 보기", _viewDiary)
                  ],
                )
              ],
            )
          ],
        ));
  }

  Widget _button(String buttonName, Function controller) {
    return Container(
      margin: EdgeInsets.fromLTRB(20.w, 10.h, 0, 0),
      width: 150.w,
      height: 40.h,
      child: ElevatedButton(
        onPressed: () {
          controller();
        },
        style: ButtonStyle(
          alignment: Alignment.center,
          backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFAFA59B)),
        ),
        child: Text(
          buttonName,
          style: TextStyle(
            fontSize: 13,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
