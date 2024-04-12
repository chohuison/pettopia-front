import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:pettopia_front/hospital/widget/shortWriteValue.dart';

class Calendar extends StatefulWidget {
 
  const Calendar({Key? key,}) : super(key: key);

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;


  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Container(
      color:Colors.white,
         margin: EdgeInsets.all(10.0),
      child:TableCalendar(
    focusedDay: DateTime.now(), 
    firstDay: DateTime(2020), 
    lastDay: DateTime(2030), 
    
  ),
    );
  
  }
}
