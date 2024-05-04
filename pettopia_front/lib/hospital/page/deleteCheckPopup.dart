import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pettopia_front/hospital/page/shortRecords.dart';
import 'package:pettopia_front/server/DB/ShotRecords.dart';

class DeleteCheckPopup extends StatefulWidget {
  final int pk;
  const DeleteCheckPopup({Key? key, required this.pk}) : super(key: key);

  _DeleteCheckPopupState createState() => _DeleteCheckPopupState();
}

class _DeleteCheckPopupState extends State<DeleteCheckPopup> {

  final shotRecordsServer = ShotRecords();
  void delete () async {
    shotRecordsServer.deleteShotRecord(widget.pk);
  }
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411.4, 683.4),
      child: MaterialApp(
        builder: (context, child) {
          //전체 창 크기 조절 이걸로 하면됨 !
          return SizedBox(
            height: 245.h,
            child: child,
          );
        },
        home: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close))
            ],
          ),
          body: Container(
            child: Column(
              children: [
                Center(
                  child: Text(
                    "해당 항목을",
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                  ),
                ),
                Center(
                  child: Text(
                    "삭제 하시겠습니까 ? ",
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 40.h,
                ),
                SizedBox(
                  width: 90.w,
                  height: 30.h,
                  child: ElevatedButton(
                    onPressed: () {
                      delete();
                   Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ShortRecords()),
      );
                    },
                    style: ButtonStyle(
                      side: MaterialStateProperty.all<BorderSide>(
                        BorderSide(color: Color(0xFF665D55)),
                      ),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Color(0xFFAFA59B)),
                    ),
                    child: Text(
                      "삭제",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
