import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loading_gifs/loading_gifs.dart';
import 'package:shopmatic_front/utils/common.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class Grid extends StatefulWidget {
  dynamic id;
  dynamic name;
  dynamic desc;
  dynamic price;

  Grid({Key key, this.id, this.name, this.desc, this.price}) : super(key: key);

  @override
  Grid_state createState() => Grid_state();
}

class Grid_state extends State<Grid> {
  bool isError = false;
  bool isLoading = false;

  @override
  void initState() {
    print("nihodsfijopdf" + widget.id);
    getProductsserver();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Container(
          child: isLoading
              ? Center(child: Image.asset(cupertinoActivityIndicator))
              : Container(
            margin: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    ClipRRect(
                        borderRadius: BorderRadius.circular(6.0),
                        child: FadeInImage.assetNetwork(
                          image: productFromServer[0],
                          placeholder: cupertinoActivityIndicator,
                          height: 180,
                          width: 170,
                          fit: BoxFit.fill,
                        )),
                    Positioned(
                      right: 5,
                      top: 5,
                      child: Container(
                          padding: EdgeInsets.all(2.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: lightGrey),
                          child: Icon(
                            Icons.favorite_border,
                            color: lightText,
                          )),
                    )
                  ],
                ),
                 SizedBox(
                  height: 3,
                ),
                Text(
                  widget.name,
                  style: TextStyle(
                      color: darkText,
                      fontFamily: "futura",
                      fontSize: 14,
                    ),
                ),
                SizedBox(
                  height: 3,
                ),
                Row(
                  children: <Widget>[
                    Text("" + currency + widget.price.toString(),
                        style: TextStyle(
                            color: lightText,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,fontFamily: "futura")),
                    SizedBox(
                      width: 4,
                    ),
                    Text(currency + "900",
                        style: TextStyle(
                            color: mostlight,
                            fontSize: 11,
                            decoration: TextDecoration.lineThrough,fontFamily: "proxima")),
                    SizedBox(
                      width: 5,
                    ),
                    Text("65% OFF",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                            fontFamily: 'proxima')),
                  ],
                ),
                SizedBox(
                  height:2
                ),
                Text(widget.desc,style:TextStyle(color: lightestText,fontFamily: "proxima",fontSize: 11),softWrap: true,overflow: TextOverflow.ellipsis,),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      child: Container(
                        width: 25,
                        padding: EdgeInsets.only(left: 5),
                        child: CircleAvatar(
                          backgroundColor: Colors.grey[400],
                          child: Icon(
                            Icons.share,
                            size: 13,
                            color: Colors.grey[100],
                          ),
                        ),
                      ), onTap: () {

                      /* FlutterShare.share(
                                title: products[i]['name'],
                                text: products[i]['name'],
                                linkUrl: products[i]['image'],
                                chooserTitle: products[i]['name']);*/

                    },
                    ),
                    Container(
                      width: 25,
                      padding: EdgeInsets.only(left: 5),
                      child: CircleAvatar(
                        backgroundColor: Colors.grey[400],
                        child: Icon(
                          Icons.add,
                          size: 13,
                          color: Colors.grey[100],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ))
    ]);
  }

  dynamic productFromServer = new List();

  Future<void> getProductsserver() async {
    isLoading = true;
    try {
      print("josdfhbvfghbhzsjhu");
      final response = await http.post(
          SingleproductAPi, body: {
        "id": widget.id
      }
      );
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        print(responseJson.toString() + "resposnseeeeeeeeeeeee");
        if (response.statusCode == 200) {
          productFromServer = responseJson['data'] as List;
          print('jhifuh' + productFromServer.toString());
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

/*
  List<Widget> getProducts() {
    List<Widget> productLists = new List();
    List products = productFromServer as List ;
    for (int i = 0; i < products.length; i++) {
      print("sdujh" + products.toString());
      productLists.add(

      );
    }
    return productLists;
  }
*/

}
                                                                                                                                                                  
                                                                                                                                                                                