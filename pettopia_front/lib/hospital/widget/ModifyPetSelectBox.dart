import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pettopia_front/enum/region.dart';

class ModifyPetSelectBox extends StatefulWidget {
  final void Function(String selectValue, int selectValuePk)?
      onRegionSelected;
      final int petPk;
  final List<Map<String,dynamic>> petNameList;
  
  

  const ModifyPetSelectBox({Key? key, required this.onRegionSelected, required this.petNameList, required this.petPk})
      : super(key: key);

  @override
  _ModifyPetSelectBoxState createState() => _ModifyPetSelectBoxState();
}

class _ModifyPetSelectBoxState extends State<ModifyPetSelectBox>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  bool _isOpen = false;
  late String _selectBoxValue;
  late int _selectBoxValuePk;
 

  @override
  void initState() {
    super.initState();
    String petName="";
    for(var pet in widget.petNameList)
    {
      if(pet['petPk']== widget.petPk){
        petName = pet['dogNm'];
      }
    }
    _selectBoxValue=petName;
   _selectBoxValuePk=widget.petPk;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Container(
        width: 150.w,
        height: 70.h,
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top:5.h, left: 20.w),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 100.w,
                    height: 30.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black, width: 1),
                    ),
                    child:Center(
                      child:Text(_selectBoxValue)
                    )
                  ),
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          _isOpen = !_isOpen;
                        });
                    
                      },
                      child: Container(
                        width: 30.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black, width: 1),
                        ),
                        child: Icon(
                          _isOpen
                              ? Icons.arrow_drop_up
                              : Icons.arrow_drop_down, // 상태에 따라 아이콘 변경
                        ),
                      )),
                ],
              ),
            ),
            if (_isOpen)
              Container(
                     margin: EdgeInsets.only(right:10.w),
                width: 100.w,
                height: 30.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 1),
                ),
                child: ListView.separated(
                   padding: EdgeInsets.zero,
                  itemCount: widget.petNameList.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (widget.petNameList != null && index < widget.petNameList.length) {
                      final record = widget.petNameList[index]['dogNm']!;
                      return GestureDetector(
                      onTap: () {
                        setState(() {
                          _isOpen = !_isOpen;
                          _selectBoxValue=record;
                          _selectBoxValuePk=widget.petNameList[index]['petPk'];
                        });
                        widget.onRegionSelected!(_selectBoxValue,_selectBoxValuePk);
                     
                      },
                      child:Center( child: Text(record)) );
                    } 
                  }, separatorBuilder: (BuildContext context, int index) => const Divider(),
                ),
              )
          ],
        ));
  }
}

