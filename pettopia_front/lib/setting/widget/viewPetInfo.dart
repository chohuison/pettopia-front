import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pettopia_front/enum/PetBreedList.dart';
import 'package:pettopia_front/setting/page/modifyPet.dart';

class ViewPetInfo extends StatefulWidget {
  final Map<String,dynamic>petinfo;
  final int petPk;
 
  const ViewPetInfo({Key? key, required this.petinfo, required this.petPk}) : super(key: key);
  
  @override
  _ViewPetInfoState createState() => _ViewPetInfoState();
}

class _ViewPetInfoState extends State<ViewPetInfo>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  PetBreedList _list = PetBreedList();
   Map<String,dynamic> _petInfo={};
   

  String _getSex(bool value){
    if(value == true){
      return "남";
    }
    else{
      return "여";
    }
  }
  String _getNeuterYn(bool value){
    if(value == true){
      return "o";
    }
    else{
      return "x";
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

            // 반려동물 정보
            Center(
              child: Text(
                "반려동물 정보",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
              ),
            ),
            Container(
              //decoration: BoxDecoration(color: Colors.yellow),
              width: 300.w,
              height: 100.h,
              child: Row(
                children: <Widget>[
                  // 사진, 이름, 품종, 등록번호
                  Container(
                      //decoration: BoxDecoration(color: Colors.green),
                      height: 100.h,
                      child: Row(
                        children: [
                          // 반려동물 사진
                          Container(
                            margin: EdgeInsets.fromLTRB(10.w, 0, 10.w, 0),
                            width: 80.w,
                            height: 80.h,
                            child:widget.petinfo['profile'] != ""? Image.network(widget.petinfo['profile']) : Container(),

                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                //color: Colors.brown,
                                border: Border.all(
                                    width: 2.w, color: Color(0xFFE3D5CA))),
                          ),
                          // 이름, 품종, 등록번호
                          Container(
                            width: 170.w,
                            //color: Colors.green,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  widget.petinfo['dogNm'],
                                  style: TextStyle(fontSize: 15.sp),
                                ),
                                Text(
                                  _list.getSpicesNmae( widget.petinfo['speciesName']),
                                  style: TextStyle(fontSize: 15.sp),
                                ),
                                Text(  widget.petinfo['dogRegNo'].toString(),),
                              ],
                            ),
                          )
                        ],
                      )),
                ],
              ),
            ),
            //성별, 중성화
            Container(
              width: 280.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _typeContainer("성별", _getSex(widget.petinfo['sexNm'])),
                  _typeContainer("중성화", _getNeuterYn(widget.petinfo['neuterYn']))
                ],
              ),
            ),
            // 반려동물 생년월일
            Container(
              width: 280.w,
              child:    _typeContainer("생년월일", widget.petinfo['birth'].toString()),
           
              margin: EdgeInsets.only(bottom: 10.h),
            ), // -> 반려동물 정보 end
  Container(
              width: 280.w,
              child:          _typeContainer("몸무게", widget.petinfo['weight'].toString()),
           
              margin: EdgeInsets.only(bottom: 10.h),
            ), // -> 반려동물 정보 end

            // 보호자 정보
            Center(
              child: Text(
                "보호자 정보",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
              ),
            ),
            Container(
              width: 280.w,
              child: Column(
                children: <Widget>[
                  _typeContainer("이름", widget.petinfo['protectorName']),
                  _typeContainer("연락처",widget.petinfo['protectorPhoneNum']),
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
        onPressed: () {
          
                Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ModifyPet(petInfo: widget.petinfo, petPk: widget.petPk,)),
      );
          
        },
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
