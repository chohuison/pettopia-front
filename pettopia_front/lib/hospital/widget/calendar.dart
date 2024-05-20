import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:pettopia_front/hospital/widget/shortWriteValue.dart';
import 'package:pettopia_front/server/DB/Pet.dart';

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
  List<Map<String, dynamic>> _petList = [];
  Pet _petServer = Pet();

  Future<void> _getList() async {
    _petList = await _petServer.getPetList();
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
                    selectedDay: _selectedDate!, petList: _petList),
              ),
            );
          }
          else if(_index == 1) {
            
          }
        },
      ),
    );
  }
}
