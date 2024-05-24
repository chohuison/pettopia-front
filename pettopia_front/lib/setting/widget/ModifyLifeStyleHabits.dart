import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ModifyLifeStyleHabits extends StatefulWidget {
  final Function(int, int) onHandleLifeStyleHabits;
  final Map<String,dynamic> petAddInfo;

  const ModifyLifeStyleHabits({
    Key? key,
    required this.onHandleLifeStyleHabits,
    required this.petAddInfo,
  }) : super(
          key: key,
        );

  @override
  _ModifyLifeStyleHabitsState createState() => _ModifyLifeStyleHabitsState();
}

class _ModifyLifeStyleHabitsState extends State<ModifyLifeStyleHabits>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  late int _enviorment = widget.petAddInfo['environment']; // true는 실내, false는 야외
  late int _exercise = widget.petAddInfo['exercise'];

  void _enviormentHandler(int value) {
    setState(() {
        _enviorment = value;
    });
  
    widget.onHandleLifeStyleHabits(_enviorment!, _exercise!);
  }

  void _exerciseHandler(int value) {
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
      height:150.h,
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
            height: 125.h,
            // color: Colors.yellow,
            child: Row(
              children: <Widget>[
                Container(
             
                  child: Column(
                    children: <Widget>[
                      _enviormentRadio("생활환경*", "실내", "야외", _enviorment,
                          _enviormentHandler, 5),
                          SizedBox(height:2.h),
                      _exerciseRadio("운동강도*", "저(일주일에 1시간 이하)", "중(매일 30분 이하)",
                          "고(매일 1시간 이상)", _exercise, _exerciseHandler)
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
      int selectedValue,
      Function(int) contorller,
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
                Radio<int>(
                  value: 0,
                  groupValue: selectedValue,
                  onChanged: (int? value) {
                    selectedValue = value!;
                    contorller(selectedValue);
                  },
                ),
                Text(option1, style: TextStyle(fontSize: 13.sp)),
                SizedBox(width: sizedBoxWidth.w), // 텍스트 간격 조정
                Radio<int>(
                  value: 1,
                  groupValue: selectedValue,
                  onChanged: (int? value) {
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
      String option3, int selectedValue, Function(int) contorller) {
    return Container(
      width: 300.w,
      height: 90.h,
      // color:Colors.green,
      child: Row(
        children: <Widget>[
          Container(
            width:90.w,
            height:30.h,
           child:_typeContainer(containerName)
           ),
          Container(
            width:200.w,
            height:80.h,
            // color:Colors.blue,
            child: Column(
              children: <Widget>[
                Container(
                  width:200.w,
                  height:16.h,
                  margin: EdgeInsets.only(bottom: 7.h),
                  // color:Colors.orange,
                  child:Row(
                    children: <Widget>[
                        Radio<int>(
                  value: 0,
                  groupValue: selectedValue,
                  onChanged: (int? value) {
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
                    margin: EdgeInsets.only(right: 30.w,bottom: 7.h),
                  // color:Colors.blue,
                  child:Row(
                    children: <Widget>[
                        Radio<int>(
                  value:1,
                  groupValue: selectedValue,
                  onChanged: (int? value) {
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
                        Radio<int>(
                  value: 2,
                  groupValue: selectedValue,
                  onChanged: (int? value) {
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
