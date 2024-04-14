import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pettopia_front/enum/LiveType.dart';

class CreatePetInformation extends StatefulWidget {
  final Function(String, String, String, LiveType, LiveType,LiveType,String) onHandlePetInformation;
  const CreatePetInformation({
    Key? key,
              required this.onHandlePetInformation,
  }) : super(
          key: key,

        );

  @override
  _CreatePetInformationState createState() => _CreatePetInformationState();
}

class _CreatePetInformationState extends State<CreatePetInformation>  with AutomaticKeepAliveClientMixin {
    @override
  bool get wantKeepAlive => true;
  late List<String> _breedList=[];
  late String _breed="";
  String _petNumber="";
  String _petName="";
  String _birth="";
  late LiveType? _fur=LiveType.TRUE;
  late LiveType? _sex = LiveType.TRUE;
  late LiveType? _neutering = LiveType.TRUE;

 @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _initializeVariables();
    });
  }
  void _initializeVariables() {
    _breedList = ["말티즈", "시바"];
    _breed = _breedList.first;
    setState(() {}); // 상태 변경을 통해 위젯을 다시 빌드하여 오류를 해결합니다.
  }

    void _onFurUpdate(LiveType? value) {
    setState(() {
      _fur = value;
    });
    widget.onHandlePetInformation(_petNumber, _petName,_breed, _fur!, _sex!,_neutering!,_birth);
  }

 void _onSexUpdate(LiveType? value) {
    setState(() {
      _sex = value;
    });
      widget.onHandlePetInformation(_petNumber, _petName,_breed, _fur!, _sex!,_neutering!,_birth);
  }

   void _onnNuteringUpdate(LiveType? value) {
    setState(() {
      _neutering = value;
    });
      widget.onHandlePetInformation(_petNumber, _petName,_breed, _fur!, _sex!,_neutering!,_birth);
  }

  void onSeleted(String value){
    _breed=value;
      widget.onHandlePetInformation(_petNumber, _petName,_breed, _fur!, _sex!,_neutering!,_birth);
  }

  void _petNumberController(String value){
    _petNumber=value;
      widget.onHandlePetInformation(_petNumber, _petName,_breed, _fur!, _sex!,_neutering!,_birth);
  }

  void _petNameController(String value){
    _petName = value;
      widget.onHandlePetInformation(_petNumber, _petName,_breed, _fur!, _sex!,_neutering!,_birth);
  }

  void _birthController(String value){
    _birth=value;
      widget.onHandlePetInformation(_petNumber, _petName,_breed, _fur!, _sex!,_neutering!,_birth);
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      SizedBox(
        height: 5.h,
      ),
      Center(
          child: Text("반려동물 정보",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.sp))),
      //사진등록부분
      Container(
          width: 300.w,
          height: 80.h,
          child: Row(
            children: <Widget>[
              //여기 나중에 강아지 프로필
              Container(
                margin: EdgeInsets.only(left: 17.w, top: 16.h),
                width: 60.w,
                height: 60.h,
                color: Colors.blue,
              ),
              Container(
                  margin: EdgeInsets.only(left: 50.w, top: 20.h),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 5.h),
                        width: 150.w,
                        height: 25.h,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xFFAFA59B)),
                          ),
                          child: Text(
                            "촬영하기",
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 150.w,
                        height: 25.h,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xFFAFA59B)),
                          ),
                          child: Text(
                            "겔러리에서 가져오기",
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ))
            ],
          )),
      //아래 세부 입력 사항
      Container(
          margin: EdgeInsets.only(top: 5.h, bottom: 5.h, left: 16.w),
          child: Column(
            children: <Widget>[
           _textFieldContainer("번호*","반려동물 등록 번호를 입력해주세요",0,10,_petNumberController),
           _textFieldContainer("이름*","이름을 입력해주세요",30,10, _petNameController),
             _selectBox(_breedList,_breed,onSeleted),
             _radio("단장모*", "단모", "장모", _fur!,_onFurUpdate,10),
            _radio("성별*", "남", "여", _sex!,_onSexUpdate,22),
            _radio("중성화*", "O", "X", _neutering!,_onnNuteringUpdate,24),
                     _textFieldContainer("생년월일*","YYYY-MM-DD",40,10,_birthController),
            ],
          ))
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
                               
                                hintStyle: TextStyle(fontSize: 11.0.sp, color: Color(0xFFAFA59B),),
                                   border: UnderlineInputBorder(
      borderSide: BorderSide(color: Color(0xFFD5BDAF)),
    ),
                              ))),
                    ],
                  ));

}

Widget _selectBox(List<String> list, String listValue, Function controller){
  return    Container(
                  margin: EdgeInsets.only(bottom: 5.h),
                  width: 300.w,
                  height: 30.h,
                  child: Row(
                    children: <Widget>[_typeContainer("품종*"),
                     Container(
                      width:150.w,
            child: DropdownButtonFormField<String>(
              itemHeight: 50.h,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 1,
                  ),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              value: listValue,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "품종을 선택해주세요";
                }
                return null;
              },
              onChanged: (String? value) {
                if (controller != null) {
                 controller!(value);
                }
              },
              items: list.map<DropdownMenuItem<String>>((String eachValue) {
                return DropdownMenuItem<String>(
                  value: eachValue,
                  child: Container(
                    height: 50.h,
                    child: Text(eachValue, style: TextStyle(fontSize: 10.sp)),
                  ),
                );
              }).toList(),
            ),
          ),],
                  ));
}

Widget _radio(String containerName, String option1, String option2, LiveType selectedValue, Function(LiveType)contorller, int sizedBoxWidth) {
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
