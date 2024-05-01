import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pettopia_front/enum/LiveType.dart';

class LifeStyleHabits extends StatefulWidget {
  final Function( LiveType,LiveType) onHandleLifeStyleHabits;
  const LifeStyleHabits({
    Key? key,
              required this.onHandleLifeStyleHabits,
  }) : super(
          key: key,

        );

  @override
  _LifeStyleHabitsState createState() => _LifeStyleHabitsState();
}


class _LifeStyleHabitsState extends State<LifeStyleHabits> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  late LiveType? _enviorment = LiveType.TRUE; // true는 실내, false는 야외
  late LiveType? _exercise = LiveType.TRUE;

  void _enviormentHandler(LiveType value){
    _enviorment = value;
    widget.onHandleLifeStyleHabits(_enviorment!, _exercise!);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // AutomaticKeepAliveClientMixin 사용 시 추가
    return Column(
      children: <Widget>[
        SizedBox(
          height: 5.h,
        ),
        Center(
          child: Text(
            "반려동물 정보",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.sp),
          ),
        ),
        Container(
          width: 300.w,
          height: 80.h,
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 5.h, bottom: 5.h, left: 3.w),
                child: Column(
                  children: <Widget>[
                    _enviormentRadio("생활환경*", "실내", "야외",_enviorment!,_enviormentHandler,5), 
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }


Widget _typeContainer(String name) {
  return Container(
      width: 80.w,
      height: 30.h,
       margin: EdgeInsets.only(right: 10.w),
      decoration: BoxDecoration(
        color: Color(0xFFD5BDAF),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Center(
          child: Text(
        name,
      )));
}



Widget _enviormentRadio(String containerName, String option1, String option2, LiveType selectedValue, Function(LiveType)contorller, int sizedBoxWidth) {
  return Container(
    margin: EdgeInsets.only(bottom: 5.h),
    width: 300.w,
    height: 30.h,
    child: Row(
      children: <Widget>[
        _typeContainer(containerName),
        Container(
          width: 170.w,
          child: Row(
            children: <Widget>[
              Radio<LiveType>(
                value: LiveType.TRUE,
                groupValue: selectedValue,
                onChanged: (LiveType? value) {
                 selectedValue = value!;
                 contorller(selectedValue);
                },
              ),
              Text(option1, style: TextStyle(fontSize: 13.sp)),
              SizedBox(width: sizedBoxWidth.w), // 텍스트 간격 조정
              Radio<LiveType>(
                value: LiveType.FALSE,
                groupValue: selectedValue,
                onChanged: (LiveType? value) {
                       selectedValue = value!;
                           contorller(selectedValue);
                },
              ),
              Text(option2, style: TextStyle(fontSize: 13.sp)),
            ],
          ),
        ),
      ],
    ),
  );
}
}

