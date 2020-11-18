import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:loading_gifs/loading_gifs.dart';
import 'package:shopmatic_front/screens/manage_products.dart';
import 'package:shopmatic_front/utils/common.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'editProduct.dart';
import 'store_detail.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
class product_listing extends StatefulWidget{
  dynamic id;
  dynamic name;
  dynamic desc;

  product_listing({Key key, this.id,this.name,this.desc}) : super(key: key);
  stateproduct_listing createState()=>stateproduct_listing();

}
class stateproduct_listing extends State<product_listing> {
  bool isError = false;
  bool isLoading = false;
  @override
  void initState() {
    print("nihodsfijopdf"+widget.id);
    getProductsserver();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return   Stack(children: <Widget>[
      Container(
          child: isLoading
              ? Center(child: Image.asset(cupertinoActivityIndicator))
              :  Container(
              child: ListTile(
                title: Text(widget.name,style: TextStyle(fontFamily: "ProximaNova",fontSize: 13),),
                leading:  ClipRRect(
                    borderRadius: BorderRadius.circular(6.0),
                    child: FadeInImage.assetNetwork(
                      image: productFromServer[0],
                      placeholder: cupertinoActivityIndicator,
                      height: 90,
                      width: 90,
                      fit: BoxFit.cover,
                    )),
                subtitle:Text(widget.desc,style: TextStyle(fontFamily: "ProximaNova",fontSize: 15,fontWeight: FontWeight.bold)),
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
                          child: PopupMenuButton(
                              itemBuilder: (context) {
                                return <PopupMenuItem>[
                                  PopupMenuItem(
                                      child: GestureDetector(
                                        child: Text('Edit'),
                                        onTap: () {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => editproduct(
                                                      image: (productFromServer[0]),
                                                      id: widget.id,
                                                      name:widget.name,
                                                      description: widget.desc)));
                                        },
                                      )),
                                  PopupMenuItem(
                                      child: GestureDetector(
                                        child: Text('Delete'),
                                        onTap: () {
                                          setState(() {
                                            deleteAlbum(widget.id);
                                          });
                                        },
                                      ))
                                ];
                              },
                              child: Icon(
                                Icons.more_horiz,
                                size: 20,
                                color: white,
                              )),
                        ),
                      )
                    ],
                  ),
                ),
              )

          ))]);
  }
  dynamic productFromServer = new List();

  Future<void> getProductsserver() async {
    isLoading = true;
    try {
      print("josdfhbvfghbhzsjhu");
      final response = await http.post(
          SingleproductAPi ,body: {
        "id":widget.id
      }
      );
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        print(responseJson.toString() + "resposnseeeeeeeeeeeee");
        if (response.statusCode == 200) {
          productFromServer = responseJson['data'];
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
  Future<void> deleteAlbum(String id) async {
    isLoading = true;
    try {
      print("josdfjhu" + id.toString());
      final response = await http.post(deleteProduct, body: {"product_id": id});
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        print(responseJson.toString() + "hello");
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => manageproducts()));

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

}
