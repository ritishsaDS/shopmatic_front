import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loading_gifs/loading_gifs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopmatic_front/utils/common.dart';

import 'package:http/http.dart' as http;

import 'Home_screen.dart';
import 'bottom_bar.dart';
import 'edit_outlet.dart';
import 'followers.dart';
import 'story.dart';

class profile extends StatefulWidget {
  dynamic data;

  profile({Key key, this.data}) : super(key: key);

  profilestate createState() => profilestate();
}
class profilestate extends State<profile> {
  bool isError = false;
  bool isLoading = true;
  dynamic api;
var arr=[];
List<String> splita=[];
  String id = "";
  var concatenate;
  @override
  void initState() {
    getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 1,
        backgroundColor: Colors.white,
        iconTheme: new IconThemeData(color: Colors.black),
          title:Stack(children: <Widget>[
        Container(
            child: isLoading
                ? Center(child: Image.asset(cupertinoActivityIndicator,height: 0,))
                :Container(child: Text(productFromServer['data']['outlet_name'], style: TextStyle(
                color: Colors.black,
                
                fontSize: 15,fontFamily: "futura")) ,)
        )])),
      
      body: Stack(children: <Widget>[
        Container(
            child: isLoading
                ? Center(child: Image.asset(cupertinoActivityIndicator))
                : Container(
              margin: EdgeInsets.only(left:10.0,right:10,top:10),
              child:SingleChildScrollView(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                          height: 90,
                          width: 90,
                          child: ClipOval(
                            child: FadeInImage.assetNetwork(
                              image: productFromServer['data']['logo'],
                              placeholder: cupertinoActivityIndicator,
                              height: 80,
                              width: 70,
                              fit: BoxFit.cover,
                            ),
                          )),

                      Column(
                          children: <Widget>[

                            Container(
                                child: Text("219",
                                    style: TextStyle(
                                        color: darkText,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17))),
                            Container(
                                padding: EdgeInsets.all(5.0),
                                child: Text("Joined",
                                    style: TextStyle(fontFamily: "proxima",color: lightText, fontSize: 15)))
                          ]),
                      Column(children: <Widget>[
                        Container(
                            child: Text(productFromServer['products'],
                                style: TextStyle(
                                    color: darkText,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17))),
                        Container(
                            padding: EdgeInsets.all(5.0),
                            child: Text("Posts",
                                style: TextStyle(fontFamily: "proxima",color: lightText, fontSize: 15)))
                      ]),
                      Column(children: <Widget>[
                      GestureDetector(
                        child:  Container(
                            child: Text(
                                "20",
                                style: TextStyle(
                                    color: darkText,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17))),
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>followers()));
                                    },
                      ),
                        Container(
                            padding: EdgeInsets.all(5.0),
                            child: Text("Followers",
                                style: TextStyle(fontFamily: "proxima",color: lightText, fontSize: 15)))
                      ])
                    ],
                  ),
                  Container(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 10),
                          Container(
                        child: Text(productFromServer['data']['outlet_name'],
                            style: TextStyle(
                                color: darkText,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,fontFamily: "futura"))),
                          Container(
                              child: Text(productFromServer['data']['floor'],
                                  style: TextStyle(fontFamily: "proxima",color: lightestText, fontSize: 14,
                                  ))),
                          Container(
                              child: Text(productFromServer['data']['address'],
                                  style: TextStyle(fontFamily: "proxima",color: lightestText, fontSize: 14))),
                          Container(
                              child: Text(productFromServer['data']['phone'],
                                  style: TextStyle(fontFamily: "proxima",color: lightestText, fontSize: 14))),
                          Container(
                              child: Text(productFromServer['data']['city'],
                                  style: TextStyle(fontFamily: "proxima",color: lightestText, fontSize: 14))),
                        ]),
                  ),
                             GestureDetector(
                              child: Container(
                                margin: EdgeInsets.only(top:10,bottom:10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6.0),
                                    border: Border.all(color: lightestText),
                                  ),
                                  padding: EdgeInsets.all(5.0),
                                  child: Center(
                                    child: Text("Edit Store",
                                        style: TextStyle(
                                            color: lightestText, fontSize: 16)),
                                  )),
                                onTap: () {
                                   //getfollowers();
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => editOutlet(
                                              data: id,
                                              name: productFromServer['data']
                                                  ['outlet_name'],
                                              address: productFromServer['data']
                                                  ['address'])));
                                },
                              ),
                           Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(8.0),
                          width: MediaQuery.of(context).size.width,
                          color: lightGrey,
                          child: Text(
                            "Info",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: "futura",
                                fontSize: 14),
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Monday :"+splita[0]+"\n"+"Tuesday :"+splita[1]+"\n"+"Wednesday :"+splita[2]+"\n"+"Thursday :"+splita[3]+"\n"+"Friday :"+splita[4]+"\n"+"Saturday :"+splita[5]+"\n"+"Sunday :"+splita[6],
                                style: TextStyle(
                                    color: lightestText,
                                    fontSize: 14,
                                     fontWeight: FontWeight.bold,
                                fontFamily: "futura",
                                    ))),
                     
                        Container(
                          margin: EdgeInsets.only(top: 8),
                          padding: EdgeInsets.all(8.0),
                          width: MediaQuery.of(context).size.width,
                          color: lightGrey,
                          child: Text(
                            "About",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: "futura",
                                fontSize: 14),
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              productFromServer['data']['short_desc'],
                              style: TextStyle(
                                color: lightText,
                                fontFamily: "proxima",
                                fontSize: 14),
                          
                            ))
                            ,
                            GestureDetector(
     child: Container(
       width: MediaQuery.of(context).size.width,
margin: EdgeInsets.all(10.0),
decoration: BoxDecoration(
  borderRadius: BorderRadius.circular(6.0),
  color: Colors.black
),
child: RaisedButton(
   color: Colors.black,
  child: Text("Delete Your Store",style: TextStyle(color: white),),
),
     ),onTap: ()=>deleteStore(),

   )        

                            ])
                             ],
              ))),

              )                        
                                     ]),

                
      bottomNavigationBar: BottomTabs(1, true),
    );
  }

  dynamic productFromServer = new List();
  dynamic storyfromserver = new List();

  Future<void> getProfile() async {
    isLoading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    id = prefs.getString('intValue');
    print("isdds" + id);
    try {
      final response = await http.post(profileApi, body: {
        "outlet_id": "23",
        "user_id": id,
      });
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        print(responseJson.toString() + "hello");

        productFromServer = responseJson;
        

        //arr=productFromServer['data']['timings'];
       
        // getStories();

        //print('jhifuh' + productFromServer.toString()); //;
   // displays 'onetwothree'

   splita = productFromServer['data']['timings'].split(',');
    print(splita[0]);
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
     print(e);
      setState(() {
        isError = true;
        isLoading = false;
      });
      // productFromServer = new List();

      // showToast('Something went wrong');
    }
  }

  Future<void> getStories() async {
    isLoading = true;
    try {
      print("josdfjhu");
      final response = await http.get(
        api = StoriesApi + "23",
      );
      print("kmdfpjodfpjio" + api.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        print(responseJson.toString() + "hello");
        if (response.statusCode == 200) {
          storyfromserver = responseJson['data'];
          print('jhifuh' + storyfromserver.toString());
        }
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

  List<Widget> getStorestories() {
    List<Widget> productLists = new List();
    List categories = storyfromserver as List;
    for (int i = 0; i < categories.length; i++) {
      print("sdujh" + categories.toString());
      productLists.add(
        GestureDetector(
            child: Container(
                margin: EdgeInsets.only(top: 5, left: 5, right: 5),
                height: 70,
                width: 60,
                child: Padding(
                  padding: EdgeInsets.only(top: 4.0, bottom: 5.0),
                  child: Container(
                      child: ClipOval(
                          child: CircleAvatar(
                              radius: 35,
                              backgroundColor: lightGrey,
                              child: FadeInImage.assetNetwork(
                                image: categories[i]['photo'],
                                placeholder: "assets/images/jyotimall.jpg",
                                fit: BoxFit.fill,
                                height: 90,
                              )))),
                )),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MoreStories(data: widget.data)));
            }),
      );
    }
    return productLists;
  }

  Future<void> deleteStore() async {
    isLoading = true;
    try {
      print("josdfjhu");
      final response =
          await http.post(deletOutletapi, body: {"outlet_id": "46"});
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        print(responseJson.toString() + "hello");
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()));

        setState(() {
          isError = false;
          isLoading = false;
          print('setstate');
        });

        setState(() {});
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
//  List<Widget> getfollowers() {
//     List categories = splita ;
//     for (int i = 0; i < categories.length; i++) {
//       print("sdujh" + categories[1].toString());}}
}
