import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ViewPetAddInfo extends StatefulWidget {
  final Map<String,dynamic> petAddInfo;
  const ViewPetAddInfo({Key? key, required this.petAddInfo}) : super(key: key);

  @override
  _ViewPetAddInfoState createState() => _ViewPetAddInfoState();
}

class _ViewPetAddInfoState extends State<ViewPetAddInfo>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  String _getEnviorment(int value){
    if(value ==0 ){
      return "실내";
    
    }
    else{
      return "실외";
    }
  }

  String _getExercise(int value){
    if(value ==0 ){
      return "저(일주일에 1시간 이하)";
    }
    else if(value ==1){
      return "중(매일 30분 이하)";
    }
    else{
      return "고(매일 1시간 이상)";
    }
  }

  String _getFoodKind(int value){
    if(value ==0){
      return "사료만";
      
    }
    else if(value ==1){
      return "사료+사람음식";
    }
    else{
      return "사람 음식 위주";
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
        width: 300.w,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 5.h,
            ),
            Center(
              child: Text(
                "추가 정보",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
              ),
            ),
            Container(
              width: 280.w,
              child: Column(
                children: <Widget>[
                  _typeContainer("생활환경", _getEnviorment(widget.petAddInfo['environment'])),
                  _typeContainer("운동강도", _getExercise(widget.petAddInfo['exercise'])),
                  _typeContainer("식사", _getFoodKind(widget.petAddInfo['foodKind'])),
                  _typeContainer("간식", widget.petAddInfo['snackCnt'].toString()),
                  _typeContainer("약", "O"),
                  // ToDo
                  // 약 동적생성해야 함
                ],
              ),
            ), // -> 보호자 정보 end

            Container(
              // margin: EdgeInsets.fromLTRB(0, 10.h, 0, 10.h),
              child: _modifyButton(),
            )
          ],
        ));
  }

  Widget _typeContainer(String name, String state) {
    return Row(
      children: [
        Container(
            width: 80.w,
            height: 30.h,
            margin: EdgeInsets.fromLTRB(0, 10.h, 10.w, 0),
            decoration: BoxDecoration(
              color: Color(0xFFD5BDAF),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Center(
                child: Text(
              name,
            ))),
        Container(
            margin: EdgeInsets.fromLTRB(0, 10.h, 10.w, 0), child: Text(state))
      ],
    );
  }

  Widget _modifyButton() {
    return Container(
      height: 30.h,
      width: 100.w,
      margin: EdgeInsets.fromLTRB(0, 10.h, 10.w, 15.h),
      child: ElevatedButton(
        onPressed: () {},
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFAFA59B)),
        ),
        child: Center(
          child: Text(
            '수정',
            style: TextStyle(fontSize: 15.sp, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
