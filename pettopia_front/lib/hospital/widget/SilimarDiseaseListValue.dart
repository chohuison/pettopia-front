import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
          margin: EdgeInsets.only(
              top: 0.0.h, left: 10.0.w, right: 10.w, bottom: 10.h),
          width: 350.w,
          height: 80.h,
          decoration: BoxDecoration(
            color: Color(0xFFF5EBE0),
            borderRadius: BorderRadius.circular(40.0),
          ),
          child: Row(
            children: <Widget>[
              // 기록 부분
              Container(
                  width: 220.w,
                  margin: EdgeInsets.only(
                    top: 20.0.h,
                    left: 25.0.w,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(widget.value['breed'],
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold)),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                 actionsAlignment: MainAxisAlignment.spaceBetween, // 액션 위치 설정
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // 타이틀 정렬
                                  children: [
                                    SizedBox(width:30.w),
                                    Center(child:   Text(widget.value['breed']) ,),
                                 
                                    IconButton(
                                      icon: Icon(Icons.close),
                                      onPressed: () {
                                        Navigator.of(context).pop(); // 팝업 닫기
                                      },
                                    ),
                                  ],
                                ),
                                
                            
                                content: Column(
                                  mainAxisSize: MainAxisSize.min, // 팝업 높이 조절
                                  crossAxisAlignment: CrossAxisAlignment.start, // 정렬
                                  children: <Widget>[
                                    Center(
                                      child:   Text("질병 이름: ${widget.value['disease_name']}"),
                                    ),
                                        Center(
                                      child: Text("CRP: ${widget.value['CRP']}"),
                                    ),
                                        Center(
                                      child: 
                                      
                                          Text("IgG: ${widget.value['IgG']}"),
                                    ),
                                        Center(
                                      child:   Text("AFP: ${widget.value['AFP']}"),
                                    ),
                                        Center(
                                      child:   Text("스트레스: ${widget.value['stress']}"),
                                    ),
                                 
                                    
                                  
                                   
                                   
                                  ],
                                ),
                            
                              );
                            },
                          );
                        },
                        child: Text(
                          "해당 질병 자세히 보기",
                          style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF3013E1),
                          ),
                        ),
                      ),
                    ],
                  )),
            ],
          )),
    );
  }
}
