import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pettopia_front/enum/LiveType.dart';

class Eat extends StatefulWidget {
  final Function(String, int, String) onHandleEat;
  const Eat({
    Key? key,
    required this.onHandleEat,
  }) : super(
          key: key,
        );

  @override
  _EatState createState() => _EatState();
}

class _EatState extends State<Eat>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  String _eatCount ="";
  String _snackCount="";
  int _eatKine = 0;
  void _handleEatCount (String eatCount){
    _eatCount=eatCount;
  }
  void _handleEatKind(int liveType){
    setState(() {
      _eatKine=liveType;
    });
  }
  void _handlesnackCount(String value){
    _snackCount=value;
  }

  
  @override
  Widget build(BuildContext context) {
    super.build(context); // AutomaticKeepAliveClientMixin 사용 시 추가
    return Container(
     child: Column(
      children: <Widget>[
           SizedBox(
            height: 5.h,
          ),
          Center(
            child: Text(
              "식사/간식",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
            ),
          ),
        Container(
          margin: EdgeInsets.only(left: 25.h,bottom: 8.h),
          child:_textField("식사*", _handleEatCount, "식사 횟수를 입력해주세요"),
        ),
        SizedBox(height:5.h),
      
       _eatKindRadio("식사종류*", "사료만", "사료+사람음식",
                          "사람음식 위주",_eatKine , _handleEatKind),
                           Container(
          margin: EdgeInsets.only(left: 25.h),
          child: _textField("간식*", _handlesnackCount, "간식 횟수를 입력해주세요"),               
        ),
           
      ],
     ),
        
      
    );
  }

  Widget _typeContainer(String name, int height ) {
    return Container(
        width: 80.w,
        height: 30.h,
        margin: EdgeInsets.only(right: 10.w,top:height.h),
        decoration: BoxDecoration(
          color: Color(0xFFD5BDAF),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Center(
            child: Text(
          name,
        )));
  }

  
    Widget _eatKindRadio(String containerName, String option1, String option2,
      String option3, int selectedValue, Function(int) contorller) {
    return Container(
      width: 300.w,
  
      child: Row(
        children: <Widget>[
          Container(
            width:90.w,
            height:30.h,
           child:_typeContainer(containerName,0)
           ),
          Container(
            width:200.w,
         
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
                  value: 1,
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
                  margin: EdgeInsets.only(right: 30.w,bottom: 3.h),
                  
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


  Widget _textField(String containerName,Function controller,String labelText  ){
    return Row(
      children: <Widget>[
        _typeContainer(containerName,13),
        SizedBox(width:10.w),
          Container(
                          width: 170.w,
                          child: TextField(
                              onChanged: (text) {
                                controller(text);
                                
                              },
                              decoration: InputDecoration(
                                hintText: labelText,
                                //  contentPadding: EdgeInsets.symmetric(horizontal: horizontal.w,vertical: vertical.h), 
                               
                                hintStyle: TextStyle(fontSize: 11.0.sp, color: Color(0xFFAFA59B),),
                                   border: UnderlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFD5BDAF)),
    ),
                              ))),

      ],
    );
  }
    }