import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pettopia_front/enum/region.dart';

class PetSelectBox extends StatefulWidget {
  final void Function(String selectedRegion)?
      onRegionSelected;
  final List<String> petName;
  
  

  const PetSelectBox({Key? key, required this.onRegionSelected, required this.petName})
      : super(key: key);

  @override
  _PetSelectBoxState createState() => _PetSelectBoxState();
}

class _PetSelectBoxState extends State<PetSelectBox>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  bool _isOpen = false;
  late String _selectBoxValue;
 

  @override
  void initState() {
    super.initState();
   _selectBoxValue=widget.petName.first;
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
                        print("클릭함");
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
                  itemCount: widget.petName.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (widget.petName != null && index < widget.petName.length) {
                      final record = widget.petName[index]!;
                      return GestureDetector(
                      onTap: () {
                        setState(() {
                          _isOpen = !_isOpen;
                          _selectBoxValue=record;
                        });
                        widget.onRegionSelected!(record);
                     
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

