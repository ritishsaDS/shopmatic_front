import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loading_gifs/loading_gifs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopmatic_front/screens/Home_screen.dart';
import 'package:shopmatic_front/screens/store_products.dart';
import 'package:shopmatic_front/utils/common.dart';

class storescreen extends StatefulWidget {
  dynamic productData;

  storescreen(this.productData);

  storestate createState() => storestate();
}

class storestate extends State<storescreen> {
  bool isError = false;
  bool isLoading = false;

  String uid = "";
  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      GestureDetector(
        child: Container(
            margin: EdgeInsets.only(left: 12, right: 12, bottom: 18),
            child: Column(children: <Widget>[
              Row(children: <Widget>[
                GestureDetector(
                    child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12))),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: FadeInImage.assetNetwork(
                      image: widget.productData['logo'],
                      fit: BoxFit.cover,
                      placeholder: cupertinoActivityIndicator,
                      placeholderScale: 10,
                      height: 70.0,
                      width: 90.0,
                    ),
                  ),
                )),
                Container(
                    padding: EdgeInsets.only(left: 7),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(widget.productData['outlet_name'],
                            style: TextStyle(
                                color: darkText,
                                fontWeight: FontWeight.bold,
                                fontFamily: "futura",
                                fontSize: 14)),
                        Container(
                          width: 230,
                          padding: EdgeInsets.only(top: 2, bottom: 1),
                          child: widget.productData["short_desc"]==null?Text(
                            "A clothes Heaven for Gents",
                            style:
                                TextStyle(fontFamily: "proxima", fontSize: 13),
                            maxLines: 1,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          ):Text(
                            widget.productData['short_desc'],
                            style:
                                TextStyle(fontFamily: "proxima",color:lightText, fontSize: 13),
                            maxLines: 1,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 2, bottom: 1),
                          width: 200,
                          child: Text(
                            widget.productData['address'],
                            style: TextStyle(
                                color: lightestText,
                                fontSize: 12,
                                fontFamily: "proxima"),
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            maxLines: 2,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 3, bottom: 1),
                          width: 200,
                          child: Text(
                            "10:00 am - 9:00 pm",
                            style: TextStyle(
                                color: primaryColor,
                                fontSize: 11,
                                fontFamily: "proxima"),
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            maxLines: 2,
                          ),
                        ),
                      ],
                    )),
              ]),
            ])),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => storeProducts(
                        data: widget.productData['outlet_id'],
                      )));
        },
      ),
    ]);
  }
}
