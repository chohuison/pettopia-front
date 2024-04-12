import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShortChartValue extends StatefulWidget {
  final Map<String, dynamic> value;

  const ShortChartValue({
    Key? key,
    required this.value,
  }) : super(key: key);

  @override
  ShortChartValueState createState() => ShortChartValueState();
}

class ShortChartValueState extends State<ShortChartValue> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411.4, 683.4),
      child: Container(
        margin: EdgeInsets.only(top: 0.0.h, left: 10.0.w, right: 10.w, bottom: 10.h),
        width: 350.w,
        height: 90.h,
        decoration: BoxDecoration(
          color: Color(0xFFF5EBE0),
          borderRadius: BorderRadius.circular(10.0), 
        ),
        child: Row(
          children:<Widget> [
            //기록부분
            Container(
              width: 220.w,
              margin: EdgeInsets.only(top: 20.0.h, left: 20.0.w,),
              child:Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(widget.value['dogname'],
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold
                      )),
                      SizedBox(
                        width: 5.0.w,
                      ),
                      Text(widget.value['age'],
                         style: TextStyle(
                        fontSize: 13.sp,
                      
                      ))
                    ],
                  ),
                  Row(
                     children: <Widget>[
                      Text(widget.value['name'],
                       style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold
                      )),
                       SizedBox(
                        width: 5.0.w,
                      ),
                      Text(widget.value['count'],
                        style: TextStyle(
                        fontSize: 13.sp,
                      
                      ))
                    ],
                  )
                ],
              )
            ),
            //버튼부분
         Container(
  width: 100.w,
  child: Column(
    children: <Widget>[
      SizedBox(height: 10.h,),
      SizedBox(
        width: 90.w,
        height: 30.h,
        child: ElevatedButton(
          onPressed: () {},
          style: ButtonStyle(
            side: MaterialStateProperty.all<BorderSide>(
              BorderSide(color: Color(0xFF665D55)),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFAFA59B)),
          ),
          child: Text(
            "수정",
            style: TextStyle(
              fontSize: 10,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
         SizedBox(height: 10.h,),
      SizedBox(
        width: 90.w,
        height: 30.h,
        child: ElevatedButton(
          onPressed: () {},
          style: ButtonStyle(
            side: MaterialStateProperty.all<BorderSide>(
              BorderSide(color: Color(0xFF665D55)),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFAFA59B)),
          ),
          child: Text(
            "삭제",
            style: TextStyle(
              fontSize: 10,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ],
  ),
)

          ],
        )
      ),
    );
  }
}
