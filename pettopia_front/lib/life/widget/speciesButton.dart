import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpeciesButton extends StatefulWidget {
  final int indexNum;
  final void Function(int index) index;
  const SpeciesButton({Key? key, required this.indexNum,required this.index}) : super(key: key);

  @override
  _SpeciesButtonState createState() => _SpeciesButtonState();
}

class _SpeciesButtonState extends State<SpeciesButton> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  int _indexNum = 0;

  @override
  void initState() {
    _indexNum = widget.indexNum;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Row(
      children:<Widget>[
        ElevatedButton(onPressed: (){
            widget.index(1);
            setState(() {
              _indexNum=1;
            });
        },  style: ButtonStyle(
           fixedSize: MaterialStateProperty.all<Size>(
      Size(90.w, 20.h), 
    ),
    
          side: MaterialStateProperty.all<BorderSide>(
      BorderSide(color: Color(0xFF665D55)),
    ),
     backgroundColor:_indexNum == 1
        ? MaterialStateProperty.all<Color>(Color(0xFFD6CCC2))
        : MaterialStateProperty.all<Color>(Color(0xFFEDEDE9)),
  ),  
          child:Text("강아지",
          style: TextStyle(fontSize: 10,
          color: Colors.black,
          fontWeight: FontWeight.bold) )
      ),
      SizedBox(
        width:5.w
      ),
         ElevatedButton(onPressed: (){
 widget.index(2);
 setState(() {
   _indexNum=2;
 });
        }, 
        style: ButtonStyle(
           fixedSize: MaterialStateProperty.all<Size>(
      Size(90.w, 20.h), // 가로 150, 세로 50 크기로 조정
    ),
          side: MaterialStateProperty.all<BorderSide>(
      BorderSide(color: Color(0xFF665D55)),
    ),
   backgroundColor:_indexNum == 2
        ? MaterialStateProperty.all<Color>(Color(0xFFD6CCC2))
        : MaterialStateProperty.all<Color>(Color(0xFFEDEDE9)),
  ),  
         child: Text("고양이",
          style: TextStyle(fontSize: 10,
          color: Colors.black,
          fontWeight: FontWeight.bold))
        )
      ]
    );
  }
}
