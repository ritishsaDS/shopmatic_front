import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loading_gifs/loading_gifs.dart';
import 'package:shopmatic_front/utils/common.dart';
class List_View extends StatefulWidget{
  dynamic id;
  dynamic name;
  dynamic desc;
  dynamic price;

  List_View({Key key, this.id,this.name,this.desc,this.price}) : super(key: key);
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
          margin: EdgeInsets.only(top:10),
              child: Column(
                children:<Widget>[
                  ListTile(
                title: Text(widget.name,style: TextStyle(fontFamily: "futura",fontSize: 13),),
                leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: FadeInImage.assetNetwork(
                      image: productFromServer[0],
                      placeholder: cupertinoActivityIndicator,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    )

                ),                subtitle:Container(

                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height:3
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
                        height:3
                      ),
                      Text(widget.desc,style: TextStyle(fontFamily: "proxima",fontSize: 12,fontWeight: FontWeight.bold),maxLines: 2,softWrap: true,overflow: TextOverflow.ellipsis,),
],
                  )
                ),
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
              ),
              Divider(
                height: 10,
                thickness: 1.5,
                color: dividerColor,
              )

                ]
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
