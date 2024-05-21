import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pettopia_front/enum/LiveType.dart';

class ModifyPetParentValue extends StatefulWidget {
  final Function(String,String) petParentValueHandle;
  final Map<String,dynamic> petInfo;
  const ModifyPetParentValue({
    Key? key,
    required this.petParentValueHandle,
    required this.petInfo,
            
  }) : super(
          key: key,

        );

  @override
  _ModifyPetParentValueState createState() => _ModifyPetParentValueState();
}

class _ModifyPetParentValueState extends State<ModifyPetParentValue>  with AutomaticKeepAliveClientMixin {
    @override
  bool get wantKeepAlive => true;
 late String _parentName=widget.petInfo['protectorName'];
 late String _parentPhoneNum=widget.petInfo['protectorPhoneNum'];
 void parentNameChange(String value){
  _parentName=value;
  widget.petParentValueHandle(_parentName, _parentPhoneNum);
 }
 void parentPhoneNumChange(String value){
  _parentPhoneNum=value;
   widget.petParentValueHandle(_parentName, _parentPhoneNum);
 }



 @override

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
     Center(
      child: Text("보호자 정보",
       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.sp ),)
     ),
     _textFieldContainer("이름*", _parentName,15,10,parentNameChange),
     SizedBox(height: 2.h),
     _textFieldContainer("연락처*",_parentPhoneNum,50,10,parentPhoneNumChange)
    ]);
  }
}

Widget _typeContainer(String name) {
  return Container(
      width: 80.w,
      height: 30.h,
       margin: EdgeInsets.only(right: 15.w),
      decoration: BoxDecoration(
        color: Color(0xFFD5BDAF),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Center(
          child: Text(
        name,
      )));
}


Widget _textFieldContainer(String containerName, String labelText, int horizontal, int vertical,Function contorller){
  return   Container(
                  margin: EdgeInsets.only(bottom: 5.h),
                  width: 300.w,
                  height: 30.h,
                  child: Row(
                    children: <Widget>[
                      _typeContainer(containerName),
                       Container(
                          width: 170.w,
                          child: TextField(
                              onChanged: (text) {
                                contorller(text);
                                
                              },
                              decoration: InputDecoration(
                                hintText: labelText,
                                 contentPadding: EdgeInsets.symmetric(horizontal: horizontal.w,vertical: vertical.h), 
                               
                                hintStyle: TextStyle(fontSize: 11.0.sp, color: Colors.black,),
                                   border: UnderlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFD5BDAF)),
    ),
                              ))),
                    ],
                  ));

}