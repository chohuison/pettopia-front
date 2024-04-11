import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HospitalValue extends StatefulWidget {
  final Map<String, dynamic> value;

  const HospitalValue({
    Key? key,
    required this.value,
  }) : super(key: key);

  @override
  _HospitalValueState createState() => _HospitalValueState();
}

class _HospitalValueState extends State<HospitalValue> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(411.4, 683.4),
        child: Container(
  margin: EdgeInsets.only(top: 10.0.h, left: 10.0.w, right: 10.w, bottom: 5.h),
  width: 350.w,
  height: 90.h,
  decoration: BoxDecoration(
    color: Color(0xFFF5EBE0),
    borderRadius: BorderRadius.circular(10.0), 
  ),

  child: Row(
    children: <Widget>[
      Container(
        width:250.w,
         margin: EdgeInsets.only(top: 15.0.h, left: 10.0.w,  ),
       child:Column(
        
          crossAxisAlignment: CrossAxisAlignment.start,
        children:<Widget> [
       Text(
        widget.value['name'],
        textAlign: TextAlign.left,
        style: TextStyle(
          fontSize: 15.0, 
          fontWeight: FontWeight.bold, 
        ),
      ),
    Text(widget.value['address'],
    style: TextStyle(
          fontSize: 14.0,
        ),),
     Text(widget.value['phone'],
      style: TextStyle(
          fontSize: 14.0,
        ),)
        ],
       )
      ),
      Container(
          margin: EdgeInsets.only(top: 10.0.h, left: 15.0.w, bottom: 5.h),
        width:50.w,
        height:50.h,
     decoration: BoxDecoration(
    color: Color(0xFFAFA59B),
    borderRadius: BorderRadius.circular(20.0), 
  ),
        //여기 아이콘 넣기 그려야할듯 ..?
      )
    ],
  ),
)

            );
  }
}
