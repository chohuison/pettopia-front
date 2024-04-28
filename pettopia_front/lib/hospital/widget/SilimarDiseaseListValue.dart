import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pettopia_front/hospital/page/shortRecordModify.dart';

class SilimarListValue extends StatefulWidget {
  final Map<String, dynamic> value;

  const SilimarListValue({
    Key? key,
    required this.value,
  }) : super(key: key);

  @override
  _SilimarListValueState createState() => _SilimarListValueState();
}

class _SilimarListValueState extends State<SilimarListValue> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411.4, 683.4),
      child: Container(
        margin: EdgeInsets.only(top: 0.0.h, left: 10.0.w, right: 10.w, bottom: 10.h),
        width: 350.w,
        height: 80.h,
        decoration: BoxDecoration(
          color: Color(0xFFF5EBE0),
          borderRadius: BorderRadius.circular(40.0), 
        ),
        child: Row(
          children:<Widget> [
            //기록부분
            Container(
                
              width: 220.w,
              margin: EdgeInsets.only(top: 20.0.h, left: 25.0.w,),
              child:Container(

                child:Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(widget.value['name'],
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold
                      )),
                          Text("해당 질병 자세히 보기",
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                       color:Color(0xFF3013E1)
                      )),
                ],
              )
              )
            ),
    
          ],
        )
      ),
    );
  }
}
