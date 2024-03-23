import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pettopia_front/hospital/page/hospitalSearch.dart';

class CustomBottomNavigatorBar extends StatefulWidget {
  final int page;

  const CustomBottomNavigatorBar({Key? key, required this.page}) : super(key: key);

  @override
  _CustomBottomNavigatorBarState createState() => _CustomBottomNavigatorBarState();
}

class _CustomBottomNavigatorBarState extends State<CustomBottomNavigatorBar> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411.4, 683.4),
      child: Container(
        height: 70.h,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildIconButton(Icons.content_cut, 0),
            _buildIconButton(Icons.local_hospital, 1),
            _buildIconButton(Icons.home, 2),
            _buildIconButton(Icons.list, 3),
            _buildIconButton(Icons.settings, 4),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton(IconData icon, int pageIndex) {
    return IconButton(
      onPressed: () {
      if(pageIndex == 1){
            Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HospitalSearch()),
                );
      }
      },
      icon: Icon(icon),
      color: widget.page == pageIndex ? Color.fromARGB(255, 0, 22, 64) : Colors.grey,
    );
  }
}
