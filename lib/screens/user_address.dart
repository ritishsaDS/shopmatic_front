import 'dart:io';
import 'dart:convert';
import 'package:badges/badges.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_gifs/loading_gifs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopmatic_front/screens/personal_info.dart';
import 'package:shopmatic_front/screens/store_products.dart';
import 'package:shopmatic_front/screens/tile.dart';
import 'package:shopmatic_front/screens/userprofile.dart';
import 'package:shopmatic_front/utils/common.dart';
import 'package:http/http.dart' as http;

import 'add_address.dart';
import 'bottom_bar.dart';
import 'cart.dart';

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

import 'edit_address.dart';
class alladdress extends StatefulWidget{

  addressstate createState()=>addressstate();
}
class addressstate extends State<alladdress>{
  bool isError = false;
  bool isLoading = false;
  String id = "";
  @override
  void initState() {
    getAlladresses();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
return Scaffold(
  appBar: AppBar(
    backgroundColor: white,

    iconTheme: new IconThemeData(color: Colors.black),

    title: Text("Addresses", style: TextStyle(color: darkText)), actions: [
    Container(
      margin: EdgeInsets.only(right:15),
      child: GestureDetector(
        child: Icon(Icons.playlist_add),onTap:(){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>addaddress()));
      } ,
      ),
    )
  ],),

  body: Stack(
      children: <Widget>[
  Container(
  child: isLoading
  ? Center(
      child:Image.asset(cupertinoActivityIndicator)
)

        :geAddress().length==0?Container( child: Column(
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
      Text("sorry..\n No addresses added by you",style: TextStyle(color: darkText,fontFamily: "proxima",fontSize: 20),),
      Center(
        child: GestureDetector(
            child:Container(
                width: 200,
                margin: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.0)
                    ,
                    border: Border.all(color: Colors.blue)
                ),
                padding: EdgeInsets.all(5.0),
                child: Center(
                  child: Text("   "+"Add Address"+"   ",
                      style: TextStyle(
                          color: Colors.blue, fontSize: 16)),
                )),
            onTap:(){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>addaddress()));

            }
        ),
      )
    ],
  ),):ListView(
    children:geAddress(),
  ))]),
);
  }
  dynamic productFromServer = new List();

  Future<void> getAlladresses() async {
    isLoading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString('intValue');
    try {
      final response = await http.post(useraddressesapi, body: {"user_id": id});
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        print(responseJson.toString() + "hello");

        productFromServer = responseJson['data'] as List;

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
  List<Widget> geAddress() {
    List<Widget> productLists = new List();
    List products = productFromServer as List;

    for (int i = 0; i < products.length; i++) {
      productLists.add(GestureDetector(
        /*onTap: title == "Select Address" ? addAddress : null,*/
        child: Container(
            margin: EdgeInsets.all(10),
            child: Card(
              child: Container(
                  padding: EdgeInsets.all(10),
                  child: Stack(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.location_on,
                                color: primaryColor,
                                size: 15,
                              ),
                              SizedBox(width: 3),
                              Text(products[i]['pin_code'],
                                  style: TextStyle(
                                    color: primaryColor,
                                  )),
                            ],
                          ),
                          SizedBox(height: 6),
                          Text(products[i]['name'] + ' ' /*+ products[i]['lastname']*/,
                              style: TextStyle(
                                  color: darkText,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16)),
                          SizedBox(height: 3),
                          Text("Address: " + products[i]['address'],
                              style: TextStyle(
                                  color: lightestText,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14)),
                          SizedBox(height: 3),
                          Text(products[i]['city'],
                              style: TextStyle(
                                  color: lightestText,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14)),
                          SizedBox(height: 3),
                          Text(products[i]['state'],
                              style: TextStyle(
                                  color: lightestText,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14)),
                        ],
                      ),
                      Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            height: 30,
                            width: 30,
                            child: IconButton(
                              onPressed: () {
                                deleteDialog(products[i]['id']);
                              },
                              icon: Icon(
                                Icons.delete,
                                size: 20,
                              ),
                              color: transparentREd,
                            ),
                          ))
                    ],
                  )),
            )),onTap: (){
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>editaddress(name:products[i]['name'],id:products[i]['id'],phone:products[i]['phone'],pin:products[i]['pin_code'],address:products[i]['address'],city:products[i]['city'],state:products[i]['state'])));
      },
      ));
    }
    return productLists;
  }
  void deleteDialog(product) async {
    final value = await showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(
              'Delete this address?',
              style: TextStyle(color: darkText, fontWeight: FontWeight.bold),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'Yes',
                  style: TextStyle(color: darkText),
                ),
                onPressed: (){

                deleterequest(product);
                }/*this.deleteRequest*/,

              ),
              FlatButton(
                child: Text(
                  'No',
                  style: TextStyle(color: primaryColor),
                ),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
            ],
          );
        });
  }

  Future<void> deleterequest(product) async {
    isLoading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString('intValue');
    try {
      final response = await http.post(deleteaddressapi, body: {"id": product});
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        print(responseJson.toString() + "hello");

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>alladdress()));

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
