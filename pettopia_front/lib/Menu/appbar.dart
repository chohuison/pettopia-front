import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pettopia_front/hospital/page/shortRecords.dart';
import 'package:pettopia_front/hospital/page/hospitalSearch.dart';

class AppBarContainer extends StatefulWidget {
  final int page;
  final List<Map<String,dynamic>> barList;
  const AppBarContainer({Key? key, required this.page, required this.barList}) : super(key: key);

  @override
  _AppBarContainerState createState() => _AppBarContainerState();
}

class _AppBarContainerState extends State<AppBarContainer> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411.4, 683.4),
      child:Container(
  height: 100.h,
  child: ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: 4, // 리스트의 개수에 맞게 설정하세요
    itemBuilder: (context, index) {
      final record = widget.barList[index];
      return Padding(
        padding: EdgeInsets.only(left: 20.w),
        child: _buildIconButton(record['imgUrl'], index, record['title']),
      );
    },
  ),
),
    );
  }

Widget _buildIconButton(String img, int index, String name) {
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
            if(index == 0){
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HospitalSearch()),
                );
            }
              if(index == 1){
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ShortRecords()),
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
