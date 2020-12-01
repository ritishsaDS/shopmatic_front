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
import 'demo.dart';

class Store_detail extends StatefulWidget {
  VoidCallback onP1Badge;
  dynamic image;

  dynamic data;
  dynamic id;
  dynamic name;
  dynamic description;
  dynamic price;

  Store_detail(
      {this.onP1Badge,
      this.image,
      this.id,
      this.data,
      this.name,
      this.description,
      this.price});

  storestate createState() => storestate();
}

class FeatureProduct {}

class storestate extends State<Store_detail> {
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
    getSingleProduct();
    super.initState();
  }

  void showWidget() {
    setState(() {
      viewVisible = true;
      badge = badge + Quantity;
    });
  }

  void showPincode() {
    setState(() {
      viewPincode = true;
      view = false;
      viewVisibletext = false;
    });
  }

  void hidePincode() {
    setState(() {
      view = true;
      viewPincode = false;
    });
  }

  void showText() {
    setState(() {
      viewVisibletext = true;
    });
  }

  void hideWidget() {
    setState(() {
      viewVisible = false;
      viewVisibletext = false;
      view = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    String quantity = Quantity.toString();
    return SafeArea(
        child: Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      resizeToAvoidBottomPadding: true,
      body: Stack(children: <Widget>[
        Container(
            child: isLoading
                ? Center(child: Image.asset(cupertinoActivityIndicator))
                : Stack(children: <Widget>[
                    GestureDetector(
                      child: Container(
                        child: ListView(
                          children: <Widget>[
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Stack(
                                    children: <Widget>[
                                      GestureDetector(
                                        child: Container(
                                            height: 350,
                                            child: Hero(
                                              tag: "imagehero",
                                              child: PageView(
                                                  controller: _pageController,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  children:
                                                      createBannerSlider()),
                                            )),
                                        onTap: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(builder: (_) {
                                            return InstaProfilePage();
                                          }));
                                        },
                                      ),
                                      _buildCircleIndicator(),
                                      Positioned(
                                        right: 0,
                                        top: 0,
                                        child: Container(
                                          decoration: new BoxDecoration(
                                              color: lightGrey,
                                              borderRadius:
                                                  new BorderRadius.only(
                                                topLeft:
                                                    const Radius.circular(40.0),
                                                topRight:
                                                    const Radius.circular(40.0),
                                                bottomRight:
                                                    const Radius.circular(40.0),
                                                bottomLeft:
                                                    const Radius.circular(40.0),
                                              )),
                                          child: IconButton(
                                            icon: Icon(Icons.close),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(10.0),
                                    child: Text(
                                      widget.name,
                                      style: TextStyle(
                                        color: darkText,
                                        fontFamily: "futura",
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(left: 10.0),
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                              currency +
                                                  widget.price.toString(),
                                              style: TextStyle(
                                                fontFamily: "futura",
                                                fontWeight: FontWeight.bold,
                                                color: primaryColor,
                                                fontSize: 18,
                                              )),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(currency + "900",
                                              style: TextStyle(
                                                  color: mostlight,
                                                  fontFamily: "proxima",
                                                  fontSize: 16,
                                                  decoration: TextDecoration
                                                      .lineThrough)),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            color: Colors.red,
                                            child: Text(" 65% OFF ",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontFamily: 'proxima')),
                                          )
                                        ],
                                      )),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 10.0),
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          'Availability:  ',
                                          style: TextStyle(
                                              color: lightestText,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 14),
                                        ),
                                        /*  Text(
                              widget.productData['special'],
                              style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14),
                            ),*/
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 10.0),
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          'SKU: ',
                                          style: TextStyle(
                                              color: lightestText,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 14),
                                        ),
                                        Text(
                                          widget.name.replaceAll("&amp;", "&"),
                                          style: TextStyle(
                                              color: primaryColor,
                                              fontWeight: FontWeight.normal,
                                              fontFamily: "proxima",
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: 10, right: 10, top: 10),
                                    child: Text(
                                      widget.description,
                                      maxLines: 3,
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontFamily: "proxima",
                                          color: lightestText,
                                          fontSize: 14),
                                    ),
                                  ),
                                  Container(
                                      margin: EdgeInsets.all(10.0),
                                      child: Row(
                                        children: <Widget>[
                                          buildOutlineButton(
                                              icon: Icons.remove,
                                              press: () {
                                                setState(() {
                                                  if (Quantity == 1) {
                                                  } else {
                                                    Quantity--;
                                                  }
                                                });
                                              }),
                                          Container(
                                              child: Text(
                                            "   " + quantity + "   ",
                                            style: TextStyle(
                                                fontFamily: "futura",
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14),
                                          )),
                                          buildOutlineButton(
                                            icon: Icons.add,
                                            press: () {
                                              setState(() {
                                                Quantity++;
                                              });
                                            },
                                          ),
                                          Expanded(child: SizedBox()),
                                          Container(
                                            height: 32,
                                            width: 32,
                                            decoration: BoxDecoration(
                                              color: Color(0xFFFF6464),
                                              shape: BoxShape.circle,
                                            ),
                                            child: Center(
                                                child: Icon(
                                                    Icons
                                                        .favorite_border_outlined,
                                                    color: white)),
                                          )
                                        ],
                                      )),
                                  Container(
                                      margin: EdgeInsets.only(
                                        top: 15,
                                        right: 5,
                                        left: 10,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          Container(
                                            height: 50,
                                            width: 58,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(18),
                                              border: Border.all(
                                                color: Colors.blue,
                                              ),
                                            ),
                                            margin: EdgeInsets.only(
                                              left: 2,
                                              right: 4,
                                            ),
                                            child: FlatButton(
                                              child: Icon(
                                                Icons.shopping_cart_outlined,
                                                size: 25,
                                                color: Colors.blue,
                                              ),
                                              onPressed: () {
                                                onP1Badge();
                                              },
                                              /* onPressed: () {
                                  showModalBottomSheet<void>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return  ListView.builder
                                        (
                                          itemCount: 100,
                                          itemBuilder: (BuildContext ctxt, int Index) {
                                            return new Container(
                                              margin: EdgeInsets.only(top:10),
                                              child:Center(

                                                child:Index==0?Container():Text(Index.toString(),style: TextStyle(fontFamily: "proxima",fontSize: 20),)
                                              )
                                            );
                                          }
                                      );
                                    },
                                  );
                                },*/
                                            ),
                                          ),
                                          Expanded(
                                              child: SizedBox(
                                                  height: 50,
                                                  child: FlatButton(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        18)),
                                                    color: Colors.black,
                                                    onPressed: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) => Cart(
                                                                  image: widget
                                                                      .image,
                                                                  name: widget
                                                                      .name,
                                                                  description:
                                                                      widget
                                                                          .description,
                                                                  Quantity:
                                                                      Quantity)));
                                                    },
                                                    child: Text(
                                                      "Buy  Now".toUpperCase(),
                                                      style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ))),
                                        ],
                                      )),
                                  Container(
                                    margin: EdgeInsets.all(10.0),
                                    height: 1.5,
                                    color: Colors.grey[200],
                                  ),
                                  Container(
                                      margin: EdgeInsets.all(10.0),
                                      child: Text("Related Products",
                                          style: TextStyle(
                                              color: primaryColor,
                                              fontFamily: "futura",
                                              fontSize: 16))),
                                  Container(
                                    height: 120,
                                     margin: EdgeInsets.only(left:10,right:10),
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: [
                                       Container(
                                         width:150,
                                                                                child: Column(
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           children:<Widget>[
                                              GestureDetector(
                                              child:Container(
                                                margin: EdgeInsets.only(right:10.0,bottom:5),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    child: Image.asset(
                                                        "assets/images/syore.jpg",height:90,fit: BoxFit.fitHeight,),
                                                  ))),
                                          Container(
                                     margin: EdgeInsets.only(left:5.0),
                                      child: Text("Buy Roadster for men ",
                                            style: TextStyle(
                                                color:darkText,
                                                fontFamily: "futura",
                                                fontSize: 16),maxLines: 1,)),
                                           ]
                                         ),
                                       ) ,
                                        Container(
                                         width:150,
                                                                                child: Column(
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           children:<Widget>[
                                              GestureDetector(
                                              child:Container(
                                                margin: EdgeInsets.only(right:10.0,bottom:5),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    child: Image.asset(
                                                        "assets/images/syore.jpg",height:90,fit: BoxFit.fitHeight,),
                                                  ))),
                                          Container(
                                     margin: EdgeInsets.only(left:5.0),
                                      child: Text("Buy Roadster for men ",
                                            style: TextStyle(
                                                color:darkText,
                                                fontFamily: "futura",
                                                fontSize: 16),maxLines: 1,)),
                                           ]
                                         ),
                                       ) ,
                                       
                                      
                                     Container(
                                         width:150,
                                                                                child: Column(
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           children:<Widget>[
                                              GestureDetector(
                                              child:Container(
                                                margin: EdgeInsets.only(right:10.0,bottom:5),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    child: Image.asset(
                                                        "assets/images/syore.jpg",height:90,fit: BoxFit.fitHeight,),
                                                  ))),
                                          Container(
                                     margin: EdgeInsets.only(left:5.0),
                                      child: Text("Buy Roadster for men ",
                                            style: TextStyle(
                                                color:darkText,
                                                fontFamily: "futura",
                                                fontSize: 16),maxLines: 1,)),
                                           ]
                                         ),
                                       ) ,
                                          ],
                                    ),
                                  ),
                                    Container(
                                    margin: EdgeInsets.all(10.0),
                                    height: 1.5,
                                    color: Colors.grey[200],
                                  ),
                                  Container(
                                      margin:
                                          EdgeInsets.only(left: 10, right: 10),
                                      child: Column(
                                        children: <Widget>[
                                          Visibility(
                                            visible: view,
                                            maintainState: view,
                                            child: Column(
                                              children: <Widget>[
                                                Row(children: <Widget>[
                                                  Icon(Icons.local_shipping),
                                                  Text(
                                                      "   When will you recieve your order?",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: darkText,
                                                      ))
                                                ]),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                TextField(
                                                  keyboardType:
                                                      TextInputType.number,
                                                  controller:
                                                      textEditingController,
                                                  onChanged: (text) {
                                                    // print("jnjno" + resultText);
                                                    query = text;
                                                    ischanged = true;
                                                    setState(() {
                                                      if (query != "") {
                                                        viewVisibletext = false;
                                                      }
                                                    });
                                                  },
                                                  decoration: InputDecoration(
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(2.0),
                                                        borderSide: BorderSide(
                                                          color: Colors.grey,
                                                          width: 2.0,
                                                        ),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(2.0),
                                                        borderSide: BorderSide(
                                                          color: Colors.grey,
                                                          width: 2.0,
                                                        ),
                                                      ),
                                                      hintText: 'Enter Pincode',
                                                      suffixIcon: Container(
                                                        width: 165,
                                                        child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: <Widget>[
                                                              Visibility(
                                                                  maintainState:
                                                                      false,
                                                                  visible:
                                                                      viewVisibletext,
                                                                  child: Text(
                                                                      "Enter Pincode    ",
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .red,
                                                                        fontFamily:
                                                                            "proxima",
                                                                      ))),
                                                              GestureDetector(
                                                                child: Text(
                                                                    " Check   ",
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .bold,
                                                                        fontFamily:
                                                                            "proxima",
                                                                        fontSize:
                                                                            14)),
                                                                onTap: () {
                                                                  print("jhvsdjbk" +
                                                                      textEditingController
                                                                          .text
                                                                          .length
                                                                          .toString());
                                                                  if (textEditingController
                                                                          .text ==
                                                                      "") {
                                                                    setState(
                                                                        () {
                                                                      if (textEditingController
                                                                              .text ==
                                                                          "") {
                                                                        setState(
                                                                            () {
                                                                          showText();
                                                                        });
                                                                      } else {
                                                                        setState(
                                                                            () {
                                                                          hideWidget();
                                                                        });
                                                                      }
                                                                    });
                                                                  } else {
                                                                    showPincode();
                                                                  }
                                                                },
                                                              ),
                                                            ]),
                                                      )),
                                                )
                                              ],
                                            ),
                                          ),
                                          Visibility(
                                              visible: viewPincode,
                                              maintainState: viewPincode,
                                              child: Column(children: <Widget>[
                                                Row(children: <Widget>[
                                                  Icon(Icons.local_shipping),
                                                  textEditingController
                                                              .text.length ==
                                                          6
                                                      ? Text(
                                                          "  With in 10-12 business days to " +
                                                              textEditingController
                                                                  .text,
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: darkText))
                                                      : Text(
                                                          "  We cant deliver here ",
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: darkText))
                                                ]),
                                                GestureDetector(
                                                    child: Text(
                                                        "Try different pincode",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: const Color(
                                                                0xFF07413C))),
                                                    onTap: () {
                                                      hidePincode();
                                                      textEditingController
                                                          .clear();
                                                    })
                                              ])),
                                        ],
                                      )),
                                  SizedBox(
                                    height: 35,
                                  ),
                                ]),

                            /* HorizontalProductList(
                          1,

                          widget.productData['category_id'],
                          'Related Products',
                          widget.productData['image'])*/ /**/
                          ],
                        ),
                      ),
                    )
                  ]))
      ]),
      floatingActionButton: FloatingActionButton(
        child: Container(
          child: Badge(
            showBadge: p1badge,
            badgeContent: Text(
              badge.toString(),
              style: TextStyle(color: Colors.white),
            ),
            child: Icon(
              Icons.add_shopping_cart,
              size: 38,
            ),
          ),
        ),
        onPressed: () {
          if (badge == 0) {
          } else {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Cart(
                        image: productFromServer[0],
                        name: widget.name,
                        id: widget.data,
                        price: widget.price,
                        description: widget.description,
                        Quantity: Quantity)));
          }
        },
      ),
      bottomNavigationBar: BottomTabs(1, true),
    ));
  }

  void onP1Badge() {
    p1badge = true;
    setState(() {
      badge = badge + Quantity;

      //data = product;
      //dataList=product;
    });
  }

  dynamic productFromServer = new List();

  Future<void> getSingleProduct() async {
    isLoading = true;
    try {
      final response =
          await http.post(SingleproductAPi, body: {"id": widget.data});
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

  _buildCircleIndicator() {
    return Positioned(
        bottom: 7.0,
        right: 130.0,
        child: Center(
            child: SmoothPageIndicator(
          controller: _pageController,
          count: createBannerSlider().length,
          effect: WormEffect(
            dotWidth: 20,
            dotHeight: 5,
            activeDotColor: primaryColor,
            dotColor: white
          ), // your preferred effect // PageController
        )));
  }

  SizedBox buildOutlineButton({IconData icon, Function press}) {
    return SizedBox(
      width: 40,
      height: 32,
      child: OutlineButton(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13),
        ),
        onPressed: press,
        child: Icon(icon),
      ),
    );
  }
}
