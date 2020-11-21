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
            margin: EdgeInsets.only(left: 12, right: 12),
            child: Column(children: <Widget>[
              Row(children: <Widget>[
                              Container(
                    padding: EdgeInsets.only(left: 10),
                   
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(widget.productData['outlet_name'],
                            style: TextStyle(
                                color: darkText,
                                fontWeight: FontWeight.normal,
                                fontFamily: "futura",
                                fontSize: 15)),
                        Container(
                          padding: EdgeInsets.only(top: 3, bottom: 2),
                          width: 200,
                          child: Text(
                            widget.productData['address'],
                            style: TextStyle(
                                color: lightText,
                                fontSize: 13,
                                fontFamily: "proxima"),
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            maxLines: 2,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 2, bottom: 3),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                WidgetSpan(
                                  child: Icon(
                                    Icons.location_on,
                                    size: 13,
                                    color: primaryColor,
                                  ),
                                ),
                                TextSpan(
                                  text: "" + widget.productData['place_name'],
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: "proxima",
                                      color: lightestText),
                                ),
                              ],
                            ),
                          ),
                        ),
                        
                      ],
                    )),
                GestureDetector(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: FadeInImage.assetNetwork(
                      image: widget.productData['logo'],
                      fit: BoxFit.fitWidth,
                      placeholder: cupertinoActivityIndicator,
                      height: 70.0,
                      width: 100.0,
                    ),
                  ),
                ),

              ]),

              Divider(
                height: 25,
                thickness: 1.5,
                color: dividerColor,
              )
            ])),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => storeProducts(
                      data: widget.productData['outlet_id'],
                      name: widget.productData['outlet_name'])));
        },
      ),
        
         ]);
  }

}
