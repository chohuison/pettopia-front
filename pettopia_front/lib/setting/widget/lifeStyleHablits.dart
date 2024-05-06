import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pettopia_front/enum/LiveType.dart';

class LifeStyleHabits extends StatefulWidget {
  final Function(LiveType, LiveType) onHandleLifeStyleHabits;
  const LifeStyleHabits({
    Key? key,
    required this.onHandleLifeStyleHabits,
  }) : super(
          key: key,
        );

  @override
  _LifeStyleHabitsState createState() => _LifeStyleHabitsState();
}

class _LifeStyleHabitsState extends State<LifeStyleHabits>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  late LiveType? _enviorment = LiveType.TRUE; // true는 실내, false는 야외
  late LiveType? _exercise = LiveType.TRUE;

  void _enviormentHandler(LiveType value) {
    setState(() {
        _enviorment = value;
    });
  
    widget.onHandleLifeStyleHabits(_enviorment!, _exercise!);
  }

  void _exerciseHandler(LiveType value) {
    setState(() {
      _exercise = value;
    });
    
    widget.onHandleLifeStyleHabits(_enviorment!, _exercise!);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // AutomaticKeepAliveClientMixin 사용 시 추가
    return Container(
      // color:Colors.red,
      width: 300.w,
      height:140.h,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 5.h,
          ),
          Center(
            child: Text(
              "생활 습관",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
            ),
          ),
          Container(
            width: 300.w,
            height: 110.h,
            // color: Colors.green,
            child: Row(
              children: <Widget>[
                Container(
             
                  child: Column(
                    children: <Widget>[
                      _enviormentRadio("생활환경*", "실내", "야외", _enviorment!,
                          _enviormentHandler, 5),
                      _exerciseRadio("운동강도*", "저(일주일에 1시간 이하)", "중(매일 30분 이하)",
                          "고(매일 1시간 이상)", _exercise!, _exerciseHandler)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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

  Widget _enviormentRadio(
      String containerName,
      String option1,
      String option2,
      LiveType selectedValue,
      Function(LiveType) contorller,
      int sizedBoxWidth) {
    return Container(
      
      width: 300.w,
      height: 30.h,
      // color:Colors.green,
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

  Widget _exerciseRadio(String containerName, String option1, String option2,
      String option3, LiveType selectedValue, Function(LiveType) contorller) {
    return Container(
      width: 300.w,
      height: 80.h,
      child: Row(
        children: <Widget>[
          Container(
            width:90.w,
            height:30.h,
           child:_typeContainer(containerName)
           ),
          Container(
            width:200.w,
            height:70.h,
            // color:Colors.green,
            child: Column(
              children: <Widget>[
                Container(
                  width:200.w,
                  height:16.h,
                  margin: EdgeInsets.only(bottom: 3.h),
                  // color:Colors.orange,
                  child:Row(
                    children: <Widget>[
                        Radio<LiveType>(
                  value: LiveType.TRUE,
                  groupValue: selectedValue,
                  onChanged: (LiveType? value) {
                    selectedValue = value!;
                    contorller(selectedValue);
                  },
                ),
                Text(option1,style: TextStyle(fontSize: 12.sp),)
                    ],
                  )
                ),
                   Container(
                  width:170.w,
                  height:16.h,
                    margin: EdgeInsets.only(right: 30.w,bottom: 3.h),
                  // color:Colors.blue,
                  child:Row(
                    children: <Widget>[
                        Radio<LiveType>(
                  value: LiveType.MIDIUM,
                  groupValue: selectedValue,
                  onChanged: (LiveType? value) {
                    selectedValue = value!;
                    contorller(selectedValue);
                  },
                ),
                Text(option2,style: TextStyle(fontSize: 12.sp),)
                    ],
                  )
                ),
                   Container(
                  width:170.w,
                  height:16.h,
                  margin: EdgeInsets.only(right: 30.w),
                  // color:Colors.purple,
                  child:Row(
                    children: <Widget>[
                        Radio<LiveType>(
                  value: LiveType.FALSE,
                  groupValue: selectedValue,
                  onChanged: (LiveType? value) {
                    selectedValue = value!;
                    contorller(selectedValue);
                  },
                ),
                Text(option3,style: TextStyle(fontSize: 12.sp),)
                    ],
                  )
                ),
            
              ],
            ),
          ),
        ],
      ),
    );
  }
}
