import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_gifs/loading_gifs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopmatic_front/screens/bottom_bar.dart';
import 'package:shopmatic_front/screens/story.dart';
import 'package:shopmatic_front/screens/tab2.dart';
import 'package:shopmatic_front/utils/common.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:http/http.dart' as http;

class followed extends StatefulWidget {
  followedstate createState() => followedstate();
}

class followedstate extends State<followed> {
  bool isError = false;
  bool isLoading = false;
  String id = "";
  String outlet_id = "";
  String image="";
  String name="";
  @override
  void initState() {
    getFollowersapi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: white,
        iconTheme: new IconThemeData(color: Colors.black),
        title: Text("Followed Outlets",
            style: TextStyle(color: darkText, fontFamily: "futura")),
      ),
      body: Stack(children: <Widget>[
        Container(
            child: isLoading
                ? Center(child: Image.asset(cupertinoActivityIndicator))
                : ListView(children: getfollowers()))
      ]),
      bottomNavigationBar: BottomTabs(2, true),
    );
  }

  List<Widget> getfollowers() {
    List<Widget> productLists = new List();
    List categories = requestfromserver;
    for (int i = 0; i < categories.length; i++) {
      productLists.add(Container(
        margin: EdgeInsets.only(right: 10.0, left: 10.0, top: 5),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                    child: ClipOval(
                        child: CircleAvatar(
                            radius: 30,
                            backgroundColor: lightGrey,
                            child: FadeInImage.assetNetwork(
                              image: categories[i]['logo'],
                              placeholder: cupertinoActivityIndicator,
                              fit: BoxFit.cover,
                              width: 60,
                              height: 90,
                            )))),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "  " + categories[i]['outlet_name'],
                      style: TextStyle(
                        color: darkText,
                        fontSize: 16,
                        fontFamily: "proxima",
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "  " + categories[i]['address'],
                      style: TextStyle(
                        color: lightestText,
                        fontSize: 13,
                        fontFamily: "proxima",
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.0),
                              border: Border.all(color: Colors.blue)),
                          padding: EdgeInsets.all(5.0),
                          child: Center(
                            child: Text("" + "Following" + "",
                                style: TextStyle(
                                    color: Colors.blue, fontSize: 16)),
                          )),
                      onTap: () {
                        outlet_id = categories[i]['outlet_id'];
                        image=categories[i]['logo'];
                        name=categories[i]['outlet_name'];
                      unfollowDialog();
                         },
                    ),
                    SizedBox(
                      width: 5,
                    ),
                  ],
                )
              ],
            ),
            Divider(
              height: 10,
              thickness: 1.5,
              color: dividerColor,
            )
          ],
        ),
      ));
    }
    return productLists;
  }

  dynamic requestfromserver = new List();

  Future<void> getFollowersapi() async {
    isLoading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    id = prefs.getString('intValue');
    try {
      final response = await http.post(outletFollowedbyUser, body: {
        "user_id": id,
      });
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);

        requestfromserver = responseJson['data'] as List;

        setState(() {
          isError = false;
          isLoading = false;
        });
      } else {
        setState(() {
          isError = true;
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isError = true;
        isLoading = false;
      });
    }
  }
unfollowDialog() async {
                          await showDialog<String>(
                            context: context,
                            child: Container(
                              padding: EdgeInsets.only(left: 10),
                              height: 100,
                              child: new AlertDialog(
                                contentPadding: EdgeInsets.all(16.0),
                                content: Container(
                                  height: 250,
                                  child: Column(
                                    children: <Widget>[
                                      Center(
                                        child: Container(
                                            margin: EdgeInsets.only(
                                                top: 5, left: 5, right: 5),
                                            height: 100,
                                            width: 90,
                                            child: ClipOval(
                                              child: FadeInImage.assetNetwork(
                                                image: image,
                                                placeholder:
                                                    cupertinoActivityIndicator,
                                                height: 90,
                                                width: 70,
                                                fit: BoxFit.cover,
                                              ),
                                            )),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        name,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                      FlatButton(
                                          child: Text(
                                            'Unfollow',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          onPressed: () => unfollow()),
                                      Divider(
                                        thickness: 1.5,
                                        color: dividerColor,
                                        height: 3,
                                      ),
                                      FlatButton(
                                          child: const Text(
                                            'Cancel',
                                            style: TextStyle(fontSize: 16),
                                          ),
                                          onPressed: () =>
                                              Navigator.pop(context)),
                                      Divider(
                                        thickness: 1.5,
                                        color: dividerColor,
                                        height: 3,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                     
  Future<void> unfollow() async {
    isLoading = true;
    try {
      final response = await http
          .post(unfollowOutlet, body: {"user_id": id, "outlet_id": outlet_id});
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (ctx) => followed()));

        setState(() {
          isError = false;
          isLoading = false;
        });
      } else {
        setState(() {
          isError = true;
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isError = true;
        isLoading = false;
      });
      // productFromServer = new List();

      // showToast('Something went wrong');
    }
  }
}
