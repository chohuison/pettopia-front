import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pettopia_front/Menu/CustomBottomNavigatorBar.dart';
import 'package:pettopia_front/server/DB/Pet.dart';
import 'package:pettopia_front/setting/widget/ViewpetAddInfo.dart';
import 'package:pettopia_front/setting/widget/viewPetInfo.dart';
import 'package:pettopia_front/hospital/widget/petSeletBox.dart';

class ViewPetInformation extends StatefulWidget {
  final List<Map<String, dynamic>> petList;
  final Map<String,dynamic>petInfo;
  final Map<String,dynamic>petAddInfo;
  const ViewPetInformation({Key? key, required this.petList,required this.petInfo, required this.petAddInfo}) : super(key: key);

  @override
  _ViewPetInformationState createState() => _ViewPetInformationState();
}

class _ViewPetInformationState extends State<ViewPetInformation> {
  // int _totalContainerHeight = 1000;
  // int _medicenContainerWidget = 190;
  late String _petName = widget.petList.first['dog_nm'];
  late int _petPk = widget.petList.first['pk'];
  Map<String,dynamic> _petInfo ={};
  Map<String,dynamic> _petAddInfo={};
  Pet _petServer = new Pet();
@override
  void initState() {
    super.initState();
    _petInfo = widget.petInfo;
    _petAddInfo=widget.petAddInfo;

  }
  void _petNameHandler(String value, int valuePk) {
    setState(() {
         _petName = value;
    _petPk = valuePk;
    });
 _getPetInfo();
  }

  void _getPetInfo () async {
    Map<String ,dynamic> newPetInfo =  await _petServer.getPetInfo(_petPk);
    setState(() {
      _petInfo = newPetInfo;
    });
  }
  void _getPetAddInfo() async{
        Map<String ,dynamic> newPetAddInfo =  await _petServer.getAddPetInfo(_petPk);
    setState(() {
      _petAddInfo = newPetAddInfo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(411.4, 683.4),
        child: MaterialApp(
          title: "petAddInformation",
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: child!,
            );
          },
          home: Scaffold(
            backgroundColor: Color.fromRGBO(237, 237, 233, 1.0),
            body: ListView(
              children: [
                Container(
                  width: 400.w,
                  // height: _totalContainerHeight.h,
                  margin: EdgeInsets.fromLTRB(15.w, 10.h, 15.w, 10.h),
                  decoration: BoxDecoration(
                    color: Color(0xFFE3D5CA),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20.h,
                      ),
                      Center(
                        child: Text(
                          "반려동물 정보 조회하기",
                          style: TextStyle(
                              fontSize: 20.sp, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        height: 800.h,
                        child: Stack(
                          children: [
                            Positioned(
                                child: Column(
                              children: [
                                Container(
                                    width: 350.w,
                                    child: Container(
                                        child: // 반려동물 정보
                                            Container(
                                      width: 343.w,
                                      // height: 410.h,
                                      margin: EdgeInsets.fromLTRB(
                                          3.w, 50.h, 3.w, 10.h),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFF5EBE0),
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      child: ViewPetInfo(petinfo: _petInfo,),
                                    ))),
                                Container(
                                    width: 350.w,
                                    child: Container(
                                        child: // 추가 정보
                                            Container(
                                      width: 343.w,
                                      // height: 410.h,
                                      margin: EdgeInsets.fromLTRB(
                                          3.w, 10.h, 3.w, 10.h),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFF5EBE0),
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      child: ViewPetAddInfo(petAddInfo:_petAddInfo ),
                                    )))
                              ],
                            )),
                            Positioned(
                                height: 100.h,
                                width: 150.w,
                                //color: Colors.black,
                                child: PetSelectBox(
                                    onRegionSelected: _petNameHandler,
                                    petName: widget.petList)),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            bottomNavigationBar: CustomBottomNavigatorBar(page: 4),
          ),
        ));
  }
}
