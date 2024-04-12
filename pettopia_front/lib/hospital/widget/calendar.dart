import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:pettopia_front/hospital/widget/shortWriteValue.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Container(
      color: Colors.white,
      margin: EdgeInsets.all(10.0),
      child: TableCalendar(
        focusedDay: DateTime.now(),
        firstDay: DateTime(2020),
        lastDay: DateTime(2030),
        onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
          setState(() {
            _selectedDate = selectedDay;
          });
          // 선택한 날짜에 대한 팝업 창 표시
        showDialog(
  context: context,
  barrierDismissible: false,
  builder: (BuildContext context) {
    return Center(
      child: Container(
        width: 380.0.w,
        height: 400.0.h, 
       
         decoration: BoxDecoration(
    color: Color.fromRGBO(237, 237, 233, 1.0),
    borderRadius: BorderRadius.circular(20),
  ),
        child: Dialog(
          
          child: ShortWriteValue(selectedDay: _selectedDate!),
        ),
      ),
    );
  },
);


        },
      ),
    );
  }
}
