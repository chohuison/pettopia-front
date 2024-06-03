import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // dotenv 가져오기
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pettopia_front/beforeMain.dart';
import 'package:pettopia_front/main.dart';
import 'package:pettopia_front/server/DB/Pet.dart';
import 'package:pettopia_front/setting/page/naverViewPage.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:pettopia_front/Menu/CustomBottomNavigatorBar.dart';
import 'package:pettopia_front/server/DB/Users.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final userServer = Users();
  late WebViewController _webViewController = WebViewController();
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  late String _serverUrl = "";
  Pet _petServer = Pet();

  @override
  void initState() {
    super.initState();
    // _initializeWebview();
  }

  void _kakaoWebViewSetting(BuildContext context) async {
    await _getServerUrl();
    String url = _serverUrl + "oauth2/authorization/kakao";
    // String url = 'http://10.0.2.2/' + "oauth2/authorization/kakao";

    print(url);
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(url))
      ..setNavigationDelegate(NavigationDelegate(
        onNavigationRequest: (NavigationRequest request) {
          print("Navigating to: ${request.url}");
          return NavigationDecision.navigate;
        },
        onPageFinished: (String url) {
          _webViewController
              .runJavaScriptReturningResult("document.body.outerHTML")
              .then((html) async {
            print("Page finished loading. URL: $url");
            if (url.contains("code=")) {
              print("OAuth code found in URL:");
              print(html);

              print(html.runtimeType);
              String strHtml = html as String;

              if (context.mounted) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BeforeMain(
                      html: strHtml,
                    ),
                  ),
                );
              }
            }
          }).catchError((error) {
            print("Error getting HTML: $error");
          });
        },
      ));
  }

  void _naverWebViewSetting(BuildContext context) async {
    await _getServerUrl();
    String url = _serverUrl + "oauth2/authorization/naver";
    // String url = 'http://10.0.2.2/' + "oauth2/authorization/kakao";

    print(url);
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(url))
      ..setNavigationDelegate(NavigationDelegate(
        onNavigationRequest: (NavigationRequest request) {
          print("Navigating to: ${request.url}");
          return NavigationDecision.navigate;
        },
        onPageFinished: (String url) {
          _webViewController
              .runJavaScriptReturningResult("document.body.outerHTML")
              .then((html) async {
            print("Page finished loading. URL: $url");
            if (url.contains("code=")) {
              print("OAuth code found in URL:");
              print(html);

              print(html.runtimeType);
              String strHtml = html as String;
                  if (context.mounted) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BeforeMain(
                      html: strHtml,
                    ),
                  ),
                );
              }
            }
          }).catchError((error) {
            print("Error getting HTML: $error");
          });
        },
      ));
  }

  Future<void> _getServerUrl() async {
    try {
      await dotenv.load(fileName: ".env");
    } catch (e) {
      print("Error loading .env file: $e"); // 오류 메시지 출력
    }
    _serverUrl = dotenv.env['DB_SERVER_URI'] ?? 'YOUR_KAKAO_APP_KEY';
    print(_serverUrl);
  }

  void launchLogin(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => WebViewPage(controller: _webViewController),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411.42857142857144, 683.4285714285714),
      child: MaterialApp(
        title: "Login",
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: child!,
          );
        },
        home: Builder(
          builder: (context) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Color.fromRGBO(237, 237, 233, 1.0),
              body: Container(
                width: 400.w,
                height: 650.h,
                margin: EdgeInsets.all(15.w),
                decoration: BoxDecoration(
                  color: Color(0xFFE3D5CA),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 250.w,
                      height: 90.h,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/img/txtLogo.png'),
                        ),
                      ),
                    ),
                    SizedBox(height: 15.h),
                    Text("로그인", style: TextStyle(fontSize: 20.sp)),
                    SizedBox(height: 10.h),
                    Divider(
                      height: 2.h,
                      thickness: 1,
                      color: Color(0xFFD5BDAF),
                    ),
                    SizedBox(height: 10.h),
                    Container(
                      width: 200.w,
                      height: 60.h,
                      child: IconButton(
                        onPressed: () {
                          _kakaoWebViewSetting(context);
                          launchLogin(context);
                        },
                        icon: Image.asset(
                          'assets/img/kakao_login.png',
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Container(
                      width: 200.w,
                      height: 60.h,
                      child: IconButton(
                        onPressed: () {
                          _naverWebViewSetting(context);
                          launchLogin(context);
                        },
                        icon: Image.asset(
                          'assets/img/naver_login.png',
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      width: 200.w,
                      height: 70.h,
                      child: IconButton(
                        onPressed: () {
                          // 네이버 인증 때문에 만든 화면(구글 로그인 구현할 때 삭제해야 함)
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NaverViewPage()));
                        },
                        icon: Image.asset('assets/img/google_login.png'),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class WebViewPage extends StatefulWidget {
  final WebViewController controller;

  WebViewPage({required this.controller});

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("KakaoLogin"),
      ),
      body: WebViewWidget(
        controller: widget.controller, // 전달받은 컨트롤러 사용
      ),
    );
  }
}
