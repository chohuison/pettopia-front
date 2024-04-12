import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pettopia_front/hospital/widget/calendar.dart';
import 'package:pettopia_front/hospital/widget/shortWriteValue.dart';

class ShortWrite extends StatefulWidget {
 
  const ShortWrite({Key? key,}) : super(key: key);

  @override
  _ShortWriteBarState createState() => _ShortWriteBarState();
}

class _ShortWriteBarState extends State<ShortWrite> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;


  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Calendar();
  }
}
