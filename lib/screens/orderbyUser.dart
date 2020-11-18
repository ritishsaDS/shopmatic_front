import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_gifs/loading_gifs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopmatic_front/screens/store_products.dart';
import 'package:shopmatic_front/utils/common.dart';
import 'package:http/http.dart' as http;

import 'bottom_bar.dart';
import 'cart.dart';

class userorder extends StatefulWidget{
  userorderstate createState()=>userorderstate();
}

class userorderstate extends State<userorder>{
  bool isError = false;
  bool isLoading = false;
String uid="";
  @override
  void initState() {
    getUserorder();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body:Stack(children: <Widget>[
      Container(
      child: isLoading
      ? Center(child: Image.asset(cupertinoActivityIndicator))
        :getorder().length==0?Container(
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
    Text("No Orders Available",style: TextStyle(color: darkText,fontFamily: "proxima",fontSize: 20),)
    ],
    ),
    ):  ListView(
        children: getorder(),
      ))]),
    );
  }

  List<Widget> getorder() {
    List<Widget> productLists = new List();
    List categories = productFromServer as List;
    for (int i = 0; i < categories.length; i++) {
        productLists.add(
          GestureDetector(
              child:     Container(
                  child: ListTile(
                    title: Text(categories[i]['name'],style: TextStyle(fontSize: 16,color: darkText),),
                    leading:  ClipRRect(
                        borderRadius: BorderRadius.circular(6.0),
                        child: FadeInImage.assetNetwork(
                          image: categories[i]['product_image'],
                          placeholder: cupertinoActivityIndicator,
                          height: 90,
                          width: 90,
                          fit: BoxFit.cover,
                        )),
                    subtitle:Text(categories[i]['name'],style: TextStyle(fontFamily: "proxima",fontSize: 14,color:lightestText)),
                    trailing: Container(
                      child: Row(

                        mainAxisSize: MainAxisSize.min,

                        children: <Widget>[
                          Container(
                            width: 30,
                            padding: EdgeInsets.only(left: 10),
                            child: CircleAvatar(

                              backgroundColor: Colors.grey[400],
                              child: Icon(Icons.share,size: 15,color: Colors.grey[100],),
                            ),
                          ),
                          Container(
                            width: 30,
                            padding: EdgeInsets.only(left: 10),
                            child: CircleAvatar(

                              backgroundColor: Colors.grey[400],
                              child: Icon(Icons.add,size: 15,color: Colors.grey[100],),
                            ),
                          )
                        ],
                      ),
                    ),
                  )

              )
              ,
              onTap: () {
                /*Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MoreStories(data: widget.data,id:id)));*/
              }),

        );



    }
    return productLists;
  }

  dynamic productFromServer = new List();

  Future<void> getUserorder() async {
    isLoading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uid = prefs.getString('intValue');
    try {
      final response =
      await http.post(userorderapi, body: {"user_id": uid});
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        print(responseJson.toString() + "hello");

        productFromServer = responseJson['data'];

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
