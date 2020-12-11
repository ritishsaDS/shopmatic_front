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
import '../DefaultButton.dart';
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
  bool descTextShowFlag = false;
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
    d = widget.description;
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
                                  TopRoundedContainer(
                                      color: Colors.white,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          left: 15,
                                        ),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                               
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
                                                  margin: EdgeInsets.only(
                                                      top: 10.0),
                                                  child: Row(
                                                    children: <Widget>[
                                                      Text(
                                                          currency +
                                                              widget.price
                                                                  .toString(),
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "futura",
                                                              color:
                                                                  primaryColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 24)),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(currency + "900",
                                                          style: TextStyle(
                                                              color: mostlight,
                                                              fontFamily:
                                                                  "proxima",
                                                              fontSize: 16,
                                                              decoration:
                                                                  TextDecoration
                                                                      .lineThrough)),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Container(
                                                        color: Colors.red,
                                                        child: Text(" 65% OFF ",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 16,
                                                                fontFamily:
                                                                    'proxima')),
                                                      )
                                                    ],
                                                  )),
                                              
                                              Container(
                                                  margin: EdgeInsets.only(top:10.0),
                                                  child: Row(
                                                    children: <Widget>[
                                                      buildOutlineButton(
                                                          icon: Icons.remove,
                                                          press: () {
                                                            setState(() {
                                                              if (Quantity ==
                                                                  1) {
                                                              } else {
                                                                Quantity--;
                                                              }
                                                            });
                                                          }),
                                                      Container(
                                                          child: Text(
                                                        "   " +
                                                            quantity +
                                                            "   ",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "futura",
                                                            fontWeight:
                                                                FontWeight.bold,
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
                                                      Expanded(
                                                          child: SizedBox()),
                                                    ],
                                                  )),
                                            Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          
          child: Row(
                      children:[ Expanded(
                                              child: Text(
              "Description",
              style: TextStyle(
                color: darkText,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: "futura",
              ),
            ),
                      ),
              Align(
          alignment: Alignment.centerRight,
          child: Container(
            padding: EdgeInsets.all((15)),
            width: (64),
            decoration: BoxDecoration(
              color: Color(0xFFFFE6E6),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            child: Icon(
              Icons.favorite,
              size: (16),
              color: Color(0xFFFF4848),
            ),
          ),
        ),
      
                      ]),
        ),
        Container(
          
          child: Text(
           widget.description,
            style: TextStyle(fontSize: 15,fontFamily: "proxima",color:lightText),
            maxLines: descTextShowFlag ? 8 : 2,textAlign: TextAlign.start,
          ),
        ),
        Container(
        padding: EdgeInsets.only(top:5),
          
          child: GestureDetector(
            onTap: () {setState(() {
                descTextShowFlag = !descTextShowFlag; 
                });},
            child: Row(
              children: [
                descTextShowFlag ? Text("Show Less",style: TextStyle(color: Colors.pink,fontFamily: "futura"),) :  Text("Show More",style: TextStyle(color: Colors.pink,fontFamily: "futura")),
                SizedBox(width: 5),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: Colors.pink,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height:10
        )
      ],
    )
  
                                            ]),
                                      )),
                                  Container(
                                    margin:EdgeInsets.only(left:20.0,right:20.0,top:10),
                                                                      child: Column(
                                      children: [
                                     DefaultButton(
                                                          text: "Add To Cart",
                                                          press: () {},
                                                        ), ],
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
        
        child: Column(
          children: <Widget>[
            SizedBox(height: 110),
            Container(
                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(2.0),color: dividerColor),
                              child: IconButton(
                  icon: Icon(Icons.call, size: 30, color: Colors.black),
                  onPressed: () {
                    launch('tel://${widget.phone}');
                  },
                ),
              ),
         SizedBox(
           height:5
         ),
            Badge(
              showBadge: p1badge,
              badgeContent: Text(
                badge.toString(),
                style: TextStyle(color: Colors.white),
              ),
              child: Container(
                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(2.0),color: dividerColor),child: IconButton(
                icon: Icon(Icons.card_travel_outlined,
                    size: 30, color: Colors.black),
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
            )),
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

class TopRoundedContainer extends StatelessWidget {
  const TopRoundedContainer({
    Key key,
    @required this.color,
    @required this.child,
  }) : super(key: key);

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: (20)),
      padding: EdgeInsets.only(top: (20)),
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: child,
    );
  }
}

class ProductDescription extends StatelessWidget {
  const ProductDescription({
    Key key,
    this.pressOnSeeMore,
  }) : super(key: key);

  final GestureTapCallback pressOnSeeMore;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: (20)),
          child: Text(
            "Description",
            style: TextStyle(
              color: darkText,
              fontWeight: FontWeight.bold,
              fontSize: 20,
              fontFamily: "futura",
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            padding: EdgeInsets.all((15)),
            width: (64),
            decoration: BoxDecoration(
              color: Color(0xFFFFE6E6),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            child: Icon(
              Icons.favorite,
              size: (16),
              color: Color(0xFFFF4848),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: (20),
            right: (64),
          ),
          child: Text(
            "  A shirt is a cloth garment for the upper body (from the neck to the waist). Originally an undergarment worn exclusively by men, it has become, in American English, a catch-all term for a broad variety of upper-body garments and undergarments.",
            style: TextStyle(fontSize: 10),
            maxLines: 3,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: (20),
            vertical: 10,
          ),
          child: GestureDetector(
            onTap: () {},
            child: Row(
              children: [
                Text(
                  "See More Detail",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 10,
                      color: Colors.pink),
                ),
                SizedBox(width: 5),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: Colors.pink,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
