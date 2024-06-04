import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pettopia_front/hospital/page/kakaoMap.dart';
import 'package:pettopia_front/server/kakaoMapServer.dart';

class HospitalMap extends StatefulWidget {
  final Map<String, dynamic> value;
  final Map<String, dynamic> xyValue;
  const HospitalMap({
    Key? key,
    required this.value,
    required this.xyValue,
  }) : super(key: key);

  @override
  State<HospitalMap> createState() => _HospitalMapState();
}

class _HospitalMapState extends State<HospitalMap> {
  bool _isTapped = false;
  final kakaoMapServer _kakaoServer = kakaoMapServer();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(392.7272727273, 783.2727272727),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            appBar: AppBar(
              actions: [
                Container(
                  // color: Colors.blue,
                  width: 330.w,
                  child: Text(
                    widget.value['name'],
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.close)),
                )
              ],
            ),
            body: KakaoMap(
              x: widget.xyValue['x'],
              y: widget.xyValue['y'],
              name: widget.value['name'],
            ),
          ),
        ));
  }
}
