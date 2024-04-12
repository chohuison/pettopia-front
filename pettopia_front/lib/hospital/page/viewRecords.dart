import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pettopia_front/hospital/widget/calendar.dart';
import 'package:pettopia_front/hospital/widget/shortWriteValue.dart';

class ViewRecords extends StatefulWidget {
 
  const ViewRecords({Key? key,}) : super(key: key);

  @override
  _ViewRecordsState createState() => _ViewRecordsState();
}

class _ViewRecordsState extends State<ViewRecords> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;


  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Text("기록 보기 페이지입니다");
  }
}
