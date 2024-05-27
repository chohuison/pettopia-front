import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pettopia_front/hospital/page/findDisease.dart';
import 'package:pettopia_front/hospital/page/shortRecords.dart';
import 'package:pettopia_front/hospital/page/hospitalSearch.dart';

class CustomAppBar extends StatefulWidget {
  final int page;
  final List<Map<String, dynamic>> barList;
  final Function buttonHandler;
  const CustomAppBar(
      {Key? key,
      required this.page,
      required this.barList,
      required this.buttonHandler})
      : super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411.42857142857144, 683.4285714285714),
      child: Container(
        height: 100.h,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.barList.length,
          itemBuilder: (context, index) {
            final record = widget.barList[index];
            return Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: _buildIconButton(record['imgUrl'], index, record['title'],
                  widget.buttonHandler),
            );
          },
        ),
      ),
    );
  }

  Widget _buildIconButton(
      String img, int index, String name, Function buttonHandler) {
    return Container(
      height: 70.h,
      width: 50.w,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 20.h,
          ),
          ElevatedButton(
            onPressed: () {
              buttonHandler(index, context);
            },
            child: Container(
              height: 50.h,
              width: 40.w,
            ),
            style: ButtonStyle(
              backgroundColor: index == widget.page
                  ? MaterialStateProperty.all<Color>(Color(0xFFE3D5CA))
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
