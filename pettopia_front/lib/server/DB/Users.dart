import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';
import 'dart:io';

class Users{
  final String serverUrl='http://youtub';
  
  Users();
  
void launchLogin() async {
  const loginUrl = 'http://10.0.2.2:8080/login/oauth2/code/kakao'; 
  try{
      await launch(loginUrl);
  }
  catch(e){
    print(e);
  }
}


}