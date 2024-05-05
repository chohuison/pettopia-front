import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:pettopia_front/Menu/CustomBottomNavigatorBar.dart';
import 'package:pettopia_front/server/DB/Users.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final userServer = Users();
  late WebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse('http://10.0.2.2:8080/oauth2/authorization/kakao'))
      ..setNavigationDelegate(NavigationDelegate(
        onNavigationRequest: (NavigationRequest request) {
          print(request.url);
          _webViewController.runJavaScriptReturningResult("document.body.innerHTML")
              .then((html) {
                print(html);
              });
          if (request.url.contains("code=")) {
            print("code");
            // return NavigationDecision.prevent; // 해당 페이지로 전환을 막음
          }
          return NavigationDecision.navigate; // 페이지 전환을 허용
        },
      ));
  }

  void launchLogin() {
    final loginUrl = 'http://10.0.2.2:8080/oauth2/authorization/kakao';
    print("왜안되");
        Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => WebViewPage(initialUrl: loginUrl, controller: _webViewController),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411.4, 683.4),
      builder: (_, __) {
        return MaterialApp(
          title: "Login",
          home: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Color.fromRGBO(237, 237, 233, 1.0),
            body: Container(
              width: 400.w,
              height: 600.h,
              margin: EdgeInsets.all(15.w),
              decoration: BoxDecoration(
                color: Color(0xFFE3D5CA),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 240.w,
                    height: 80.h,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/img/txtLogo.png'),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text("로그인", style: TextStyle(fontSize: 20.sp)),
                  Divider(
                    height: 2.h,
                    thickness: 1,
                    color: Color(0xFFD5BDAF),
                  ),
                 Container(
    width: 185.w,
    height: 50.h,
    child: IconButton(
      onPressed:(){
        print("버튼 누름");
        launchLogin();} , // 함수 호출
      icon: Image.asset(
        'assets/img/kakao_login.png',
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
      ),
    ),
  ),
                  _naverLogin(),
                  _googleLogin(),
                ],
              ),
            ),
            bottomNavigationBar: CustomBottomNavigatorBar(page: 4),
          ),
        );
      },
    );
  }
}

// Widget _kakaoLogin(Function onLogin) {
//   return Container(
//     width: 185.w,
//     height: 50.h,
//     child: IconButton(
//       onPressed:(){
//         print("버튼 누름");
//         onLogin;} , // 함수 호출
//       icon: Image.asset(
//         'assets/img/kakao_login.png',
//         width: double.infinity,
//         height: double.infinity,
//         fit: BoxFit.cover,
//       ),
//     ),
//   );
// }

Widget _naverLogin() {
  return Container(
    width: 185.w,
    height: 50.h,
    child: IconButton(
      onPressed: () {},
      icon: Image.asset(
        'assets/img/naver_login.png',
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
      ),
    ),
  );
}

Widget _googleLogin() {
  return Container(
    width: 185.w,
    height: 50.h,
    child: IconButton(
      onPressed: () {},
      icon: Image.asset(
        'assets/img/google_login.png'),
    ),
  );
}

class WebViewPage extends StatefulWidget {
  final String initialUrl;
  final WebViewController controller;

  WebViewPage({required this.initialUrl, required this.controller});

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
        title: Text("WebView"),
      ),
      body: WebViewWidget(
        controller: widget.controller, // 전달받은 컨트롤러 사용
      ),
    );
  }
}
