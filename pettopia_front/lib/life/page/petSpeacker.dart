import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pettopia_front/Menu/AppBar.dart';
import 'package:pettopia_front/Menu/CustomBottomNavigatorBar.dart';
import 'package:pettopia_front/enum/appBarList.dart';
import 'package:pettopia_front/life/widget/speciesButton.dart';
import 'dart:math';

class PetSpeaker extends StatefulWidget {
  const PetSpeaker({Key? key}) : super(key: key);

  @override
  _PetSpeakerState createState() => _PetSpeakerState();
}

class _PetSpeakerState extends State<PetSpeaker>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  late List<Map<String, dynamic>> _lifeAppBar;
  AppBarList _appBarList = AppBarList();
  late List<Map<String, dynamic>> _speackerList = [];
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _lifeAppBar = _appBarList.getLifeAppBar();
    _audioPlayer = AudioPlayer();
    _audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        // Update UI based on player state
      });
    });
    _audioPlayer.onPlayerComplete.listen((event) {
      print('Audio playback completed');
    });
  }

  int _index = 0;
  int _getIndex(int index) {
    _index = index;
    return index;
  }

  void _toggleNatureAudio(Map<String, dynamic> value) async {
    if (_isPlaying) {
      await _audioPlayer.stop();
      setState(() {
        _isPlaying = false;
        print("음악 꺼짐");
      });
    } else {
      Random random = Random();
      int randomIndex = random.nextInt(3) + 1;

      await _audioPlayer.play(AssetSource(value['path']));
      setState(() {
        _isPlaying = true;
        print("음악 켜짐");
      });
    }
  }

  void _getSpeackerList(int index) {
    if (index == 1) {
      _speackerList = [
        {
          "name": "훈련클리커",
          "value": "클릭하면 딸깍 소리가 납니다.\n훈련 후 클리커를 누르고 간식을 주세요.",
          "path": "audio/clicker.mp3",
        },
        {
          "name": "자연 백색소음",
          "value": "강아지들은 백색소음을 들으면 스트레스가 감소해요.\n안정이 필요한 강아지에게 들려주세요.",
          "path": "audio/rainforest-208926.mp3",
        }
      ];
    } else if (index == 2) {
      _speackerList = [
        {
          "name": "클래식",
          "value": "고양이에게 클래식을 들려주면 \n스트레스를 낮추는 효과가 있습니다.",
          "path":
              "audio/etude-mediation-for-piano-violin-and-cello-in-f-177732.mp3"
        }
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(392.7272727273, 783.2727272727),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "shortRecords",
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
                page: 3,
                barList: _lifeAppBar,
                buttonHandler: _appBarList.lifeAppBarHandler,
              ),
              Container(
                height: 550.h,
                width: 500.w,
                margin:
                    EdgeInsets.symmetric(vertical: 1.0.h, horizontal: 20.0.w),
                decoration: BoxDecoration(
                  color: Color(0xFFE3D5CA),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10.0),
                      height: 40.h,
                      child: SpeciesButton(
                        indexNum: _index,
                        index: (index) {
                          setState(() {
                            _index = _getIndex(index);
                            _getSpeackerList(index);
                          });
                        },
                      ),
                    ),
                    Container(
                      height: 420.h,
                      child: buildWidget(_index),
                    ),
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: CustomBottomNavigatorBar(page: 3),
        ),
      ),
    );
  }

  Widget buildWidget(int index) {
    switch (index) {
      case 1:
      case 2:
        return buildList(_speackerList);
      default:
        return Container();
    }
  }

  Widget buildList(List<Map<String, dynamic>> list) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        if (list != null && index < list.length) {
          final record = list[index]!;
          return buildListValue(record, () => _toggleNatureAudio(record));
        } else {
          return SizedBox();
        }
      },
    );
  }

  Widget buildListValue(Map<String, dynamic> value, Function function) {
    return GestureDetector(
      onTap: () async {
        function();
      },
      child: Container(
        margin: EdgeInsets.only(
            top: 0.0.h, left: 10.0.w, right: 10.w, bottom: 10.h),
        padding: EdgeInsets.only(top: 10.w),
        width: 350.w,
        height: 100.h,
        decoration: BoxDecoration(
          color: Color(0xFFF5EBE0),
          borderRadius: BorderRadius.circular(35.0),
        ),
        child: Column(
          children: <Widget>[
            Center(
              child: Text(
                value['name'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.sp,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Center(
              child: Text(value['value']),
            ),
          ],
        ),
      ),
    );
  }
}
