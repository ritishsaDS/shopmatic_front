import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_gifs/loading_gifs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopmatic_front/screens/personal_info.dart';
import 'package:shopmatic_front/screens/store_products.dart';
import 'package:shopmatic_front/screens/tile.dart';
import 'package:shopmatic_front/utils/common.dart';
import 'package:http/http.dart' as http;

import 'add_address.dart';
import 'user_address.dart';
import 'bottom_bar.dart';
import 'cart.dart';

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';


class userProfile extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<userProfile> {
  bool turnOnNotification = false;
  bool turnOnLocation = false;
  bool isError = false;
  bool isLoading = false;
  String id = "";

  @override
  void initState() {
    getSingleProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,

        iconTheme: new IconThemeData(color: Colors.black),

        title: Text("My Profile", style: TextStyle(color: darkText)),),
      body: Stack(children: <Widget>[
        Container(
            child: isLoading
                ? Center(child: Image.asset(cupertinoActivityIndicator))
                : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Stack(
                              children: <Widget>[
                                Container(
                                  height: 110.0,
                                  width: 110.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(60.0),
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 3.0,
                                          offset: Offset(0, 4.0),
                                          color: Colors.black38),
                                    ],
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        productFromServer['data']['image'],

                                      ),
                                      fit: BoxFit.fitWidth,

                                    ),
                                  ),

                                ),

                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          width: 15.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              productFromServer['data']['name'],
                              style: TextStyle(
                                  fontSize: 16.0, color: darkText
                              ),
                            ),
                            SizedBox(
                              height: 3.0,
                            ),
                            productFromServer['data']['email']==null?Container():
                            Text(
                              productFromServer['data']['email'],
                              style: TextStyle(color: Colors.grey),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            /*  SmallButton(btnText: "Edit"),*/
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      "Account",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Card(
                      elevation: 3.0,
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          children: <Widget>[
                            GestureDetector(
                              child: CustomListTile(
                                icon: Icons.location_on,
                                text: "Personal Details",
                              ), onTap: () {
                              Navigator.pushReplacement(context, MaterialPageRoute(
                                  builder: (context) =>
                                      EditProfilePage(
                                          username: productFromServer['data']['name'],
                                          userphone: productFromServer['data']['phone'],
                                          useremail: productFromServer['data']['email'],
                                          useradd:productFromServer['data']['address'],
                                      image:productFromServer['data']['image'])
                              ));
                            },
                            ),
                            Divider(
                              height: 10.0,
                              color: Colors.grey,
                            ),
                            CustomListTile(
                              icon: Icons.visibility,
                              text: "Review Your Purchases",
                            ),
                            Divider(
                              height: 10.0,
                              color: Colors.grey,
                            ),
                           GestureDetector(
                             child: CustomListTile(
                               icon: Icons.shopping_cart,
                               text: "Shipping",
                             ),onTap: (){
                               Navigator.push(context, MaterialPageRoute(builder: (context)=>alladdress()))
;                           },
                           ),
                            Divider(
                              height: 10.0,
                              color: Colors.grey,
                            ),
                            CustomListTile(
                              icon: Icons.payment,
                              text: "Payment",
                            ),
                            Divider(
                              height: 10.0,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      "Notifications",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Card(
                      elevation: 3.0,
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "App Notification",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                                Switch(
                                  value: turnOnNotification,
                                  onChanged: (bool value) {
                                    // print("The value: $value");
                                    setState(() {
                                      turnOnNotification = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                            Divider(
                              height: 10.0,
                              color: Colors.grey,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Location Tracking",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                                Switch(
                                  value: turnOnLocation,
                                  onChanged: (bool value) {
                                    // print("The value: $value");
                                    setState(() {
                                      turnOnLocation = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                            Divider(
                              height: 10.0,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),

                  ],
                ),
              ),
            ))
      ]),
    );
  }

  dynamic productFromServer = new List();

  Future<void> getSingleProduct() async {
    isLoading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString('intValue');
    try {
      final response =
      await http.post(getuserprofile, body: {"user_id": id});
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        print(responseJson.toString() + "hello");

        productFromServer = responseJson;

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
      // productFromServer = new List();

      // showToast('Something went wrong');
    }
  }
}


