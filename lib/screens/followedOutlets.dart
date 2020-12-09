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

class followed extends StatefulWidget{
  followedstate createState()=> followedstate();
}
class followedstate extends State<followed>{
  bool isError = false;
  bool isLoading = false;
  String id="";
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
          title: Text("Followers", style: TextStyle(color: darkText,fontFamily: "futura")),
        ),
        body: Stack(children: <Widget>[
      Container(
          child: isLoading
              ? Center(child: Image.asset(cupertinoActivityIndicator))
              :ListView(
          children: getfollowers()))]),
        bottomNavigationBar: BottomTabs(2, true),);
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
                              width:60,
                              height: 90,
                            )))),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      " " + categories[i]['outlet_name'],
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
                        ),
                        SizedBox( width:5,),
                    // Positioned(
                    //       right: 0,
                    //       top: 0,
                    //       child: GestureDetector(
                    //         child: PopupMenuButton(
                    //             itemBuilder: (context) {
                    //               return <PopupMenuItem>[
                    //                 PopupMenuItem(child:
                    //                categories[i]["outlet_group"] == "0"
                    //     ? GestureDetector(
                    //                   child: Text('Add In group'),
                    //                   onTap: () {
                    //                   //   setState(() {
                    //                   //     deleteAlbum(
                    //                   // categories[i]['story_id']);
                    //                   //   });
                    //                   },


                    //                 ):GestureDetector(
                    //                   child: Text('Remove From Group'),
                    //                   onTap: () {
                    //                   //   setState(() {
                    //                   //     deleteAlbum(
                    //                   // categories[i]['story_id']);
                    //                   //   });
                    //                   },


                    //                 )),
                    //                  PopupMenuItem(child:
                    //                 GestureDetector(
                    //                   child: Text('Remove'),
                    //                   onTap: () {
                    //                   remove(categories[i]['id']);
                    //                   },


                    //                 ))
                    //               ];
                    //             },
                    //             child: Icon(Icons.more_vert, color: darkText,

                    //             )
                    //         ), onTap: () {},
                    //       )

                    //   )
                    // 
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

  Future<void> remove(String aid) async {
    isLoading = true;
    try {
      final response = await http
          .post(removeFollower, body: {"user_id": aid, "outlet_id": "23"});
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        // Navigator.pushReplacement(
        //     context, MaterialPageRoute(builder: (context) => followers()));

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

  }
