import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:pettopia_front/hospital/widget/shortWriteValue.dart';
import 'package:pettopia_front/server/DB/Pet.dart';

class DiaryCalendar extends StatefulWidget {
  final Function(DateTime) onHandleDate;
  const DiaryCalendar({Key? key, required this.onHandleDate}) : super(key: key);

  @override
  _DiaryCalendarState createState() => _DiaryCalendarState();
}

class _DiaryCalendarState extends State<DiaryCalendar>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  DateTime _selectedDate = DateTime.now();



  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Container(
      color: Color(0xFFE3D5CA),
      margin: EdgeInsets.fromLTRB(10.w, 0, 10.w, 10.h),
      child: TableCalendar(
        focusedDay:_selectedDate,
        firstDay: DateTime(2020),
        lastDay: DateTime(2030),
          selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
        onDaySelected: (
          DateTime selectedDay,
          DateTime focusedDay,
        ) {
          print(selectedDay);
          setState(() {
            _selectedDate = selectedDay;
          });
            widget.onHandleDate(selectedDay);
        },
      ),
    );
  }
  
}
