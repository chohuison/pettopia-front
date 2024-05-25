import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pettopia_front/Menu/AppBar.dart';
import 'package:pettopia_front/Menu/CustomBottomNavigatorBar.dart';
import 'package:pettopia_front/enum/appBarList.dart';

class PetsnalColor extends StatefulWidget {
  const PetsnalColor({Key? key}) : super(key: key);

  @override
  _PetsnalColorState createState() => _PetsnalColorState();
}

class _PetsnalColorState extends State<PetsnalColor>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  XFile? file;
  late List<Map<String, dynamic>> _beautyAppBar;
  AppBarList _appBarList = AppBarList();

  @override
  void initState() {
    super.initState();
    _beautyAppBar = _appBarList.getBeautyAppBar();
  }

  Future<void> _getCamera() async {
    ImagePicker().pickImage(source: ImageSource.camera).then((image) {
      if (image != null) {
        setState(() {
          file = image;
        });
      }
    });
  }

  Future<void> _getGallery() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage == null) {
      return;
    }

    // XFile? filteredImage = await petFilterService.applyPetFilter(
    //     pickedImage, '강이지', 'nose.png', 'horns2.png'); // 필터 적용 요청

    // setState(() {
    //   file = filteredImage;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411.4, 683.4),
      child: MaterialApp(
          title: "petsnalColor",
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: child!,
            );
          },
          home: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Color.fromRGBO(237, 237, 233, 1.0),
            body: Column(
              children: <Widget>[
                CustomAppBar(
                    page: 0,
                    barList: _beautyAppBar,
                    buttonHandler: _appBarList.beautyAppBarHandler),
                Container(
                  height: 485.h,
                  width: 500.w,
                  margin:
                      EdgeInsets.symmetric(vertical: 1.0.h, horizontal: 20.0.w),
                  decoration: BoxDecoration(
                    color: Color(0xFFE3D5CA),
                    borderRadius: BorderRadius.circular(25),
                  ),
                )
              ],
            ),
            bottomNavigationBar: CustomBottomNavigatorBar(page: 0),
          )),
    );
  }
}
