import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pettopia_front/enum/region.dart';

class RegionSelectBox extends StatefulWidget {
  final void Function(String selectedRegion)?
      onRegionSelected;
  

  const RegionSelectBox({Key? key, required this.onRegionSelected})
      : super(key: key);

  @override
  _RegionSelectBoxState createState() => _RegionSelectBoxState();
}

class _RegionSelectBoxState extends State<RegionSelectBox>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  late Region _region;
  late List<String> _regionList;
  late String _regionValue;
  bool _isOpen = false;
  String _selectBoxValue="구 선택";

  @override
  void initState() {
    super.initState();
    _region = Region();
    _regionList = _region.getRegionList();
    _regionValue = _regionList.first;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Container(
        width: 150.w,
        height: 100.h,
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 20.h, left: 20.w),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 120.w,
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
                margin: EdgeInsets.only(right: 38.w),
                width: 120.w,
                height: 200.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 1),
                ),
                child: ListView.separated(
                   padding: EdgeInsets.zero,
                  itemCount: _regionList.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (_regionList != null && index < _regionList.length) {
                      final record = _regionList[index]!;
                      return GestureDetector(
                      onTap: () {
                        setState(() {
                          _isOpen = !_isOpen;
                          _selectBoxValue=record;
                        });
                        print(record);
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


