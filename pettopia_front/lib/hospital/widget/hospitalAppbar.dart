import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pettopia_front/hospital/page/hospitalSearch.dart';

class HospitalAppBar extends StatefulWidget {
  final int page;

  const HospitalAppBar({Key? key, required this.page}) : super(key: key);

  @override
  _HospitalAppBarState createState() => _HospitalAppBarState();
}

class _HospitalAppBarState extends State<HospitalAppBar> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411.4, 683.4), // 디자인 기준 크기를 설정합니다.
      child: Container(
          height: 100.h,
          child: Row(
            children: <Widget>[
              SizedBox(width: 20.w),
              _buildIconButton('assets/img/hospitalIcon.png', 0, '병원찾기'),
              SizedBox(width: 20.w),
              _buildIconButton('assets/img/hospitalIcon.png', 1, '명냥접종'),
              SizedBox(width: 20.w),
              _buildIconButton('assets/img/hospitalIcon.png', 2, '피부병'),
              SizedBox(width: 20.w),
              _buildIconButton('assets/img/hospitalIcon.png', 3, '질병찾기')
            ],
          )),
    );
  }

Widget _buildIconButton(String img, int index, String name) {
  return Container(
    height: 70.h,
    width: 50.w,
    child: Column(
      children: <Widget>[
        ElevatedButton(
          onPressed: () {
            if(index == 0){
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HospitalSearch()),
                );
            }
          },
          child: Container(
            height: 50.h,
            width: 40.w,
          ),
          style: ButtonStyle(
            backgroundColor: index == widget.page
                ? MaterialStateProperty.all<Color>(Color(0xFFD5BDAF)) 
                : MaterialStateProperty.all<Color>(Color(0xFFF5EBE0)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 3.h,
        ),
        Text(
          name,
          style: TextStyle(fontSize: 9.sp),
        )
      ],
    ),
  );
}

}
