import 'package:banana/routes/profile/change_profile.dart';
import 'package:flutter/material.dart';
import 'package:banana/routes/authentication/welcome.dart';
import 'package:banana/routes/authentication/login.dart';
import 'package:banana/routes/authentication/signup.dart';
import 'package:banana/routes/authentication/walkthrough.dart';
import 'package:banana/routes/profile/profile.dart';
import 'package:banana/routes/profile/self_following.dart';
import 'package:banana/routes/profile/self_followers.dart';
import 'package:banana/routes/main/home.dart';
import 'package:banana/routes/main/message_settings.dart';
import 'package:banana/routes/main/message.dart';


  void main() {
    /*
    WidgetsFlutterBinding.ensureInitialized();
    var route = "";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey("isNotFirst"))
      route="/welcome";
    else {
      route = "/";
      prefs.setBool("isNotFirst",false);
    }
    */

    runApp(MaterialApp(

      initialRoute: '/',

      routes: {
        '/':(context) =>TestScreen(),
        '/welcome':(context) =>Welcome(),
        '/login': (context) => Login(),
        '/signup': (context) => Register(),
        '/profile':(context) => Profile(),
        '/change_profile':(context) => ChangeProfile(),
        '/self_following':(context) => SelfFollowing(),
        '/self_followers':(context) => SelfFollowers(),
        '/home':(context) => Home(),
        '/message_':(context) => MessageSettings(),
        '/single_message':(context) => SingleMessage()
      },
    ));
  }
