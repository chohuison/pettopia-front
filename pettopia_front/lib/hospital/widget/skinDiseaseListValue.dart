import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SkinDiseaseListValue extends StatefulWidget {
  final String diseaseName;
  const SkinDiseaseListValue({
    Key? key,
    required this.diseaseName,
  }) : super(key: key);

  @override
  _SkinDiseaseListValueState createState() => _SkinDiseaseListValueState();
}

class _SkinDiseaseListValueState extends State<SkinDiseaseListValue> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411.4, 683.4),
      child: Container(
        margin: EdgeInsets.only(
            top: 10.0.h, left: 10.0.w, right: 10.w, bottom: 10.h),
        width: 350.w,
        height: 80.h,
        decoration: BoxDecoration(
          color: Color(0xFFF5EBE0),
          borderRadius: BorderRadius.circular(40.0),
        ),
        child: Center(
          child: Text(widget.diseaseName,style: TextStyle(fontSize: 30.sp),),)
      ),
    );
  }
}
