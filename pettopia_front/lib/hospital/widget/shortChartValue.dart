import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pettopia_front/hospital/widget/deleteCheckPopup.dart';
import 'package:pettopia_front/hospital/page/shortRecordModify.dart';
import 'package:pettopia_front/server/DB/Pet.dart';

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

  String _intToString(int value){
    return value.toString();
  }

    Pet _petServer = Pet();
  List<Map<String,dynamic>> _petList = [];
  Future<void> _getPetList () async{
    _petList = await _petServer.getPetList(context);
    
  }
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(392.7272727273, 783.2727272727),
      child: Container(
        margin: EdgeInsets.only(top: 0.0.h, left: 10.0.w, right: 10.w, bottom: 10.h),
        width: 350.w,
        height: 100.h,
        decoration: BoxDecoration(
          color: Color(0xFFF5EBE0),
          borderRadius: BorderRadius.circular(10.0), 
        ),
        child: Row(
          children:<Widget> [
            //기록부분
            Container(
              width: 210.w,
              margin: EdgeInsets.only(top: 20.0.h, left: 20.0.w,),
              child:Column(
                children: <Widget>[
                  Container(
                                 margin: EdgeInsets.only(right: 135.0.w,),
                    child: Text(widget.value['createAt'].toString())
                    
                  )
                 ,
                  Row(
                    children: <Widget>[
                      Text(widget.value['petName'],
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold
                      )),
                      SizedBox(
                        width: 5.0.w,
                      ),
                      Text(_intToString(widget.value['age'])+"주차",
                         style: TextStyle(
                        fontSize: 13.sp,
                      
                      ))
                    ],
                  ),
                  Row(
                     children: <Widget>[
                      Text(widget.value['type'],
                       style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold
                      )),
                       SizedBox(
                        width: 5.0.w,
                      ),
                      Text(_intToString(widget.value['num'])+"차시",
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
      SizedBox(height: 20.h,),
      SizedBox(
        width: 90.w,
        height: 30.h,
        child: ElevatedButton(
          onPressed: () async{
            await _getPetList();
            Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ShortRecordModify(chartValue: widget.value,petList: _petList,)),
      );
          },
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
          onPressed: () {
             showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content:DeleteCheckPopup(pk:widget.value['pk']),
                  surfaceTintColor: Colors.white,
                );
              },
            );
          },
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
