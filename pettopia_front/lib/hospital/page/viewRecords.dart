import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pettopia_front/hospital/widget/ShortChartList.dart';
import 'package:pettopia_front/hospital/widget/calendar.dart';
import 'package:pettopia_front/hospital/widget/shortWriteValue.dart';
import 'package:pettopia_front/server/DB/ShotRecords.dart';

class ViewRecords extends StatefulWidget {
  const ViewRecords({Key? key, }) : super(key: key);

  @override
  _ViewRecordsState createState() => _ViewRecordsState();
}

class _ViewRecordsState extends State<ViewRecords> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  late List<Map<String , dynamic >>_chartList=[];
  final shotRecordsServer=ShotRecords();
  bool _isOpen=false;

    @override
  void initState() {
    super.initState();
    getChartList();
 

 

  }
  void getChartList()async{
 _chartList= await shotRecordsServer.getChartList();
      if(mounted){
    setState(() {
        _isOpen = true;
      });
      }
  

  }


  @override
  Widget build(BuildContext context) {
    super.build(context);
 return _isOpen
        ? Container(
            height: 400.h,
            child: ShortChartList(chartList: _chartList),
          )
        : SizedBox.shrink(); // `_isOpen`이 `false`인 경우 빈 위젯 반환
  }
}