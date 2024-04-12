import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShortWriteValue extends StatefulWidget {
  final DateTime selectedDay;
  const ShortWriteValue({Key? key, required this.selectedDay})
      : super(key: key);

  @override
  _ShortWriteValueState createState() => _ShortWriteValueState();
}

class _ShortWriteValueState extends State<ShortWriteValue> {
  String? _type;
  int? _count;
  int? _age;
  String getStrDay(DateTime dateTime) {
    return '${dateTime.year}년 ${_twoDigits(dateTime.month)}월 ${_twoDigits(dateTime.day)}일';
  }

  String _twoDigits(int n) {
    if (n >= 10) return '$n';
    return '0$n';
  }

  //데이터 저장
  void _saveDate(String dogname, String type, int count, int age) {
    print(dogname);
    print(type);
    print(count);
    print(age);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411.4, 683.4),
      child: MaterialApp(
          title: "shortRecordWrite",
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: child!,
            );
          },
          home: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              backgroundColor: Color.fromRGBO(237, 237, 233, 1.0),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context); // 팝업 닫기 기능 추가
                  },
                  // x버튼(상단바에 가려져서 그렇제 x버튼 있어요 ㅠㅠ)
                  icon: Icon(Icons.close),
                ),
              ],
            ),
            backgroundColor: Color.fromRGBO(237, 237, 233, 1.0),
            body: Column(
              children: <Widget>[
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  "명냥접종 기록 등록",
                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  height: 30.h,
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 30.w,
                      ),
                      Container(
                        width: 65.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                          color: Color(0xFF9F8678),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "날짜",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 30.w,
                      ),
                      Text(getStrDay(widget.selectedDay)),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  height: 30.h,
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 30.w,
                      ),
                      Container(
                        width: 65.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                          color: Color(0xFF9F8678),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "이름",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 30.w,
                      ),
                      Text("셀렉트 박스")
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  height: 30.h,
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 30.w,
                      ),
                      Container(
                        width: 65.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                          color: Color(0xFF9F8678),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "종류",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 30.w,
                      ),
                      Container(
                          width: 150.w,
                          child: TextField(
                              onChanged: (text) {
                                _type = text;
                              },
                              decoration: InputDecoration(
                                hintText: "접종 종류를 알려주세요",
                                hintStyle: TextStyle(fontSize: 13.0.sp),
                              ))),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  height: 30.h,
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 30.w,
                      ),
                      Container(
                        width: 65.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                          color: Color(0xFF9F8678),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "차시",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 30.w,
                      ),
                      Container(
                          width: 150.w,
                          child: TextField(
                              onChanged: (text) {
                                _count = int.tryParse(text);
                              },
                              decoration: InputDecoration(
                                hintText: "몇 차지인지 알려주세요",
                                hintStyle: TextStyle(fontSize: 13.0.sp),
                              ))),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  height: 30.h,
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 30.w,
                      ),
                      Container(
                        width: 65.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                          color: Color(0xFF9F8678),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            "나이",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 30.w,
                      ),
                      Container(
                          width: 150.w,
                          child: TextField(
                              onChanged: (text) {
                                _age = int.tryParse(text);
                              },
                              decoration: InputDecoration(
                                hintText: "몇 주차인지 알려주세요",
                                hintStyle: TextStyle(fontSize: 13.0.sp),
                              ))),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                SizedBox(
                  width: 90.w,
                  height: 30.h,
                  child: ElevatedButton(
                    onPressed: () {
                      _saveDate("dogname", _type!, _age!, _count!);
                    },
                    style: ButtonStyle(
                      side: MaterialStateProperty.all<BorderSide>(
                        BorderSide(color: Color(0xFF665D55)),
                      ),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Color(0xFFAFA59B)),
                    ),
                    child: Text(
                      "저장",
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
          )),
    );
  }
}
