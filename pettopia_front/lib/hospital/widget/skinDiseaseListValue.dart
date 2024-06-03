import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SkinDiseaseListValue extends StatefulWidget {
  const SkinDiseaseListValue({
    Key? key,
  }) : super(key: key);

  @override
  _SkinDiseaseListValueState createState() => _SkinDiseaseListValueState();
}

class _SkinDiseaseListValueState extends State<SkinDiseaseListValue> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(392.7272727273, 783.2727272727),
      child: Container(
        margin: EdgeInsets.only(
            top: 10.0.h, left: 10.0.w, right: 10.w, bottom: 10.h),
        width: 350.w,
        height: 80.h,
        decoration: BoxDecoration(
          color: Color(0xFFF5EBE0),
          borderRadius: BorderRadius.circular(40.0),
        ),
      ),
    );
  }
}
