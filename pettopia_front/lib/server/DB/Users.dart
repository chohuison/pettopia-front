import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';
import 'dart:io';

class Users{
  
  Users();
  
void launchLogin() async {
  const loginUrl = 'http://10.0.2.2:8080/oauth2/authorization/kakao'; 
  try{
      await launch(loginUrl);
  }
  catch(e){
    print(e);
  }
  // final url = Uri.parse("http://10.0.2.2:8080/login/oauth2/code/kakao?code=rHkpvsI-Lf0WjqI7_ClAugTa00IH9sGc7wtPqDd2ayjs7JUDsy13-7MsErYKPXKXAAABj0hj-oMSmUam6ZdnFg&state=JQ5UNChsF6ToMApIg8KgKAGI5B9E8X4OFEThRorDZTg%3D");
  // final response =await http.get(url);
  //     print(jsonDecode(utf8.decode(response.bodyBytes)));
}


}