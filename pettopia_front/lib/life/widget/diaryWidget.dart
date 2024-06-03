import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pettopia_front/Menu/AppBar.dart';
import 'package:pettopia_front/Menu/CustomBottomNavigatorBar.dart';
import 'package:pettopia_front/enum/appBarList.dart';
import 'package:pettopia_front/hospital/widget/calendar.dart';
import 'package:pettopia_front/hospital/widget/petSeletBox.dart';
import 'package:pettopia_front/life/page/viewDiary.dart';
import 'package:pettopia_front/life/page/writeDiary.dart';
import 'package:pettopia_front/life/widget/checkCreateDiaryPopup.dart';
import 'package:pettopia_front/life/widget/createPetDiaryCheckPopup.dart';
import 'package:pettopia_front/life/widget/daySelectPopUp.dart';
import 'package:pettopia_front/server/DB/Diary.dart';
import 'package:pettopia_front/server/DB/Pet.dart';
import 'package:pettopia_front/setting/widget/diaryCalendar.dart';
import 'package:table_calendar/table_calendar.dart';

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
  Diary _diaryServer = Diary();

  DateTime _selectedDate = DateTime.now();

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

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 10.h),
        child: Column(
          children: [
            Container(
              color: Color(0xFFE3D5CA),
              margin: EdgeInsets.fromLTRB(10.w, 20.h, 10.w, 10.h),
              child: TableCalendar(
                focusedDay: _selectedDate,
                firstDay: DateTime(2020),
                lastDay: DateTime(2030),
                selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
                onDaySelected: (
                  DateTime selectedDay,
                  DateTime focusedDay,
                ) async {
                  if (widget.petList.length < 1) {
                     if (!mounted) return;
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        surfaceTintColor: Colors.white,
                        content: CreatePetDiaryCheckPopup(),
                      );
                    },
                  );
                  } else {
                    Map<String,dynamic > valueDiary = await _diaryServer.getDiary(context,_petPk,selectedDay);
                    bool isCreate = valueDiary['diaryPk'] == null ? true: false;
        if (!mounted) return;
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        surfaceTintColor: Colors.white,
                        content: DaySelectPopUp(
                          date: selectedDay,
                          petList: widget.petList,
                          isCreate: isCreate,
                          diaryValue: valueDiary,
                        ),
                      );
                    },
                  );
                    print(selectedDay);
                    setState(() {
                      _selectedDate = selectedDay;
                    });
                  }

                  _onHandleDate(selectedDay);
                },
              ),
            )
          ],
        ));
  }
}
