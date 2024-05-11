import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // dotenv 가져오기
import 'dart:async';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';

class KakaoMap extends StatefulWidget {
  final double x;
  final double y;
  const KakaoMap({Key? key, required this.x, required this.y}) : super(key: key);

  @override
  _KakaoMapState createState() => _KakaoMapState();
}

class _KakaoMapState extends State<KakaoMap>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  late final _kakaoAppKey;
  late final _controller;
  @override
  void initState() {
    super.initState();

    _initialize();
  }

  Future<void> _initialize() async {
    try {
      await dotenv.load(fileName: ".env");
    } catch (e) {
      print("Error loading .env file: $e"); // 오류 메시지 출력
    }
    _kakaoAppKey = dotenv.env['KAKAO_APP_KEY'] ?? 'YOUR_KAKAO_APP_KEY';
    print("apikey: " + _kakaoAppKey);
    setState(() {
      _controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..loadHtmlString(_generateMapHtml(_kakaoAppKey,widget.x, widget.y));
    });
  }

 String _generateMapHtml(String kakaoAppKey, double x, double y) {
  // 앱 키를 포함하는 HTML 문자열 생성
  return '''
    <!DOCTYPE html>
    <html lang="ko">
    <head>
      <meta charset="UTF-8">
      <script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=$kakaoAppKey&libraries=services"></script>
      <style>
        #map {
          width: 100%;
          height: 100vh;
        }
      </style>
    </head>
    <body onload="initializeMap()">
      <div id="map"></div>
      <script>
        function initializeMap() {
          // 존재 확인
          if (typeof kakao === 'undefined' || typeof kakao.maps === 'undefined' || typeof kakao.maps.services === 'undefined') {
            console.error("카카오맵 API가 제대로 로드되지 않았습니다.");
            return;
          }
          
          var x = $x;
          var y = $y;

          var container = document.getElementById('map');
          var options = {
            center: new kakao.maps.LatLng(y, x),
            level: 3
          };

          var map = new kakao.maps.Map(container, options);
          
          var coords = new kakao.maps.LatLng(y, x);
          
          var marker = new kakao.maps.Marker({
            map: map,
            position: coords
          });

          var infowindow = new kakao.maps.InfoWindow({
            content: '<div style="width:150px;text-align:center;padding:6px 0;">우리 회사</div>'
          });
          infowindow.open(map, marker);

          map.setCenter(coords);
        }
      </script>
    </body>
    </html>
  ''';
}


  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411.4, 683.4),
      child: MaterialApp(
        title: "hospitalSearch",
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: child!,
          );
        },
        home: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Color.fromRGBO(237, 237, 233, 1.0),
            appBar: AppBar(
              backgroundColor: Colors.white,
              leading: IconButton(
                // 뒤로가기 버튼
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context); // 뒤로 가기 동작
                },
              ),
            ),
            body: WebViewWidget(controller: _controller)),
      ),
    );
  }
}