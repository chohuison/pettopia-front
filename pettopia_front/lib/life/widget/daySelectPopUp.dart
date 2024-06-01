import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pettopia_front/hospital/widget/petSeletBox.dart';
import 'package:pettopia_front/life/page/viewDiary.dart';
import 'package:pettopia_front/life/page/writeDiary.dart';
import 'package:pettopia_front/life/widget/checkCreateDiaryPopup.dart';
import 'package:pettopia_front/server/DB/Diary.dart';
import 'package:pettopia_front/server/DB/Pet.dart';

class DaySelectPopUp extends StatefulWidget {
  final List<Map<String, dynamic>> petList;

  //true -> 작성버튼만 나오게 false -> 보기 버튼만 나오게
  final bool isCreate;
    final Map<String,dynamic> diaryValue;
  const DaySelectPopUp({
    Key? key,
    required this.petList,
    required this.isCreate,
    required this.diaryValue,
  }) : super(key: key);

  @override
  State<DaySelectPopUp> createState() => _DaySelectPopUpState();
}

class _DaySelectPopUpState extends State<DaySelectPopUp>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  late DateTime _date = DateTime.now();
  late String _name = "";
  late String _petName = widget.petList.first['dogNm'];
  late int _petPk = widget.petList.first['petPk'];
  Pet _petServer = new Pet();
  Diary _diaryServer = Diary();

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

  void _onHandleDate(DateTime date) {
    _date = date;
  }

  Future<void> _writeDiary() async {
    List<Map<String, dynamic>> medicenList =
        await _diaryServer.getMedicenList(_petPk);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => WriteDiary(
                  date: _date,
                  name: _petName,
                  pk: _petPk,
                  medicenList: medicenList,
                )));
  }

  Future<void> _viewDiary() async {

        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ViewDiary(
                    diaryPk: widget.diaryValue['diaryPk'],
                    diaryValue: widget.diaryValue,
                    date: _date,
                    name: _petName,
                    pk: _petPk,
                  )));
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411.42857142857144, 683.4285714285714),
      child: MaterialApp(
        builder: (context, child) {
          return SizedBox(
            height: 300.h,
            width: 200.w,
            child: child,
          );
        },
        home: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close))
            ],
          ),
          body: Container(
            width: 200.w,
            height: 250.h,
            child: Column(
              children: [
                Container(
                  width: 150.w,
                  height: 100.h,
                  // color: Colors.blue,
                  // SelectBox 실행 시 예외 발생
                  child: PetSelectBox(
                      onRegionSelected: _petNameHandler,
                      petName: widget.petList),
                ),
                widget.isCreate == true ? _button("다이어리 작성", _writeDiary) : _button("다이어리 보기", _viewDiary)
                ,
                
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _button(String buttonName, Function controller) {
    return Container(
      margin: EdgeInsets.fromLTRB(20.w, 10.h, 0, 0),
      width: 150.w,
      height: 40.h,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
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
