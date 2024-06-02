import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
              padding: EdgeInsets.only(left: 5.w),
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
      // color: Colors.green,
      height: 70.h,
      width: 70.w,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 20.h,
          ),
          GestureDetector(
            onTap: () {
              buttonHandler(index, context);
            },
            child: Container(
              height: 60.h,
              width: 60.w,
              child: Container(
                  height: 55.h,
                  width: 55.w,
                  padding: EdgeInsets.all(5.w),
                  child: Image.asset(img)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: index == widget.page
                    ? Color(0xFFE3D5CA)
                    : Color(0xFFF5EBE0),
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
