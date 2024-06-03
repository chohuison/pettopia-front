import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BreedValue extends StatefulWidget {
  final Map<String, dynamic> value;

  const BreedValue({
    Key? key,
    required this.value,
  }) : super(key: key);

  @override
  _BreedValueState createState() => _BreedValueState();
}

class _BreedValueState extends State<BreedValue> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(392.7272727273, 783.2727272727),
      child: Container(
        margin: EdgeInsets.only(
            top: 0.0.h, left: 1.w, right: 20.w, bottom: 10.h),
        width: 260.w,
        height: 120.h,
        decoration: BoxDecoration(
          color: Color(0xFFF5EBE0),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 200.w,
                  child:  Text(
                  widget.value['content'],
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13.0),
                ),
                )
              
              ],
            )
          ],
        ),
      ),
    );
  }
}
