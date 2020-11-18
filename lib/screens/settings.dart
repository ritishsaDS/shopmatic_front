import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopmatic_front/screens/bottom_bar.dart';
import 'package:shopmatic_front/screens/profile_screen.dart';
import 'package:shopmatic_front/screens/userprofile.dart';

import 'Group_members.dart';
import 'Home_screen.dart';
import 'Login_screen.dart';
import 'follow_requests.dart';
import 'manage_category.dart';
import 'manage_products.dart';
import 'manage_story.dart';

class settings extends StatefulWidget {
  @override
  settings_state createState() => settings_state();
}

class settings_state extends State<settings> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Settings",
            style: TextStyle(fontFamily: 'proxima', color: Colors.black),
          ),
          backgroundColor: Colors.white,
          actions: <Widget>[
            Container(
              padding: EdgeInsets.only(right: 10),
              child: Icon(Icons.message, color: Colors.black),
            )
          ],
        ),
        body: ListView(
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 7, right: 7),
              child: RaisedButton(
                  child: Text('Subscribe',
                      style: TextStyle(fontSize: 18, fontFamily: "proxima")),
                  textColor: Colors.white,
                  color: Colors.blue,
                  onPressed: () async {
                    /* Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext ctx) => splash()));*/
                  },
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(3.0))),
            ),
            SizedBox(
              height: 6,
            ),
            Container(
                child: Column(
              children: <Widget>[
                Container(
                  color: Colors.white,
                  padding:
                      EdgeInsets.only(left: 15.0, right: 7, top: 5, bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: RichText(
                          text: TextSpan(children: [
                            WidgetSpan(
                              child: Icon(Icons.redeem, color: Colors.blue),
                            ),
                            WidgetSpan(
                                child: Container(
                                    padding: EdgeInsets.only(left: 10.0),
                                    child: Text(
                                      "abdc.myshopmatic.com ",
                                      style: TextStyle(
                                          fontFamily: 'proxima',
                                          color: Colors.black,
                                          fontSize: 18),
                                    ))),
                          ]),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(right: 5),
                          child: Icon(Icons.cast_connected,
                              color: Colors.blue, size: 20))
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  padding:
                      EdgeInsets.only(left: 15.0, right: 7, top: 5, bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: RichText(
                          text: TextSpan(children: [
                            WidgetSpan(
                              child: Icon(Icons.desktop_windows,
                                  color: Colors.blue, size: 20),
                            ),
                            WidgetSpan(
                                child: Container(
                                    padding: EdgeInsets.only(left: 10.0),
                                    child: Text(
                                      "Publish Store ",
                                      style: TextStyle(
                                          fontFamily: 'proxima',
                                          color: Colors.black,
                                          fontSize: 18),
                                    ))),
                          ]),
                        ),
                      ),
                      Switch(
                        value: isSwitched,
                        onChanged: (value) {
                          setState(() {
                            isSwitched = value;
                            print(isSwitched);
                          });
                        },
                        activeTrackColor: Colors.lightGreenAccent,
                        activeColor: Colors.green,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  color: Colors.white,
                  padding:
                      EdgeInsets.only(left: 15.0, right: 7, top: 7, bottom: 7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: RichText(
                          text: TextSpan(children: [
                            WidgetSpan(
                              child: Icon(Icons.event_note,
                                  color: Colors.blue, size: 20),
                            ),
                            WidgetSpan(
                                child: Container(
                                    padding: EdgeInsets.only(
                                        left: 10.0, bottom: 2, top: 2),
                                    child: Text(
                                      "Notifications ",
                                      style: TextStyle(
                                          fontFamily: 'proxima',
                                          color: Colors.black,
                                          fontSize: 18),
                                    ))),
                          ]),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(right: 5),
                          child: Icon(Icons.arrow_forward_ios,
                              color: Colors.grey[300], size: 14))
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  color: Colors.white,
                  padding:
                      EdgeInsets.only(left: 15.0, right: 7, top: 7, bottom: 7),
                  child: GestureDetector(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: RichText(
                              text: TextSpan(children: [
                                WidgetSpan(
                                  child: Icon(Icons.event_note,
                                      color: Colors.blue, size: 20),
                                ),
                                WidgetSpan(
                                    child: Container(
                                        padding: EdgeInsets.only(
                                            left: 10.0, bottom: 2, top: 2),
                                        child: Text(
                                          "Manage Store ",
                                          style: TextStyle(
                                              fontFamily: 'proxima',
                                              color: Colors.black,
                                              fontSize: 18),
                                        ))),
                              ]),
                            ),
                          ),
                          Container(
                              padding: EdgeInsets.only(right: 5),
                              child: Icon(Icons.arrow_forward_ios,
                                  color: Colors.grey[300], size: 14))
                        ],
                      ),
                      onTap: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => userProfile()));
                      }),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Container(
                        color: Colors.white,
                        padding: EdgeInsets.only(
                            left: 15.0, right: 7, top: 5, bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: RichText(
                                text: TextSpan(children: [
                                  WidgetSpan(
                                    child: Icon(Icons.poll,
                                        color: Colors.blue, size: 20),
                                  ),
                                  WidgetSpan(
                                      child: Container(
                                          padding: EdgeInsets.only(
                                              left: 10.0, top: 8),
                                          child: Text(
                                            "Setup ",
                                            style: TextStyle(
                                                fontFamily: 'proxima',
                                                color: Colors.black,
                                                fontSize: 18),
                                          ))),
                                ]),
                              ),
                            ),
                            Container(
                                padding: EdgeInsets.only(right: 5),
                                child: Icon(Icons.arrow_forward_ios,
                                    color: Colors.grey[300], size: 14))
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 42.0, right: 30.0),
                        child: Divider(
                          color: Colors.grey[300],
                          thickness: 1,
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        padding: EdgeInsets.only(
                            left: 15.0, right: 7, top: 5, bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: RichText(
                                text: TextSpan(children: [
                                  WidgetSpan(
                                    child: Icon(
                                      Icons.tv,
                                      color: Colors.blue,
                                      size: 20,
                                    ),
                                  ),
                                  WidgetSpan(
                                      child: Container(
                                          padding: EdgeInsets.only(left: 10.0),
                                          child: Text(
                                            "Marketing",
                                            style: TextStyle(
                                                fontFamily: 'proxima',
                                                color: Colors.black,
                                                fontSize: 18),
                                          ))),
                                ]),
                              ),
                            ),
                            Container(
                                padding: EdgeInsets.only(right: 5),
                                child: Icon(Icons.arrow_forward_ios,
                                    color: Colors.grey[300], size: 14))
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 42.0, right: 20.0),
                        child: Divider(
                          color: Colors.grey[300],
                          thickness: 1,
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        padding: EdgeInsets.only(
                            left: 15.0, right: 7, top: 5, bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: RichText(
                                text: TextSpan(children: [
                                  WidgetSpan(
                                      child: Container(
                                    child: Icon(Icons.store,
                                        color: Colors.blue, size: 20),
                                  )),
                                  WidgetSpan(
                                      child: Container(
                                          padding: EdgeInsets.only(left: 15.0),
                                          child: Text(
                                            "Shopmatic World ",
                                            style: TextStyle(
                                                fontFamily: 'proxima',
                                                color: Colors.black,
                                                fontSize: 18),
                                          ))),
                                ]),
                              ),
                            ),
                            Container(
                                padding: EdgeInsets.only(right: 5),
                                child: Icon(Icons.arrow_forward_ios,
                                    color: Colors.grey[300], size: 14))
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 42.0, right: 20.0),
                        child: Divider(
                          color: Colors.grey[300],
                          thickness: 1,
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        padding: EdgeInsets.only(
                            left: 15.0, right: 7, top: 5, bottom: 5),
                        child: GestureDetector(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  child: RichText(
                                    text: TextSpan(children: [
                                      WidgetSpan(
                                          child: Container(
                                        child: Icon(Icons.store,
                                            color: Colors.blue, size: 20),
                                      )),
                                      WidgetSpan(
                                          child: Container(
                                              padding:
                                                  EdgeInsets.only(left: 15.0),
                                              child: Text(
                                                "Add Stories ",
                                                style: TextStyle(
                                                    fontFamily: 'proxima',
                                                    color: Colors.black,
                                                    fontSize: 18),
                                              ))),
                                    ]),
                                  ),
                                ),
                                Container(
                                    padding: EdgeInsets.only(right: 5),
                                    child: Icon(Icons.arrow_forward_ios,
                                        color: Colors.grey[300], size: 14))
                              ],
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => manageStory()));
                            }),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 42.0, right: 20.0),
                        child: Divider(
                          color: Colors.grey[300],
                          thickness: 1,
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        padding: EdgeInsets.only(
                            left: 15.0, right: 7, top: 5, bottom: 5),
                        child: GestureDetector(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  child: RichText(
                                    text: TextSpan(children: [
                                      WidgetSpan(
                                          child: Container(
                                        child: Icon(Icons.store,
                                            color: Colors.blue, size: 20),
                                      )),
                                      WidgetSpan(
                                          child: Container(
                                              padding:
                                                  EdgeInsets.only(left: 15.0),
                                              child: Text(
                                                "Follow Requests ",
                                                style: TextStyle(
                                                    fontFamily: 'proxima',
                                                    color: Colors.black,
                                                    fontSize: 18),
                                              ))),
                                    ]),
                                  ),
                                ),
                                Container(
                                    padding: EdgeInsets.only(right: 5),
                                    child: Icon(Icons.arrow_forward_ios,
                                        color: Colors.grey[300], size: 14))
                              ],
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => follow()));
                            }),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 42.0, right: 20.0),
                        child: Divider(
                          color: Colors.grey[300],
                          thickness: 1,
                        ),
                      ),
                      GestureDetector(
                        child: Container(
                          color: Colors.white,
                          padding: EdgeInsets.only(
                              left: 15.0, right: 7, top: 5, bottom: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: RichText(
                                  text: TextSpan(children: [
                                    WidgetSpan(
                                        child: Container(
                                      child: Icon(Icons.store,
                                          color: Colors.blue, size: 20),
                                    )),
                                    WidgetSpan(
                                        child: Container(
                                            padding:
                                                EdgeInsets.only(left: 15.0),
                                            child: Text(
                                              "Manage Categories ",
                                              style: TextStyle(
                                                  fontFamily: 'proxima',
                                                  color: Colors.black,
                                                  fontSize: 18),
                                            ))),
                                  ]),
                                ),
                              ),
                              Container(
                                  padding: EdgeInsets.only(right: 5),
                                  child: Icon(Icons.arrow_forward_ios,
                                      color: Colors.grey[300], size: 14))
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => manageCategory()));
                        },
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 42.0, right: 20.0),
                        child: Divider(
                          color: Colors.grey[300],
                          thickness: 1,
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        padding: EdgeInsets.only(
                            left: 15.0, right: 7, top: 5, bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            GestureDetector(
                              child: Container(
                                child: RichText(
                                  text: TextSpan(children: [
                                    WidgetSpan(
                                        child: Container(
                                      child: Icon(Icons.store,
                                          color: Colors.blue, size: 20),
                                    )),
                                    WidgetSpan(
                                        child: Container(
                                            padding:
                                                EdgeInsets.only(left: 15.0),
                                            child: Text(
                                              "Manage Products ",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18),
                                            ))),
                                  ]),
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            manageproducts()));
                              },
                            ),
                            Container(
                                padding: EdgeInsets.only(right: 5),
                                child: Icon(Icons.arrow_forward_ios,
                                    color: Colors.grey[300], size: 14))
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 42.0, right: 20.0),
                        child: Divider(
                          color: Colors.grey[300],
                          thickness: 1,
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        padding: EdgeInsets.only(
                            left: 15.0, right: 7, top: 5, bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: RichText(
                                text: TextSpan(children: [
                                  WidgetSpan(
                                    child: Icon(Icons.scanner,
                                        color: Colors.blue, size: 20),
                                  ),
                                  WidgetSpan(
                                      child: Container(
                                          padding: EdgeInsets.only(left: 10.0),
                                          child: Text(
                                            "Create Instant Order ",
                                            style: TextStyle(
                                                fontFamily: 'proxima',
                                                color: Colors.black,
                                                fontSize: 18),
                                          ))),
                                ]),
                              ),
                            ),
                            Container(
                                padding: EdgeInsets.only(right: 5),
                                child: Icon(Icons.arrow_forward_ios,
                                    color: Colors.grey[300], size: 14))
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 42.0, right: 20.0),
                        child: Divider(
                          color: Colors.grey[300],
                          thickness: 1,
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        padding: EdgeInsets.only(
                            left: 15.0, right: 7, top: 5, bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: RichText(
                                text: TextSpan(children: [
                                  WidgetSpan(
                                    child: Icon(Icons.redeem,
                                        color: Colors.blue, size: 20),
                                  ),
                                  WidgetSpan(
                                      child: Container(
                                          padding: EdgeInsets.only(left: 10.0),
                                          child: Text(
                                            "Terms and Conditions ",
                                            style: TextStyle(
                                                fontFamily: 'proxima',
                                                color: Colors.black,
                                                fontSize: 18),
                                          ))),
                                ]),
                              ),
                            ),
                            Container(
                                padding: EdgeInsets.only(right: 5),
                                child: Icon(Icons.arrow_forward_ios,
                                    color: Colors.grey[300], size: 14))
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 42.0, right: 20.0),
                        child: Divider(
                          color: Colors.grey[300],
                          thickness: 1,
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        padding: EdgeInsets.only(
                            left: 15.0, right: 7, top: 5, bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: RichText(
                                text: TextSpan(children: [
                                  WidgetSpan(
                                    child: Icon(Icons.account_balance,
                                        color: Colors.blue, size: 20),
                                  ),
                                  WidgetSpan(
                                      child: Container(
                                          padding: EdgeInsets.only(left: 10.0),
                                          child: Text(
                                            "Financial Services ",
                                            style: TextStyle(
                                                fontFamily: 'proxima',
                                                color: Colors.black,
                                                fontSize: 18),
                                          ))),
                                ]),
                              ),
                            ),
                            Container(
                                padding: EdgeInsets.only(right: 5),
                                child: Icon(Icons.arrow_forward_ios,
                                    color: Colors.grey[300], size: 14))
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 40.0, right: 20.0),
                        child: Divider(
                          color: Colors.grey[300],
                          thickness: 1,
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        padding: EdgeInsets.only(
                            left: 15.0, right: 7, top: 5, bottom: 5),
                        child: GestureDetector(
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: RichText(
                                  text: TextSpan(children: [
                                    WidgetSpan(
                                      child: Icon(Icons.redeem,
                                          color: Colors.blue, size: 20),
                                    ),
                                    WidgetSpan(
                                        child: Container(
                                            padding: EdgeInsets.only(left: 10.0),
                                            child: Text(
                                              "Group Members ",
                                              style: TextStyle(
                                                  fontFamily: 'proxima',
                                                  color: Colors.black,
                                                  fontSize: 18),
                                            ))),
                                  ]),
                                ),
                              ),
                              Container(
                                  padding: EdgeInsets.only(right: 5),
                                  child: Icon(Icons.arrow_forward_ios,
                                      color: Colors.grey[300], size: 14))
                            ],
                          ),onTap:(){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      groupmember()));
                        }
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 42.0, right: 20.0),
                        child: Divider(
                          color: Colors.grey[300],
                          thickness: 1,
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        padding: EdgeInsets.only(
                            left: 15.0, right: 7, top: 5, bottom: 5),
                        child: GestureDetector(
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: RichText(
                                  text: TextSpan(children: [
                                    WidgetSpan(
                                      child: Icon(Icons.card_membership,
                                          color: Colors.blue, size: 20),
                                    ),
                                    WidgetSpan(
                                        child: Container(
                                            padding: EdgeInsets.only(left: 10.0),
                                            child: Text(
                                              "Edit Your Profile ",
                                              style: TextStyle(
                                                  fontFamily: 'proxima',
                                                  color: Colors.black,
                                                  fontSize: 18),
                                            ))),
                                  ]),
                                ),
                              ),
                              Container(
                                  padding: EdgeInsets.only(right: 5),
                                  child: Icon(Icons.arrow_forward_ios,
                                      color: Colors.grey[300], size: 14))
                            ],
                          ),onTap:(){
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (BuildContext ctx) => profile()));
                        }
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 42.0, right: 20.0),
                        child: Divider(
                          color: Colors.grey[300],
                          thickness: 1,
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        padding: EdgeInsets.only(
                            left: 15.0, right: 7, top: 5, bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: RichText(
                                text: TextSpan(children: [
                                  WidgetSpan(
                                    child: Icon(Icons.redeem,
                                        color: Colors.blue, size: 20),
                                  ),
                                  WidgetSpan(
                                      child: Container(
                                          padding: EdgeInsets.only(left: 10.0),
                                          child: Text(
                                            "Give us feedback ",
                                            style: TextStyle(
                                                fontFamily: 'proxima',
                                                color: Colors.black,
                                                fontSize: 18),
                                          ))),
                                ]),
                              ),
                            ),
                            Container(
                                padding: EdgeInsets.only(right: 5),
                                child: Icon(Icons.arrow_forward_ios,
                                    color: Colors.grey[300], size: 14))
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 42.0, right: 20.0),
                        child: Divider(
                          color: Colors.grey[300],
                          thickness: 1,
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        padding: EdgeInsets.only(
                            left: 15.0, right: 7, top: 5, bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: RichText(
                                text: TextSpan(children: [
                                  WidgetSpan(
                                    child: Icon(Icons.chat,
                                        color: Colors.blue, size: 20),
                                  ),
                                  WidgetSpan(
                                      child: Container(
                                          padding: EdgeInsets.only(left: 10.0),
                                          child: Text(
                                            "FAQ's & chat support ",
                                            style: TextStyle(
                                                fontFamily: 'proxima',
                                                color: Colors.black,
                                                fontSize: 18),
                                          ))),
                                ]),
                              ),
                            ),
                            Container(
                                padding: EdgeInsets.only(right: 5),
                                child: Icon(Icons.arrow_forward_ios,
                                    color: Colors.grey[300], size: 14))
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 42.0, right: 20.0),
                        child: Divider(
                          color: Colors.grey[300],
                          thickness: 1,
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        padding: EdgeInsets.only(
                            left: 15.0, right: 7, top: 5, bottom: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: RichText(
                                text: TextSpan(children: [
                                  WidgetSpan(
                                    child: Icon(Icons.redeem,
                                        color: Colors.blue, size: 20),
                                  ),
                                  WidgetSpan(
                                      child: Container(
                                          padding: EdgeInsets.only(left: 10.0),
                                          child: Text(
                                            "Privacy Policy",
                                            style: TextStyle(
                                                fontFamily: 'proxima',
                                                color: Colors.black,
                                                fontSize: 18),
                                          ))),
                                ]),
                              ),
                            ),
                            Container(
                                padding: EdgeInsets.only(right: 5),
                                child: Icon(Icons.arrow_forward_ios,
                                    color: Colors.grey[300], size: 14))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  color: Colors.white,
                  padding:
                      EdgeInsets.only(left: 15.0, right: 7, top: 5, bottom: 5),
                  child:GestureDetector(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: RichText(
                            text: TextSpan(children: [
                              WidgetSpan(
                                child: Icon(Icons.power_settings_new,
                                    color: Colors.blue, size: 20),
                              ),
                              WidgetSpan(
                                  child: Container(
                                      padding: EdgeInsets.only(
                                          left: 10.0, bottom: 2, top: 2),
                                      child: Text(
                                        "Logout ",
                                        style: TextStyle(
                                            fontFamily: 'proxima',
                                            color: Colors.black,
                                            fontSize: 18),
                                      ))),
                            ]),
                          ),
                        ),
                      ],
                    ),onTap:() async {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.remove('email');
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (BuildContext ctx) => Login()));
                  }
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ))
          ],
        ),
        bottomNavigationBar: BottomTabs(5, true),
      ),
    );
  }
}
