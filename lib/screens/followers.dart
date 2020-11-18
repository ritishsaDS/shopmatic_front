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


class followers extends StatefulWidget{
  followstate createState()=> followstate();
}

class followstate extends State<followers>{
  bool isError = false;
  bool isLoading = false;
  String selected = "first";
  String group = "";

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
    backgroundColor: white,

    iconTheme: new IconThemeData(color: Colors.black),

    title: Text("Followers", style: TextStyle(color: darkText)),
  ),
  body:ListView(
    children:getfollowers() ,
  )
);
  }
  List<Widget> getfollowers() {
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
                   Container(
                     width: 100,
                     child: Text(categories[i]['name'],style: TextStyle(color: darkText,fontSize: 16,fontFamily: "proxima",),overflow: TextOverflow.ellipsis,),
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
                        categories[i]["outlet_group"]=="0"?
                        GestureDetector(
                            child:Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6.0),
                                  color: Colors.blue,
                                ),
                                padding: EdgeInsets.all(5.0),
                                child: Center(
                                  child: Text(""+"Add in Group"+"",
                                      style: TextStyle(
                                          color: white, fontSize: 16)),
                                )),
                            onTap:(){
                              // accept(categories[i]['id']);
                              _showDialog(categories[i]['id']);
                            }
                        ):GestureDetector(
                            child:Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6.0),
                                  color: Colors.blue,
                                ),
                                padding: EdgeInsets.all(5.0),


                                  child:categories[i]["outlet_group"]=="1"?
                                  Text(" Added in Silver Group",
                                      style: TextStyle(
                                          color: white, fontSize: 12)):categories[i]["outlet_group"]=="2"? Text(" Added in Gold Group",
                                      style: TextStyle(
                                          color: white, fontSize: 12)): Text(" Added in Plantinum Group",
                                      style: TextStyle(
                                          color: white, fontSize: 12)),
                                ),

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
          )
      );

    }
    return productLists;
  }
  dynamic requestfromserver = new List();

  Future<void> getFollowersapi() async {
    isLoading = true;
    try {
      final response = await http.post(
          followersApi, body:{
        "outlet_id":"23",
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
  Future<void> remove(String aid) async {
    isLoading = true;
    try {
      final response = await http.post(
          removeFollower, body:{

        "user_id":aid,
        "outlet_id":"23"
      }
      );
     print("jiodfok["+aid);
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        print(responseJson.toString() + "hello");
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context)=>followers()
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
  _showDialog(categori) async {
    await showDialog<String>(
      context: context,
      child:  AlertDialog(
          contentPadding:  EdgeInsets.all(16.0),
          content:Container(
            height: 150,

            child: Column(
              children: <Widget>[
                Text("In which Group you want to add this user "),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[


                  GestureDetector(
                    child:   Container(
                      margin: EdgeInsets.only(right: 10),
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.0),
                          color: white,
                        border: Border.all(
                          color: selected == 'g'
                              ? Colors.blue
                              : lightGrey,)),
                        child: Center(
                          child: Text(
                            "     Gold     ",
                            style: TextStyle(
                                fontFamily: "proxima",
                                color: darkText,
                                fontSize: 16),
                          )),
                    ),onTap: (){
                    setState(() {
                      selected="g";
group="2";
                    });
                  },
                  ),
                    GestureDetector(
                      child:   Container(
                        margin: EdgeInsets.only(right: 10),
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6.0),
                            color: white,
                            border: Border.all(color:  selected == 's'
                            ? Colors.blue
                                : lightGrey)),
                        child: Center(
                            child: Text(
                              "     Silver     ",
                              style: TextStyle(
                                  fontFamily: "proxima",
                                  color: darkText,
                                  fontSize: 16),
                            )),
                      ),onTap: (){
                        setState(() {
                          selected="s";
                        });
                      group="1";


                    },
                    ),

                  ],
                ),
                GestureDetector(
                  child:   Container(
                    margin: EdgeInsets.only(right: 10,top:10),
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        color: white,
                        border: Border.all( color: selected == 'p'
                            ? Colors.blue
                            : lightGrey)),
                    child: Center(
                        child: Text(
                          "Plantinum",
                          style: TextStyle(
                              fontFamily: "proxima",
                              color: darkText,
                              fontSize: 16),
                        )),
                  ),onTap: (){
                    setState(() {
                      selected='p';
                    });
                  group="3";

                },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
                child: const Text('Cancel'),
                onPressed: () => Navigator.pop(context)

                ),
            new FlatButton(
                child: const Text('Done'),
                onPressed: () {

                  addtoGroup(group,categori);
                } /*getoutletStatus(reason.text)*/
            )





          ],
    ));
  }

  Future<void> addtoGroup(String s,String id)  async {
    isLoading = true;
    try {
      final response = await http.post(
          addtoGroupApi, body:{
        "user_id":id,
        "group_value":s,
        "outlet_id":"23",

      }
      );
      print("jiodfok["+s);
      print("jiodfok["+id);
      print(response.statusCode);
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        print(responseJson.toString() + "hello");
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context)=>followers()
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
