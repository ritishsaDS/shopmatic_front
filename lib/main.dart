import 'package:flutter/material.dart';
import 'package:shopmatic_front/screens/Login_screen.dart';
import 'package:shopmatic_front/screens/SplashScreen.dart';
import 'package:shopmatic_front/screens/store_products.dart';
import 'screens/Home_screen.dart';
import 'screens/profile_screen.dart';

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
      },



    );

   }}
