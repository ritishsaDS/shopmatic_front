import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:loading_gifs/loading_gifs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopmatic_front/screens/store_products.dart';
import 'package:shopmatic_front/utils/common.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:http/http.dart' as http;

import '../widget/store.dart';
import 'Login_screen.dart';
import 'bottom_bar.dart';
import 'profile_screen.dart';

class Home extends StatefulWidget {
  Homestate createState() => Homestate();
}

class Homestate extends State<Home> {
  bool isError = false;

  String email="";
  String name="";

  @override
  void initState() {
    getStore();
    getemail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,

        appBar: AppBar(
          elevation: 2,
          backgroundColor: Colors.white,
          iconTheme: new IconThemeData(color: Colors.pink),
          title: const Text('PROXSMART DEALS', style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14)),
          actions: <Widget>[
GestureDetector(
  child:            Container(padding: EdgeInsets.only(right: 10),
      child: Icon(Icons.add)),onTap: ()async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('email');
  Navigator.pushReplacement(context,
      MaterialPageRoute(builder: (BuildContext ctx) => Login()));
},

)
          ],
        ),
        body:Stack(
            children: <Widget>[
        Container(
        child: isLoading
        ? Center(
            child:Image.asset(cupertinoActivityIndicator)
      )

          : ListView(
          children:<Widget> [
            Container(
              height: 35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: lightGrey
              ),
              margin: EdgeInsets.all(12.0),
              child: TextField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top:1),
                    hintText: 'What are you looking for?',
                    prefixIcon: IconButton(
                        icon: Icon(
                          Icons.search,
                          color: lightestText,
                          size: 20,
                        ),
                        onPressed: () {

                        }),


                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height*0.78,
              child: ListView(
                  children: createProduct()
              ),
            )
          ],
        ))]),

        bottomNavigationBar: BottomTabs(1,true),
      ),
      onWillPop: () {
        return showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Confirm Exit"),
                content: Text("Are you sure you want to exit?"),
                actions: <Widget>[
                  FlatButton(
                    child: Text("YES"),
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                  ),
                  FlatButton(
                    child: Text("NO"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            }
        );
      },
    );
  }

  bool isLoading = false;
  dynamic productFromServer = new List();

  Future<void> getStore() async {
    isLoading = true;
    try {
      final response = await http.get(
        storeListingApi,
      );
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);

        productFromServer = responseJson['data'] as List;

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

  List<Widget> createProduct() {
    List<Widget> productList = new List();
    for (int i = 0; i < productFromServer.length; i++) {
      productList.add(storescreen(productFromServer[i]));
    }

    /* try {


    } on Exception catch (_) {

      print('never reached');
    }
*/
    return
    productList;
  }

  Future<void> getemail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
     email = prefs.getString('email');
    var intValue = prefs.getString('intValue');
     name = prefs.getString('name');
  }
}

class Data {
  String name;
  String text;
  String text1;

  Data({this.name, this.text, this.text1});
}
