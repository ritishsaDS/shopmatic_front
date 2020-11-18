import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:io';
import 'package:shopmatic_front/utils/common.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:http/http.dart' as http;

import 'Home_screen.dart';
class Login extends StatefulWidget{
  Loginstate createState()=> Loginstate();
}
class Loginstate extends State<Login>{
  TextEditingController emailController = new TextEditingController();
  TextEditingController passController = new TextEditingController();
  bool isError = false;
  bool isLoading = false;
  int maxLength = 10;
  String text = "";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Scaffold(
            resizeToAvoidBottomPadding: false,
            appBar: AppBar(

              elevation: 0,
              backgroundColor: Colors.transparent,

            ),
            body: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: 20.0, right: 20.0),
                          child: RaisedButton(
                              child: Text('WITH facebook',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                              color: Colors.indigo,
                              onPressed: () {
                                /*Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => bottom()),
                                );*/
                              },
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                  new BorderRadius.circular(17.0))),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 20.0, right: 20.0),
                          child: RaisedButton(
                              child: Text(
                                'WITH google',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              color: Colors.red,
                              onPressed: () {
                                Navigator.of(context)
                                    .pushReplacementNamed('/HomeScreen');
                              },
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                  new BorderRadius.circular(17.0))),
                        )
                      ],
                    ),
                  ),
                  Row(children: <Widget>[
                    Expanded(
                      child: new Container(
                          margin:
                          const EdgeInsets.only(left: 10.0, right: 15.0),
                          child: Divider(
                            color: Colors.black,
                            height: 50,
                          )),
                    ),
                    Text("OR"),
                    Expanded(
                      child: new Container(
                          margin:
                          const EdgeInsets.only(left: 15.0, right: 10.0),
                          child: Divider(
                            color: Colors.black,
                            height: 50,
                          )),
                    ),
                  ]),
                  Container(
                    height: 60,
                    padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: TextField(
                      inputFormatters: [
                        WhitelistingTextInputFormatter.digitsOnly,
                      ],
                      keyboardType: TextInputType.number,
                      controller: emailController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top:5),
                        hintText: "Email Address or Phone Number",
                        hintStyle: TextStyle(
                            fontFamily: "ProximaNova", color: Colors.black),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),

                      ),
                        onChanged: (String newVal) {
                          if(newVal.length <= maxLength){
                            text = newVal;
                          }else{
                            emailController.value = new TextEditingValue(
                                text: text,
                                selection: new TextSelection(
                                    baseOffset: maxLength,
                                    extentOffset: maxLength,
                                    affinity: TextAffinity.downstream,
                                    isDirectional: false
                                ),
                                composing: new TextRange(
                                    start: 0, end: maxLength
                                )
                            );
                            emailController.text = text;
                          }}
                          ),
                  ),
                  Container(
                    height: 60,

                    //Add padding around textfield
                    padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: TextField(
                      controller: passController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        //Add th Hint text here.
contentPadding: EdgeInsets.only(top:5),
                        hintText: "Enter Your Name",
                        hintStyle: TextStyle(
                            fontFamily: "ProximaNova", color: Colors.black),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                      child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(15.0))),
                          onPressed: () {
                            if (emailController.text == "" &&
                                passController.text == "") {
                             Fluttertoast.showToast(
                                  msg: "Feilds Cant be empty",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 2,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            } else {
                              getLogin(emailController.text,passController.text);
                            }
                          },
                          textColor: Colors.white,
                          color: Colors.blue,
                          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    color: Colors.blue,
                                    padding: EdgeInsets.fromLTRB(10, 4, 4, 4),
                                    child: Text(
                                      'Login',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(4, 0, 10, 0),
                                    child: Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                      size: 25,
                                    ),
                                  ),
                                ],
                              )))),
                  Container(
                      child: FlatButton(
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                              fontFamily: "ProximaNova", color: Colors.blue),
                        ),
                        onPressed: () {
                         /* Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => forgot()),
                          );*/
                        },
                      ))
                ],
              ),
            ),
        );
  }
  dynamic productFromServer = new List();
  Future<void> getLogin(String email,String name) async {

    try {
      print("josdfjhu");
      final response = await http.post(
          LoginApi,body: {
          "phone":email,
        "name":name
      }
      );

      if (response.statusCode == 200) {
        print("true");
        final responseJson = json.decode(response.body);

        productFromServer = responseJson ;
        print(productFromServer);
        savedata();

        setState(() {
          isError = false;
          isLoading = false;
          print('setstate');
        });
      } else {
        setState(() {
          isError = true;
          isLoading = false;
        });
      }
    } catch (e) {
      print("uhdfuhdfuh");
      setState(() {
        isError = true;
        isLoading = false;
      });
    }
  }

  Future<void> savedata() async {
    SharedPreferences prefs =
    await SharedPreferences.getInstance();
    prefs.setString('email', productFromServer['data']['phone']);
   prefs.setString("intValue",productFromServer['data']['id']);
   prefs.setString("name",productFromServer['data']['name']);
    //prefs.setString('email', emailController.text);
    Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
  }
}


