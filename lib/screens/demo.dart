import 'dart:convert';

import 'package:badges/badges.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_gifs/loading_gifs.dart';
import 'package:shopmatic_front/screens/store_detail.dart';
import 'package:shopmatic_front/utils/common.dart';
import 'package:http/http.dart' as http;
import 'package:shopmatic_front/widget/cart_product_cell.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'Grid_view.dart';
import 'List_view.dart';
import 'bottom_bar.dart';
import 'cart.dart';

class InstaProfilePage extends StatefulWidget {
  @override
  _InstaProfilePageState createState() => _InstaProfilePageState();
}

class _InstaProfilePageState extends State<InstaProfilePage>  with SingleTickerProviderStateMixin{
  String selected = "first";
  bool view = true;
  bool viewVisible = false;
  bool viewVisibletext = false;
  bool viewPincode = false;
  int Quantity = 1;
  TabController _controller;
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
     getProductsserver();
     _controller = new TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
                  child: SingleChildScrollView(
                    child: Container(
              height:MediaQuery.of(context).size.height,
                child: NestedScrollView(
                          headerSliverBuilder: (context, bool innerBoxIsScrolled) {
                            return [
                              
                              SliverList(
                                delegate: SliverChildListDelegate(
                                  _randomHeightWidgets(context),
                                ),
                               
                              ),
                            ];
                          },
                          // You tab view goes here
                          body:Column(
                                                      children:[  
                        Container(
                          color: Colors.blue[600],
                                                 
                          
                          child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(30.0),
                                      topLeft: Radius.circular(30.0),
                                    )),
                                child: SingleChildScrollView(
                                    child: Column(children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(left: 30.0,top:4),
                                    child: Text(
                                      "Our Albums",
                                      style: TextStyle(
                                          color: darkText,
                                          fontFamily: "futura",
                                         
                                          fontSize: 20),
                                    ),
                                  ),
                                 
                                 SizedBox( height:7,)
                                ]))),
                          ),
                     
                         Expanded(
  
  child: GridView.count(
                                              childAspectRatio:
                                                  MediaQuery.of(context).size.width *
                                                      0.5 /
                                                      250,
                                              crossAxisCount: 2,
                                              crossAxisSpacing: 1,
                                              scrollDirection: Axis.vertical,
                                             children: getProducts(),
                                            ),),
                                                      ])
     

                        

     
    
    
   
          ),
        ))));
  }

  dynamic productFromServer = new List();
    dynamic productFromdddServer = new List();

  
