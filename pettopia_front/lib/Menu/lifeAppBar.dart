import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pettopia_front/hospital/page/shortRecords.dart';
import 'package:pettopia_front/hospital/page/hospitalSearch.dart';
import 'package:pettopia_front/life/page/petFilter.dart';

class LifeAppBar extends StatefulWidget {
  final int page;
  final List<Map<String,dynamic>> barList;
  const LifeAppBar({Key? key, required this.page, required this.barList}) : super(key: key);

  @override
  _LifeAppBarState createState() => _LifeAppBarState();
}

class _LifeAppBarState extends State<LifeAppBar> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411.4, 683.4),
      child:Container(
  height: 100.h,
  child: ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: 4, 
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
                  MaterialPageRoute(builder: (context) => PetFilter()),
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
