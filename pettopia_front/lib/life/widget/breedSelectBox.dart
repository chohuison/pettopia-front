import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pettopia_front/enum/breed.dart';

class BreedSelectBox extends StatefulWidget {
  final void Function(String selectedRegion)? onRegionSelected;

  const BreedSelectBox({Key? key, required this.onRegionSelected})
      : super(key: key);

  @override
  _BreedSelectBoxState createState() => _BreedSelectBoxState();
}

class _BreedSelectBoxState extends State<BreedSelectBox>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  late Breed _breed;
  late List<String> _breedList;
  late String _breedValue;
  bool _isOpen = false;
  bool _isSelected = false;
  String _selectBoxValue = "종 선택";

  @override
  void initState() {
    super.initState();
    _breed = Breed();
    _breedList = _breed.getBreedList();
    _breedValue = _breedList.first;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Container(
      // color: Colors.red,
      child: Container(
          width: 150.w,
          height: 50.h,
          //color: Colors.blue,
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
                        child: Center(child: Text(_selectBoxValue))),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            _isOpen = !_isOpen;
                          });
                          // print("클릭함");
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
                  height: 65.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black, width: 1),
                  ),
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    itemCount: _breedList.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (_breedList != null && index < _breedList.length) {
                        final record = _breedList[index]!;
                        return GestureDetector(
                            onTap: () {
                              setState(() {
                                _isOpen = !_isOpen;
                                _isSelected = true;
                                _selectBoxValue = record;
                              });
                              widget.onRegionSelected!(record);
                              print(record);
                            },
                            child: Center(child: Text(record)));
                      }
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                  ),
                )
            ],
          )),
    );
  }
}