List<Widget> getProducts() {
    List<Widget> productLists = new List();
    List products = productFromdddServer as List;
    for (int i = 0; i < products.length; i++) {
      print("sdujh" + products.toString());
     productLists.add(Stack(children: <Widget>[
        GestureDetector(
                              child: Grid(
                                  id: products[i]['id'],
                                  name: products[i]['name'],
                                  desc: products[i]['description'],
                                  price: products[i]['price']),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Store_detail(
                                          data: products[i]['id'],
                                          name: products[i]['name'],
                                          description: products[i]
                                              ['description'],
                                          price: products[i]['price'])),
                                );
                              },
                            )

          // Container(
          //     child: isLoading
          //         ? Center(child: Image.asset(cupertinoActivityIndicator))
          //         : GestureDetector(
          //             child: productFromServer['data']['outlet_group'] == "0"
          //                 ? GestureDetector(
          //                     child: Grid(
          //                         id: products[i]['id'],
          //                         name: products[i]['name'],
          //                         desc: products[i]['description'],
          //                         price: products[i]['price']),
          //                     onTap: () {
          //                       Navigator.push(
          //                         context,
          //                         MaterialPageRoute(
          //                             builder: (context) => Store_detail(
          //                                 data: products[i]['id'],
          //                                 name: products[i]['name'],
          //                                 description: products[i]
          //                                     ['description'],
          //                                 price: products[i]['price'])),
          //                       );
          //                     },
          //                   )
          //                 : productFromServer['data']['outlet_group'] == "1"
          //                     ? GestureDetector(
          //                         child: Grid(
          //                             id: products[i]['id'],
          //                             name: products[i]['name'],
          //                             desc: products[i]['description'],
          //                             price: products[i]['silverprice']),
          //                         onTap: () {
          //                           Navigator.push(
          //                             context,
          //                             MaterialPageRoute(
          //                                 builder: (context) => Store_detail(
          //                                     data: products[i]['id'],
          //                                     name: products[i]['name'],
          //                                     description: products[i]
          //                                         ['description'],
          //                                     price: products[i]
          //                                         ['silverprice'])),
          //                           );
          //                         },
          //                       )
          //                     : productFromServer['data']['outlet_group'] == "2"
          //                         ? GestureDetector(
          //                             child: Grid(
          //                                 id: products[i]['id'],
          //                                 name: products[i]['name'],
          //                                 desc: products[i]['description'],
          //                                 price: products[i]['goldprice']),
          //                             onTap: () {
          //                               Navigator.push(
          //                                 context,
          //                                 MaterialPageRoute(
          //                                     builder: (context) =>
          //                                         Store_detail(
          //                                             data: products[i]['id'],
          //                                             name: products[i]['name'],
          //                                             description: products[i]
          //                                                 ['description'],
          //                                             price: products[i]
          //                                                 ['goldprice'])),
          //                               );
          //                             },
          //                           )
          //                         : GestureDetector(
          //                             child: Grid(
          //                                 id: products[i]['id'],
          //                                 name: products[i]['name'],
          //                                 desc: products[i]['description'],
          //                                 price: products[i]['platinumprice']),
          //                             onTap: () {
          //                               Navigator.push(
          //                                 context,
          //                                 MaterialPageRoute(
          //                                     builder: (context) =>
          //                                         Store_detail(
          //                                             data: products[i]['id'],
          //                                             name: products[i]['name'],
          //                                             description: products[i]
          //                                                 ['description'],
          //                                             price: products[i]
          //                                                 ['platinumprice'])),
          //                               );
          //                             },
          //                           )))
        ]));
      

    }
    return productLists;
  }

 
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
Future<void> getProductsserver() async {
    isLoading = true;
    try {
      print("josdfhbvfghbhzsjhu");
      final response = await http.get(
        ProductsApi + "23",
      );
      // print("iugdsgfh" + widget.data.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        print(responseJson.toString() + "hello");
        if (response.statusCode == 200) {
          productFromdddServer = responseJson['data'];
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

  List<Widget> getProductsL() {
    List<Widget> productLists = new List();
    List products = productFromdddServer as List;
    for (int i = 0; i < products.length; i++) {
      print("sdujh" + products.toString());
      productLists.add(
        GestureDetector(
                              child: List_View(
                                  id: products[i]['id'],
                                  name: products[i]['name'],
                                  desc: products[i]['description'],
                                  price: products[i]['price']),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Store_detail(
                                          data: products[i]['id'],
                                          name: products[i]['name'],
                                          description: products[i]
                                              ['description'],
                                          price: products[i]['price'])),
                                );
                              }));}
                            

    //     GestureDetector(
    //                   child: productFromServer['data']['outlet_group'] == "0"
    //                       ? GestureDetector(
    //                           child: List_View(
    //                               id: products[i]['id'],
    //                               name: products[i]['name'],
    //                               desc: products[i]['description'],
    //                               price: products[i]['price']),
    //                           onTap: () {
    //                             Navigator.push(
    //                               context,
    //                               MaterialPageRoute(
    //                                   builder: (context) => Store_detail(
    //                                       data: products[i]['id'],
    //                                       name: products[i]['name'],
    //                                       description: products[i]
    //                                           ['description'],
    //                                       price: products[i]['price'])),
    //                             );
    //                           },
    //                         )
    //                       : productFromServer['data']['outlet_group'] == "1"
    //                           ? GestureDetector(
    //                               child: List_View(
    //                                   id: products[i]['id'],
    //                                   name: products[i]['name'],
    //                                   desc: products[i]['description'],
    //                                   price: products[i]['silverprice']),
    //                               onTap: () {
    //                                 Navigator.push(
    //                                   context,
    //                                   MaterialPageRoute(
    //                                       builder: (context) => Store_detail(
    //                                           data: products[i]['id'],
    //                                           name: products[i]['name'],
    //                                           description: products[i]
    //                                               ['description'],
    //                                           price: products[i]
    //                                               ['silverprice'])),
    //                                 );
    //                               },
    //                             )
    //                           : productFromServer['data']['outlet_group'] == "2"
    //                               ? GestureDetector(
    //                                   child: List_View(
    //                                       id: products[i]['id'],
    //                                       name: products[i]['name'],
    //                                       desc: products[i]['description'],
    //                                       price: products[i]['goldprice']),
    //                                   onTap: () {
    //                                     Navigator.push(
    //                                       context,
    //                                       MaterialPageRoute(
    //                                           builder: (context) =>
    //                                               Store_detail(
    //                                                   data: products[i]['id'],
    //                                                   name: products[i]['name'],
    //                                                   description: products[i]
    //                                                       ['description'],
    //                                                   price: products[i]
    //                                                       ['goldprice'])),
    //                                     );
    //                                   },
    //                                 )
    //                               : GestureDetector(
    //                                   child: List_View(
    //                                       id: products[i]['id'],
    //                                       name: products[i]['name'],
    //                                       desc: products[i]['description'],
    //                                       price: products[i]['platinumprice']),
    //                                   onTap: () {
    //                                     Navigator.push(
    //                                       context,
    //                                       MaterialPageRoute(
    //                                           builder: (context) =>
    //                                               Store_detail(
    //                                                   data: products[i]['id'],
    //                                                   name: products[i]['name'],
    //                                                   description: products[i]
    //                                                       ['description'],
    //                                                   price: products[i]
    //                                                       ['platinumprice'])),
    //                                     );
    //                                   },
    //                                 )));
    // }
    return productLists;
  }
  List<Widget> _randomChildren;

  List<Widget> _randomHeightWidgets(BuildContext context) {
    _randomChildren ??= List.generate(1, (index) {
      return Stack(overflow: Overflow.visible,
       children: <Widget>[
            Container(
                color: Colors.blue[600],
                height: 180,
                child: Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: Row(children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image:
                                          AssetImage("assets/images/super.png"))),
                            ),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "  Pick ' N ' Buy",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontFamily: "futura",
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "   ritishs39@gmail.com",
                                    style: TextStyle(
                                        color: dividerColor,
                                        fontFamily: "proxima",
                                        fontSize: 13,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ]),
                            SizedBox(height: 20),
                          ]),
                        ),
                        SizedBox(height: 20),
                        Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Text(
                                      "10.2K",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontFamily: "futura",
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Posts",
                                      style: TextStyle(
                                        color: Colors.white70,
                                         fontFamily: "proxima",
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      "543",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontFamily: "futura",
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Following",
                                      style: TextStyle(
                                        color: Colors.white70,
                                         fontFamily: "proxima",
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white60),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "  Follow Us  ",
                                      style: TextStyle(
                                          color: Colors.white60, fontSize: 14),
                                    ),
                                  ),
                                )
                              ]),
                        ),
                       
                      ],
                    )))
      ]);});

    return _randomChildren;
  }

}
