import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Home_screen.dart';
import 'Login_screen.dart';

class Splash extends StatefulWidget {
  Statesplash createState() => Statesplash();

}
class Statesplash extends State<Splash>{
  @override
  void initState() {
    super.initState();

    _mockCheckForSession();

  }
Future<bool> _mockCheckForSession() async {
    await Future.delayed(Duration(milliseconds: 2000), () {});
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString('email');
    var intValue = prefs.getString('intValue');
    var name = prefs.getString('name');


    print(intValue);
    print(email);
    print(name);
    runApp(MaterialApp(home: email == null ? Login() : Home()));
    return true;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
return   Scaffold(body: Center(child: CircularProgressIndicator()));
  }




}
