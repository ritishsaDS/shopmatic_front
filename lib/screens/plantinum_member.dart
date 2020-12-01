import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_gifs/loading_gifs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopmatic_front/screens/story.dart';
import 'package:shopmatic_front/screens/tab2.dart';
import 'package:shopmatic_front/utils/common.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:http/http.dart' as http;
class plantinum extends StatefulWidget{
  plantinumstate createState() => plantinumstate();
}
class plantinumstate extends State<plantinum>{
  @override
  void initState() {
    getgroupmember();
    super.initState();
  }
  bool isError = false;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Container(
          child: isLoading
              ? Center(child: Image.asset(cupertinoActivityIndicator))
              : getmember().length==0?Container(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 100,
                ),
                Center(
                  child: Image.asset("assets/images/folloe.png"),
                ),
                SizedBox(
                  height: 10,
                ),
                Text("No Memeber add in this group",style: TextStyle(color: darkText,fontFamily: "proxima",fontSize: 20),)
              ],
            ),
          ):Container(
            child: ListView(
                children: getmember()
            ),
          ),
        )
    );  }
  dynamic followersfromserver = new List();

  Future<void> getgroupmember() async {
    isLoading = true;
    try {
      final response = await http.post(
          userbyGroup, body:{
        "outlet_id":"23",
        "group_value":"3",
      }
      );
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        print(responseJson.toString() + "hello");

        followersfromserver = responseJson['data'] as List;

        //print('jhifuh' + productFromServer.toString()); //;

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

  List<Widget> getmember() {
    List<Widget> productLists = new List();
    List categories = followersfromserver ;
    for (int i = 0; i < categories.length; i++) {
      print("sdujh" + categories.toString());
      productLists.add(
          Container(
            margin: EdgeInsets.all(10.0),
            child:Column(
              children: <Widget>[
                  Row(
              children: <Widget>[
                Container(
                    child: ClipOval(
                        child: CircleAvatar(
                            radius: 30,
                            backgroundColor: lightGrey,
                            child: FadeInImage.assetNetwork(
                          
                               image: categories[i]['image'],
                            placeholder: cupertinoActivityIndicator,
                              fit: BoxFit.fill,
                              height: 90,
                            )))),
                    Expanded(
                                          child: Container(
                        
                        child: Text(categories[i]['name'],style: TextStyle(color: darkText,fontSize: 16,fontFamily: "proxima",),overflow: TextOverflow.ellipsis,),
                      ),
                    ),
                    SizedBox(width: 40,),
                    Column(
                      children: <Widget>[
                        GestureDetector(
                            child:Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6.0)
                                    ,
                                    border: Border.all(color: Colors.blue)
                                ),
                                padding: EdgeInsets.all(5.0),
                                child: Center(
                                  child: Text(""+"Remove"+"",
                                      style: TextStyle(
                                          color: Colors.blue, fontSize: 16)),
                                )),
                            onTap:(){

                               remove(categories[i]['id']);

                            }
                        ),
                        SizedBox(height: 10,),

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
          )
      );

    }
    return productLists;
  }

  Future<void> remove(String aid) async {
    isLoading = true;
    try {
      final response = await http.post(
          removefromGroup, body:{

        "user_id":aid,
        "outlet_id":"23"
      }
      );
      print("jiodfok["+aid);
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        print(responseJson.toString() + "hello");
        /* Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context)=>followers()*//*
        ));*/


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
