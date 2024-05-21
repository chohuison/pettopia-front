import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pettopia_front/enum/PetBreedList.dart';
import 'package:pettopia_front/enum/region.dart';

class SpeciesSelectBox extends StatefulWidget {
  final void Function(String selectValue, int selectValuePk)?
      onSpeciesSelected;
  final List<Map<String,dynamic>> petName;
  final int petPk;
  final String petNameValue;
  

  const SpeciesSelectBox({Key? key, required this.onSpeciesSelected, required this.petName, required this.petPk, required this.petNameValue})
      : super(key: key);

  @override
  _SpeciesSelectBoxState createState() => _SpeciesSelectBoxState();
}

class _SpeciesSelectBoxState extends State<SpeciesSelectBox>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  bool _isOpen = false;
  late String _selectBoxValue;
  late int _selectBoxValuePk;
  PetBreedList _breedList = PetBreedList();
 

  @override
  void initState() {
    super.initState();
   _selectBoxValue=_breedList.findSpeciesBySpeciesName(widget.petNameValue);
   _selectBoxValuePk=widget.petPk;
   
   print(_selectBoxValue);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Container(
        width: 180.w,
        height: 150.h,
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top:5.h, left: 20.w),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 125.w,
                    height: 25.h,
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
                        height: 25.h,
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
                     margin: EdgeInsets.only(right:15.w),
                width: 125.w,
                height: 60.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 1),
                ),
                child: ListView.separated(
                   padding: EdgeInsets.zero,
                  itemCount: widget.petName.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (widget.petName != null && index < widget.petName.length) {
                      final record = widget.petName[index]['species']!;
                      return GestureDetector(
                      onTap: () {
                        setState(() {
                          _isOpen = !_isOpen;
                          _selectBoxValue=record;
                          _selectBoxValuePk=widget.petName[index]['pk'];
                        });
                        print("pk:");
                        print(_selectBoxValuePk);
                        widget.onSpeciesSelected!(_selectBoxValue,_selectBoxValuePk);
                     
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

