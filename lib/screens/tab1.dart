import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loading_gifs/loading_gifs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopmatic_front/screens/store_detail.dart';
import 'package:shopmatic_front/utils/common.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:http/http.dart' as http;

import 'Grid_view.dart';
import 'manage_products.dart';

class Listv extends StatefulWidget {
  dynamic data;
  dynamic message;
  dynamic group;

  Listv({Key key, this.data, this.message, this.group}) : super(key: key);

  @override
  List_state createState() => List_state();


}

class List_state extends State<Listv> {
  bool isError = false;
  bool isLoading = false;
  String follow = "";

  @override
  void initState() {
    print(widget.data);

    getProductsserver();
    checkfollow();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.message == "Followed") {
      return MaterialApp(
        home: Scaffold(
          body: Container(
              child: GridView.count(
                childAspectRatio: MediaQuery
                    .of(context)
                    .size
                    .width *
                    0.5 /
                    300,
                crossAxisCount: 2,
                crossAxisSpacing: 1,
                scrollDirection: Axis.vertical,
                children: getProducts(),
              )
          ),
        ),
      );
    }
    else {
      return MaterialApp(
          home: Scaffold(
              body: Container(
                margin: EdgeInsets.all(10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(

                        margin: EdgeInsets.only(
                            top: 5, left: 5, right: 5),
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.circular(100),
                            border: Border.all(
                                width: 2,
                                color: lightGrey)),
                        height: 70,
                        width: 70,
                        child:
                        Icon(Icons.lock, color: Colors.blue, size: 50)),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("This Account is Private", style: TextStyle(
                            color: darkText,
                            fontFamily: "proxima",
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                        Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 0.65,
                            child: Text(
                                "Please do follow to see his all products",
                                style: TextStyle(color: mostlight,
                                    fontFamily: "proxima",
                                    fontSize: 14))
                        )
                      ],
                    )
                  ],

                ),
              ))

      );
    }
  }

  dynamic productFromServer = new List();

  Future<void> getProductsserver() async {
    isLoading = true;
    try {
      print("josdfhbvfghbhzsjhu");
      final response = await http.get(
        ProductsApi + widget.data,
      );
      print("iugdsgfh" + widget.data.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        print(responseJson.toString() + "hello");
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

  List<Widget> getProducts() {
    List<Widget> productLists = new List();
    List products = productFromServer as List;
    for (int i = 0; i < products.length; i++) {
      print("sdujh" + products.toString());
      productLists.add(
          GestureDetector(
            child: widget.group == "0" ? GestureDetector(
              child:Grid(id: products[i]['id'],
                  name: products[i]['name'],
                  desc: products[i]['description'],
                  price: products[i]['price']), onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        Store_detail(
                          data: products[i]['id'],
                          name: products[i]['name'],
                          description: products[i]['description'],
                            price: products[i]['price']

                        )
                ),
              );
            },
            ) : widget.group == "1" ?GestureDetector(
              child:  Grid(
                  id: products[i]['id'],
                  name: products[i]['name'],
                  desc: products[i]['description'],
                  price: products[i]['silverprice']), onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        Store_detail(
                          data: products[i]['id'],
                          name: products[i]['name'],
                          description: products[i]['description'],
                            price: products[i]['silverprice']

                        )
                ),
              );
            },
            ):widget.group=="2"?GestureDetector(
              child:Grid(
                  id: products[i]['id'],
                  name: products[i]['name'],
                  desc: products[i]['description'],
                  price: products[i]['goldprice']), onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        Store_detail(
                          data: products[i]['id'],
                          name: products[i]['name'],
                          description: products[i]['description'],
                            price: products[i]['goldprice']

                        )
                ),
              );
            },
            ):GestureDetector(
              child:Grid(
                  id: products[i]['id'],
                  name: products[i]['name'],
                  desc: products[i]['description'],
                  price: products[i]['platinumprice']), onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        Store_detail(
                          data: products[i]['id'],
                          name: products[i]['name'],
                          description: products[i]['description'],
                            price: products[i]['platinumprice']
                        )
                ),
              );
            },
            )

          ));
      /*GestureDetector(
          child:    Container(
              child: ListTile(
                title: Text(products[i]['name'],style: TextStyle(fontFamily: "ProximaNova",fontSize: 13),),
                */ /*leading:  ClipRRect(
                    borderRadius: BorderRadius.circular(6.0),
                    child: FadeInImage.assetNetwork(
                      image: products[i]['image'],
                      placeholder: cupertinoActivityIndicator,
                      height: 90,
                      width: 90,
                      fit: BoxFit.cover,
                    )),*/ /*
                subtitle:Text(products[i]['name'],style: TextStyle(fontFamily: "ProximaNova",fontSize: 15,fontWeight: FontWeight.bold)),
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
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Store_detail(
                      data:products[i]['id'],
                    name:  products[i]['name'],
                    description: products[i]['description'],

                  )
              ),
            );
          },
        ),*/
    }
    return productLists;
  }

  Future<void> checkfollow() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    follow = prefs.getString('follow');
  }
}





