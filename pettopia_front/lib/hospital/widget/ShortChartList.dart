import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pettopia_front/hospital/widget/shortChartValue.dart';

class ShortChartList extends StatefulWidget{
  final List<Map<String, dynamic>>chartList;
  const ShortChartList({
    Key? key,
   required this.chartList,
  }) : super(key: key,);

  @override
  _ShortChartListState createState() => _ShortChartListState();

}

class _ShortChartListState extends State<ShortChartList> {
 
  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
      shrinkWrap: true,
       physics: NeverScrollableScrollPhysics(),
          itemCount: widget.chartList.length,
        itemBuilder: (BuildContext context, int index) {
  if (widget.chartList != null && index < widget.chartList.length) {
    final record =widget. chartList[index]!;
    return ShortChartValue(
      value: record,
    );
  } else {
    // hospitalList가 null이거나 index가 범위를 벗어나는 경우에 대한 처리
    return SizedBox(); // 혹은 다른 처리를 수행할 수 있음
  }
},
        );
  }
}
