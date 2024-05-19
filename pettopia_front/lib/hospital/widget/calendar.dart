import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:pettopia_front/hospital/widget/shortWriteValue.dart';

class Calendar extends StatefulWidget {
  final int index;
  const Calendar({Key? key, required this.index}) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  late int _index;

  DateTime? _selectedDate;

  @override
  initState() {
    super.initState();
    _index = widget.index;
  }

  //d여기서 이름 받아오는 코드 짜면 됨
  List<Map<String, dynamic>> getList() {
    List<Map<String, dynamic>> petList = [
      {"dog_nm": "초코", "pk": 3},
      {"dog_nm": "나비", "pk": 4}
    ];
    return petList;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Container(
      color: Color(0xFFE3D5CA),
      margin: EdgeInsets.fromLTRB(10.w, 0, 10.w, 10.h),
      child: TableCalendar(
        focusedDay: DateTime.now(),
        firstDay: DateTime(2020),
        lastDay: DateTime(2030),
        onDaySelected: (
          DateTime selectedDay,
          DateTime focusedDay,
        ) {
          setState(() {
            _selectedDate = selectedDay;
          });
          if (_index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ShortWriteValue(
                  selectedDay: _selectedDate!,
                  petList: getList(),
                ),
              ),
            );
          } else if (_index == 1) {}
        },
      ),
    );
  }
}
