import 'package:flutter/material.dart';


import 'package:flutter_chat/chatData.dart';
import 'package:flutter_chat/chatDB.dart';
import 'package:flutter_chat/chatWidget.dart';
import 'package:flutter_chat/constants.dart';
import 'package:flutter_chat/hexColor.dart';
import 'package:flutter_chat/screens/chat.dart';
import 'package:flutter_chat/screens/dashboard_screen.dart';
import 'package:flutter_chat/screens/login_screen.dart';
import 'package:flutter_chat/screens/zoomImage.dart';
class WelcomeScreen extends StatefulWidget {
  static const String id = "welcome_screen";
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    ChatData.init("Just Chat",context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ChatWidget.getAppBar(),
        backgroundColor: Colors.white,
        body: ChatWidget.widgetWelcomeScreen(context));
  }
}