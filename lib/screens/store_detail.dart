import 'dart:convert';
import 'dart:convert' show utf8;
import 'dart:typed_data';
import 'package:badges/badges.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:loading_gifs/loading_gifs.dart';
import 'package:shopmatic_front/utils/common.dart';
import 'package:http/http.dart' as http;
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'bottom_bar.dart';
import 'cart.dart';
import 'demo.dart';

class Store_detail extends StatefulWidget {
  VoidCallback onP1Badge;
  dynamic image;
dynamic phone;
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
      this.phone,
      this.name,
      this.description,
      this.price});

  storestate createState() => storestate();
}

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
  bool _isCreatingLink = false;
  bool ischanged = false;
  String query = "";
  String ds = "145, 151, 240, 159, 152, 152, 70, 97, 98, 114, 105, 99, 32";
  List<int> bytes;
  String d;
  bool isError = false;
  bool isLoading = false;
  PageController _pageController = PageController(
    initialPage: 0,
  );
  String _linkMessage;
  @override
  void initState() {
    d=widget.description;
    getSingleProduct();
    
    initDynamicLinks();
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
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
                                        right: 5,
                                        top: 5,
                                        child: Container(
                                          width: 45,
                                          height: 45,
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
                                            icon: Icon(Icons.close, size: 20),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ),
                                      ),
                                     ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(10.0),
                                    child: Text(
                                      widget.name,
                                      style: TextStyle(
                                        color: darkText,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        fontFamily: "futura",
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
                                                  color: primaryColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 24)),
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
                                    height: 10,
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
                                        ],
                                      )),
                                  Container(
                                      margin: EdgeInsets.only(
                                          left: 10.0, right: 10),
                                      child: Row(
                                        children: <Widget>[
                                          GestureDetector(
                                            child: Container(
                                              padding: EdgeInsets.all(3.0),
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                color: lightestText,
                                                shape: BoxShape.circle,
                                              ),
                                              child: Center(
                                                  child: Icon(
                                                      Icons.share_rounded,
                                                      size: 20,
                                                      color: white)),
                                            ),
                                            onTap: !_isCreatingLink
                                                ? () => _createDynamicLink(true)
                                                : null,
                                          ),
                                          SizedBox(width: 5),
                                          Container(
                                            height: 30,
                                            width: 30,
                                            decoration: BoxDecoration(
                                              color: lightestText,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Center(
                                                child: Icon(
                                                    Icons
                                                        .favorite_border_outlined,
                                                    size: 20,
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
                                          Expanded(
                                            child: Container(
                                              height: 50,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(18),
                                                border: Border.all(
                                                  color: Colors.black,
                                                ),
                                              ),
                                              margin: EdgeInsets.only(
                                                left: 2,
                                                right: 4,
                                              ),
                                              child: FlatButton(
                                                child: Text(
                                                  "Add to Cart",
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    fontFamily: "futura",
                                                    fontWeight: FontWeight.bold,
                                                    color: darkText,
                                                  ),
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
                                                                  image:
                                                                      productFromServer[
                                                                          0],
                                                                  name: widget
                                                                      .name,
                                                                  id: widget
                                                                      .data,
                                                                  price: widget
                                                                      .price,
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
                                                          fontFamily: "futura"),
                                                    ),
                                                  ))),
                                        ],
                                      )),
                                  SizedBox(height: 10),
                                  Container(
                                    margin:
                                        EdgeInsets.only(left: 10, right: 10),
                                    child: Text(
                                      widget.description,
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontFamily: "proxima",
                                          color: lightestText,
                                          fontSize: 14),
                                      maxLines: 10,
                                    ),
                                  ),
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
                                    margin:
                                        EdgeInsets.only(left: 10, right: 10),
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: [
                                        Container(
                                          width: 150,
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                GestureDetector(
                                                    child: Container(
                                                        margin: EdgeInsets.only(
                                                            right: 10.0,
                                                            bottom: 5),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                          child: Image.asset(
                                                            "assets/images/syore.jpg",
                                                            height: 90,
                                                            fit: BoxFit
                                                                .fitHeight,
                                                          ),
                                                        ))),
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        left: 5.0),
                                                    child: Text(
                                                      "Buy Roadster for men ",
                                                      style: TextStyle(
                                                          color: darkText,
                                                          fontFamily: "futura",
                                                          fontSize: 16),
                                                      maxLines: 1,
                                                    )),
                                              ]),
                                        ),
                                        Container(
                                          width: 150,
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                GestureDetector(
                                                    child: Container(
                                                        margin: EdgeInsets.only(
                                                            right: 10.0,
                                                            bottom: 5),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                          child: Image.asset(
                                                            "assets/images/syore.jpg",
                                                            height: 90,
                                                            fit: BoxFit
                                                                .fitHeight,
                                                          ),
                                                        ))),
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        left: 5.0),
                                                    child: Text(
                                                      "Buy Roadster for men ",
                                                      style: TextStyle(
                                                          color: darkText,
                                                          fontFamily: "futura",
                                                          fontSize: 16),
                                                      maxLines: 1,
                                                    )),
                                              ]),
                                        ),
                                        Container(
                                          width: 150,
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                GestureDetector(
                                                    child: Container(
                                                        margin: EdgeInsets.only(
                                                            right: 10.0,
                                                            bottom: 5),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                          child: Image.asset(
                                                            "assets/images/syore.jpg",
                                                            height: 90,
                                                            fit: BoxFit
                                                                .fitHeight,
                                                          ),
                                                        ))),
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        left: 5.0),
                                                    child: Text(
                                                      "Buy Roadster for men ",
                                                      style: TextStyle(
                                                          color: darkText,
                                                          fontFamily: "futura",
                                                          fontSize: 16),
                                                      maxLines: 1,
                                                    )),
                                              ]),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(10.0),
                                    height: 1.5,
                                    color: Colors.grey[200],
                                  ),
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
      floatingActionButton: Container(
       margin:EdgeInsets.only(
         left:MediaQuery.of(context).size.width-30,
       ),
              child: Column(
          children: <Widget>[
            SizedBox(height: 110),
          Container(
             
                          child: IconButton(
                    icon: Icon(Icons.call, size: 40, color: Colors.black),
                    onPressed: () {
                    launch('tel://${widget.phone}');
                    },
                  ),
             ),
        
         
           
            Badge(
                                                  showBadge: p1badge,
                                              
                                                  badgeContent: Text(
                                                    badge.toString(),
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  child: IconButton(
                                                    icon: Icon(
                                                        Icons
                                                            .card_travel_outlined,
                                                        size: 40,
                                                        color:  Colors.black),
                                                    onPressed: () {
                                                      if (badge == 0) {
                                                      } else {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) => Cart(
                                                                    image:
                                                                        productFromServer[
                                                                            0],
                                                                    name: widget
                                                                        .name,
                                                                    id: widget
                                                                        .data,
                                                                    price: widget
                                                                        .price,
                                                                    description:
                                                                        widget
                                                                            .description,
                                                                    Quantity:
                                                                        Quantity)));
                                                      }
                                                    },
                                                  ),
                                                ),
          ],
        ),
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

        productFromServer = responseJson['data'];

        setState(() {
          isError = false;
          isLoading = false;
        });
      } else {
        setState(() {
          isError = true;
          isLoading = false;
        });
      }
    } catch (e) {
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
            fit: BoxFit.fitHeight,
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
              dotColor: white), // your preferred effect // PageController
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

  Future<void> _createDynamicLink(bool short) async {
    setState(() {
      _isCreatingLink = true;
    });

    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://shopmaticfront.page.link',
      link: Uri.parse('https://aashya.com/topstore'),
      androidParameters: AndroidParameters(
        packageName: 'com.tapp.shopmatic_front',
      ),
      iosParameters: IosParameters(
        bundleId: 'com.google.FirebaseCppDynamicLinksTestApp.dev',
        minimumVersion: '0',
      ),
    );

    Uri url;
    if (short) {
      final ShortDynamicLink shortLink = await parameters.buildShortLink();
      url = shortLink.shortUrl;
    } else {
      url = await parameters.buildUrl();
    }

    setState(() {
      _linkMessage = url.toString();
      _isCreatingLink = false;
    });
    FlutterShare.share(
        title: 'Example share',
        text: "Name:" + widget.name + "\n" + "Info:" + widget.description,
        linkUrl: _linkMessage,
        chooserTitle: 'Example Chooser Title');
  }

  void initDynamicLinks() async {
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
      final Uri deepLink = dynamicLink?.link;

      if (deepLink != null) {
        Navigator.pushNamed(context, deepLink.path);
      }
    }, onError: (OnLinkErrorException e) async {
      print('onLinkError');
      print(e.message);
    });

    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri deepLink = data?.link;

    if (deepLink != null) {
      Navigator.pushNamed(context, deepLink.path);
    }
  }

  void utf8convert() {
    bytes = widget.description.toString().codeUnits;

    utf8.decode(bytes);

    print(String.fromCharCodes(bytes));
  }
}
