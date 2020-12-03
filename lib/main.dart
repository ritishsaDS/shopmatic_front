import 'package:flutter/material.dart';
import 'package:shopmatic_front/screens/Login_screen.dart';
import 'package:shopmatic_front/screens/SplashScreen.dart';

import 'screens/Home_screen.dart';
import 'screens/chat.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  appstate createState() => appstate();
}

class appstate extends State<MyApp> {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData(fontFamily: 'proxima'),
      routes: {
        '/': (context) => Splash(),
        '/login': (context) => Login(),
        '/home': (context) => Home(),
        //'/helloworld': ( context) => DynamicLinkScreen(),
      },



    );

   }}
