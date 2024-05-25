import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CntBox extends StatefulWidget {
  final int cnt;
  final Function(int) handleCount;

  const CntBox({Key? key, required this.cnt, required this.handleCount})
      : super(key: key);

  @override
  CntBoxState createState() => CntBoxState();
}

class CntBoxState extends State<CntBox> {
  late int cnt;

  @override
  void initState() {
    super.initState();
    cnt = widget.cnt;
  }

  @override
  void didUpdateWidget(CntBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    print(oldWidget.cnt);
    print(cnt);
    if (oldWidget.cnt != widget.cnt) {
      setState(() {
        cnt = widget.cnt;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 102.w,
      height: 35.h,
      decoration: BoxDecoration(border: Border.all(color: Color(0xFFD5BDAF))),
      child: Row(
        children: [
          InkWell(
            child: Container(
              width: 33.w,
              height: 35.h,
              decoration:
                  BoxDecoration(color: Color.fromARGB(255, 230, 207, 193)),
              child: Center(
                child: Text("-"),
              ),
            ),
            onTap: () {
              if (cnt > 0) {
                setState(() {
                  cnt--;
                  widget.handleCount(cnt);
                });
              }
            },
          ),
          Container(
            width: 34.w,
            height: 35.h,
            child: Center(
              child: Text(cnt.toString()),
            ),
          ),
          InkWell(
            child: Container(
              width: 33.w,
              height: 35.h,
              decoration:
                  BoxDecoration(color: Color.fromARGB(255, 230, 207, 193)),
              child: Center(
                child: Text("+"),
              ),
            ),
            onTap: () {
              setState(() {
                cnt++;
                widget.handleCount(cnt);
              });
            },
          ),
        ],
      ),
    );
  }
}
