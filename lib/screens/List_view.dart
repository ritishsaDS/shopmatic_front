import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:loading_gifs/loading_gifs.dart';
import 'package:shopmatic_front/screens/manage_products.dart';
import 'package:shopmatic_front/utils/common.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'store_detail.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
class List_View extends StatefulWidget{
  dynamic id;
  dynamic name;
  dynamic desc;

  List_View({Key key, this.id,this.name,this.desc}) : super(key: key);
  stateListView createState()=>stateListView();

}
class stateListView extends State<List_View> {
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
                title: Text(widget.name,style: TextStyle(fontFamily: "futura",fontSize: 13),),
                leading:  ClipRRect(
                    borderRadius: BorderRadius.circular(6.0),
                    child: FadeInImage.assetNetwork(
                      image: productFromServer[0],
                      placeholder: cupertinoActivityIndicator,
                      height: 90,
                      width: 90,
                      fit: BoxFit.cover,
                    )),
                subtitle:Text(widget.desc,style: TextStyle(fontFamily: "proxima",fontSize: 11,fontWeight: FontWeight.bold)),
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
}
