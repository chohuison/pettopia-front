import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TipBar extends StatefulWidget {
  final int indexNum;
  final void Function(int index) index;
  final int breedPk;
  const TipBar({Key? key, required this.indexNum, required this.index,required this.breedPk})
      : super(key: key);

  @override
  _BreedBarState createState() => _BreedBarState();
}

class _BreedBarState extends State<TipBar>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  late int _breedNum = widget.breedPk;
  late int _indexNum = widget.indexNum;

  @override
  void initState() {
    _indexNum = widget.indexNum;
    print(_indexNum);
    print(widget.breedPk);
    super.initState();
  }

  @override//
  Widget build(BuildContext context) {
    super.build(context);

    return Container(
      margin: EdgeInsets.only(left: 10.w),
      child: Row(children: <Widget>[
        ElevatedButton(
            onPressed: () {
              widget.index(1);
              setState(() {
                _indexNum = 1;
              });
            },
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all<Size>(
                Size(90.w, 20.h),
              ),
              side: MaterialStateProperty.all<BorderSide>(
                BorderSide(color: Color(0xFF665D55)),
              ),
              backgroundColor:  widget.indexNum == 1
                  ? MaterialStateProperty.all<Color>(Color(0xFFD6CCC2))
                  : MaterialStateProperty.all<Color>(Color(0xFFEDEDE9)),
            ),
            child: Text("주의음식",
                style: TextStyle(
                    fontSize: 10,
                    color: Colors.black,
                    fontWeight: FontWeight.bold))),
        SizedBox(width: 5.w),
        ElevatedButton(
            onPressed: () {
              widget.index(2);
              setState(() {
                _indexNum = 2;
              });
            },
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all<Size>(
                Size(90.w, 20.h), // 가로 150, 세로 50 크기로 조정
              ),
              side: MaterialStateProperty.all<BorderSide>(
                BorderSide(color: Color(0xFF665D55)),
              ),
              backgroundColor:  widget.indexNum == 2
                  ? MaterialStateProperty.all<Color>(Color(0xFFD6CCC2))
                  : MaterialStateProperty.all<Color>(Color(0xFFEDEDE9)),
            ),
            child: Text("이상행동",
                style: TextStyle(
                    fontSize: 10,
                    color: Colors.black,
                    fontWeight: FontWeight.bold))),
        SizedBox(width: 5.w),
        ElevatedButton(
            onPressed: () {
              widget.index(3);
              setState(() {
                _indexNum = 3;
              });
            },
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all<Size>(
                Size(90.w, 20.h), // 가로 150, 세로 50 크기로 조정
              ),
              side: MaterialStateProperty.all<BorderSide>(
                BorderSide(color: Color(0xFF665D55)),
              ),
              backgroundColor:  widget.indexNum == 3
                  ? MaterialStateProperty.all<Color>(Color(0xFFD6CCC2))
                  : MaterialStateProperty.all<Color>(Color(0xFFEDEDE9)),
            ),
            child: Text("예방접종",
                style: TextStyle(
                    fontSize: 10,
                    color: Colors.black,
                    fontWeight: FontWeight.bold))),
        SizedBox(width: 5.w),
        widget.breedPk == 1 ? 
        ElevatedButton(
            onPressed: () {
              widget.index(4);
              setState(() {
                _indexNum = 4;
              });
            },
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all<Size>(
                Size(70.w, 20.h), // 가로 150, 세로 50 크기로 조정
              ),
              side: MaterialStateProperty.all<BorderSide>(
                BorderSide(color: Color(0xFF665D55)),
              ),
              backgroundColor:  widget.indexNum == 4
                  ? MaterialStateProperty.all<Color>(Color(0xFFD6CCC2))
                  : MaterialStateProperty.all<Color>(Color(0xFFEDEDE9)),
            ),
            child: Text("훈련",
                style: TextStyle(
                    fontSize: 10,
                    color: Colors.black,
                    fontWeight: FontWeight.bold))):Container()
      ]),
    );
  }
}
