import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:pettopia_front/Menu/CustomBottomNavigatorBar.dart';

class ModifyDiary extends StatefulWidget {
  const ModifyDiary({Key? key}) : super(key: key);

  @override
  _ModifyDiaryState createState() => _ModifyDiaryState();
}

class _ModifyDiaryState extends State<ModifyDiary>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411.4, 683.4),
      child: MaterialApp(
          title: "writeDiary",
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: child!,
            );
          },
          home: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Color.fromRGBO(237, 237, 233, 1.0),
            body: Container(),
            bottomNavigationBar: CustomBottomNavigatorBar(page: 3),
          )),
    );
  }
}
