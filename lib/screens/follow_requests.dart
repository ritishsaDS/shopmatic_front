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

class follow extends StatefulWidget{
  followstate createState()=> followstate();
}
class followstate extends State<follow>{
  bool isError = false;
  bool isLoading = false;
  String id="";
  @override
  void initState() {
    getFollowRequest();
    getemail();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
return Scaffold(
  appBar: AppBar(
    backgroundColor: white,
    iconTheme: IconThemeData(color: Colors.black),
    title: Text("Follow Requests",style: TextStyle(color: darkText),),
  ),
  body:Stack(children: <Widget>[
  Container(
  child: isLoading
  ? Center(child: Image.asset(cupertinoActivityIndicator))
        :getRequests().length==0?Container(
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
        Text("No Follow Requests Pending",style: TextStyle(color: darkText,fontFamily: "proxima",fontSize: 20),)
      ],
    ),
  ): ListView(
    children: getRequests(),
  ),
)]));
  }
  dynamic requestfromserver = new List();

  Future<void> getFollowRequest() async {
    isLoading = true;
    try {
      final response = await http.post(
followRequest, body:{
  "outlet_id":"23",
        "user_id":id
      }
      );
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        print(responseJson.toString() + "hello");

        requestfromserver = responseJson['data'] as List;

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
  Future<void> getemail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString('intValue');
    print("isdds"+id);

  }
  List<Widget> getRequests() {
    List<Widget> productLists = new List();
    List categories = requestfromserver ;
    for (int i = 0; i < categories.length; i++) {
      print("sdujh" + categories.toString());
      productLists.add(
        Container(
          margin: EdgeInsets.all(10.0),
          child:Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                      child: ClipOval(
                          child: CircleAvatar(
                              radius: 20,
                              backgroundColor: lightGrey,
                              child: Image.asset("",
                                /* image: categories[i]['photo'],
                            placeholder: cupertinoActivityIndicator,*/
                                fit: BoxFit.fill,
                                height: 90,
                              )))),
                  Text(categories[i]['name'],style: TextStyle(color: darkText,fontSize: 16,fontFamily: "proxima"),),
                  GestureDetector(
                      child:Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.0)
                              ,
                              border: Border.all(color: Colors.blue)
                          ),
                          padding: EdgeInsets.all(5.0),
                          child: Center(
                            child: Text("   "+"Cancel"+"   ",
                                style: TextStyle(
                                    color: Colors.blue, fontSize: 16)),
                          )),
                      onTap:(){


                        reject(categories[i]['id']);
                      }
                  ),
                  GestureDetector(
                      child:Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.0),
                            color: Colors.blue,
                          ),
                          padding: EdgeInsets.all(5.0),
                          child: Center(
                            child: Text("   "+"Accept"+"   ",
                                style: TextStyle(
                                    color: white, fontSize: 16)),
                          )),
                      onTap:(){
accept(categories[i]['id']);

                      }
                  ),

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
  Future<void> accept(String aid) async {
    isLoading = true;
    try {
      final response = await http.post(
          acceptRequest, body:{

        "id":aid
      }
      );
      print("jiodfok["+id);
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        print(responseJson.toString() + "hello");
Navigator.pushReplacement(context, MaterialPageRoute(
  builder: (context)=>follow()
));

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
  Future<void> reject(String aid) async {
    isLoading = true;
    try {
      final response = await http.post(
          rejectRequest, body:{

        "id":aid
      }
      );
      print("jiodfok["+id);
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        print(responseJson.toString() + "hello");
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context)=>follow()
        ));


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
