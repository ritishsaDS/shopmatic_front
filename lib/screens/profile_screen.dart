import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loading_gifs/loading_gifs.dart';
import 'package:shopmatic_front/utils/common.dart';

import 'package:http/http.dart' as http;

import 'Home_screen.dart';
import 'bottom_bar.dart';
import 'edit_outlet.dart';
import 'story.dart';

class profile extends StatefulWidget {
  dynamic data;

  profile({Key key, this.data}) : super(key: key);

  profilestate createState() => profilestate();
}

class profilestate extends State<profile> {
  bool isError=false;
  bool isLoading = false;
  dynamic api;
  dynamic id="23";
  @override
  void initState() {
    getProfile();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: PreferredSize(

            preferredSize: Size.fromHeight(0.0), // here the desired height
            child:AppBar(
              backgroundColor: Colors.white,
            ),
          ),
          body: Stack(
              children: <Widget>[
                Container(
                  child: isLoading
                      ? Center(
                    child:Image.asset(cupertinoActivityIndicator)
                  )

                      : Stack(
                    children: <Widget>[
                      Container(

                        child: FadeInImage.assetNetwork(
                          image: productFromServer['data']['logo'],
                          placeholder: "assets/images/jyotimall.jpg",
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        child:ListView(children: <Widget>[
                          SizedBox(
                            height: 165,
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Container(
                                  height: 90,
                                  width: 110,
                                  child: FadeInImage.assetNetwork(
                                    image: productFromServer['data']['logo'],
                                    placeholder: "assets/images/jyotimall.jpg",
                                    height: 100,
                                    width: 140,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Container(
                                  margin: EdgeInsets.only(top: 10, left: 7),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 25,
                                      ),
                                     Container(

                                       child: Text(productFromServer['data']['outlet_name'],
                                           style: TextStyle(
                                               color: darkText,
                                               fontWeight: FontWeight.bold,
                                               fontSize: 14)),
                                     ),
                                      /*Container(
                                        width: 135,
                                        child: Text(
                                          productFromServer['data']['address'],
                                          style: TextStyle(
                                              color: lightText,
                                              fontSize: 12,
                                              fontFamily: 'proxima'),
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false,
                                          maxLines: 3,
                                        ),
                                      ),*/
                                     GestureDetector(
                                      child: Container(
                                         width: 135,
                                         child: Text(
                                           "Edit Your Store",
                                           style: TextStyle(
                                             color: lightText,
                                             fontWeight: FontWeight.bold,
                                             fontSize: 14,
                                             fontFamily: 'proxima',decoration: TextDecoration.underline,),
                                           overflow: TextOverflow.ellipsis,
                                           softWrap: false,
                                           maxLines: 3,
                                         ),
                                       ),onTap: (){
                                       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>editOutlet(
                                         data:id,name:productFromServer['data']['outlet_name'],address:productFromServer['data']['address']
                                       )));
                                     },
                                     )

                                    ],
                                  )),
                              Container(
                                  padding: EdgeInsets.only(bottom: 5, left: 5, right: 5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.white,
                                  ),
                                  child: Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                    size: 25,
                                  )),
                              Container(
                                  margin: EdgeInsets.only(left: 5),
                                  padding: EdgeInsets.only(bottom: 5, left: 5, right: 5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Colors.white,
                                  ),
                                  child: Icon(
                                    Icons.call,
                                    color: Colors.black,
                                    size: 25,
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
Row(
  children: getStorestories(),
),
                          SizedBox(
                            height: 5,
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
                                        fontSize: 14),
                                  ),
                                ),
                                Container(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text("10.00 am - 08.00 pm",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,fontFamily: 'Trajan Pro',
                                            decoration: TextDecoration.underline))),
                                Container(
                                    padding: EdgeInsets.only(left: 8.0),
                                    child: Text(productFromServer['data']['floor'],
                                        style:
                                        TextStyle(color: Colors.black, fontSize: 14))),
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
                                        fontSize: 14),
                                  ),
                                ),
                                Container(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      productFromServer['data']['short_desc'],)),
                                GestureDetector(
                                  child: Container(
                                    margin: EdgeInsets.all(10.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      color: Colors.black,
                                    ),
                                    width: MediaQuery.of(context).size.width,
                                    child: RaisedButton(
                                        color: Colors.black,
                                        child: Center(
                                          child: Text(
                                            "Delete Your Store",
                                            style: TextStyle(
                                                color: white, fontSize: 16),
                                          ),
                                        )),
                                  ),
                                  onTap: () {
deleteStore();
                                    }
                                ),
                              ]),
                        ]),
                      )
                    ],
                  ), )]),
      bottomNavigationBar: BottomTabs(1,true),
    );
  }
  dynamic productFromServer = new List();
  dynamic storyfromserver = new List();

  Future<void> getProfile() async {
    isLoading = true;
    try {
      final response = await http.post(
        profileApi ,body:{
          "outlet_id":id,
          "user_id":"32",
      }
      );
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        print(responseJson.toString() + "hello");

        productFromServer = responseJson;
       // getStories();

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


  Future<void> getStories() async {
    isLoading = true;
    try {
      print("josdfjhu");
      final response = await http.get(
     api =  StoriesApi +"23",
      );
      print("kmdfpjodfpjio"+api.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        print(responseJson.toString() + "hello");
if(response.statusCode==200){
  storyfromserver = responseJson['data'] ;
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
      print("sdujh"+categories.toString());
      productLists.add( GestureDetector(
        child:Container(
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
                            image:categories[i]['photo'],
                            placeholder: "assets/images/jyotimall.jpg",
                            fit: BoxFit.fill,
                            height: 90,
                          )))),
            )),onTap:(){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>MoreStories(
           data: widget.data
        )));      }
      ),);
    }
    return
      productLists;
  }

  Future<void> deleteStore() async {
    isLoading = true;
    try {
      print("josdfjhu");
      final response = await http.post(
          deletOutletapi ,body:{
          "outlet_id":"46"
      }

      );
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        print(responseJson.toString() + "hello");
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));

        setState(() {
          isError = false;
          isLoading = false;
          print('setstate');
        });

        setState(() {

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



