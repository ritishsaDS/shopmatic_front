import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_gifs/loading_gifs.dart';
import 'package:shopmatic_front/utils/common.dart';
import 'package:http/http.dart' as http;
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'bottom_bar.dart';
import 'cart.dart';

class InstaProfilePage extends StatefulWidget {
  @override
  _InstaProfilePageState createState() => _InstaProfilePageState();
}

class _InstaProfilePageState extends State<InstaProfilePage> {
  String selected = "first";
  bool view = true;
  bool viewVisible = false;
  bool viewVisibletext = false;
  bool viewPincode = false;
  int Quantity = 1;
  String num;
  TextEditingController textEditingController = new TextEditingController();
  int badgeData = 0;
  bool ischanged = false;
  String query = "";

  bool isError = false;
  bool isLoading = false;
  PageController _pageController = PageController(
    initialPage: 0,
  );
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
            child: Column(
      children: <Widget>[
        Container(
          height: 300,
          child:Stack(
          children: <Widget>[
            Positioned(
                height: 250,
                top: 0,
                child: Container(
                  height: 400,
                  alignment: Alignment.center, // This is needed
                  child: Image.asset(
                    "assets/images/super.png",
                    fit: BoxFit.cover,
                    height: 400,
                    width: 400,
                  ),
                )),
            Positioned(
              top: 200.0,
              left: 130.0,
              child: Container(
                  height: 90,
                  width: 90,
                  child: ClipOval(
                    child: Image.asset(
                      "assets/images/syore.jpg",
                      height: 80,
                      width: 70,
                      fit: BoxFit.cover,
                    ),
                  )),
            ),
          ],
        ),


        ),
        Divider(
          height: 10,
          thickness: 1.5,
          color: dividerColor,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
                      SizedBox(width: 30,),
                      Column(children: <Widget>[
                        Container(
                            child: Text("19",
                                style: TextStyle(
                                    color: darkText,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17))),
                        Container(
                            padding: EdgeInsets.all(5.0),
                            child: Text("Posts",
                                style: TextStyle(fontFamily: "proxima",color: lightText, fontSize: 15)))
                      ]),
                      SizedBox(width: 30,),
                      Column(children: <Widget>[
                        Container(
                            child: Text(
                              "40",
                                style: TextStyle(
                                    color: darkText,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17))),
                        Container(
                            padding: EdgeInsets.all(5.0),
                            child: Text("Followers",
                                style: TextStyle(fontFamily: "proxima",color: lightText, fontSize: 15)))
                      ])
      
          ],
        ),
         Divider(
          height: 10,
          thickness: 1.5,
          color: dividerColor,
        ),
        ],
    )));
  }

  dynamic productFromServer = new List();

  Future<void> getSingleProduct() async {
    isLoading = true;
    try {
      final response = await http.post(SingleproductAPi, body: {"id": "8"});
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

  List<Widget> createBannerSlider() {
    List<Widget> bannerWidgetList = new List();
    try {
      List bannerList = productFromServer as List;
      for (int i = 0; i < bannerList.length; i++) {
        bannerWidgetList.add(
          FadeInImage.assetNetwork(
            image: bannerList[i],
            placeholder: cupertinoActivityIndicator,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
        );
      }
    } catch (e) {}

    return bannerWidgetList;
  }
}
