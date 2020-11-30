import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loading_gifs/loading_gifs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopmatic_front/screens/story.dart';
import 'package:shopmatic_front/utils/common.dart';

import 'Grid_view.dart';
import 'List_view.dart';
import 'bottom_bar.dart';
import 'store_detail.dart';

class storeProducts extends StatefulWidget {
  dynamic data;
  dynamic name;

  storeProducts({Key key, this.data, this.name}) : super(key: key);

  storestate createState() => storestate();
}

class storestate extends State<storeProducts>
    with SingleTickerProviderStateMixin {
  bool isError = false;
  bool isLoading = false;
  TabController _controller;
  String id;
  TextEditingController reason = TextEditingController();

  String follow="";

  @override
  void initState() {
    getProfile();
    getFollowersapi();
    getStories();
    getCategories();
    getProductsserver();
    _controller = new TabController(length: 2, vsync: this);
    super.initState();
  }

  double get randHeight => Random().nextInt(100).toDouble();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: SafeArea(
              child: Stack(children: <Widget>[
          Container(
              child: isLoading
                  ? Center(child: Image.asset(cupertinoActivityIndicator))
                  : DefaultTabController(
                      length: 1,
                      child: NestedScrollView(
                          headerSliverBuilder: (context, bool innerBoxIsScrolled) {
                            return [
                              new SliverAppBar(
                                  elevation: 2,
            backgroundColor: Colors.white,
            iconTheme: new IconThemeData(color: Colors.black),
                    title: Text(follow,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontFamily: "futura")),
                    pinned: false,
                    floating: true,
                    forceElevated: innerBoxIsScrolled,
                  ),
                              SliverList(
                                delegate: SliverChildListDelegate(
                                  _randomHeightWidgets(context),
                                ),
                               
                              ),
                            ];
                          },
                          // You tab view goes here
                          body: Stack(children: <Widget>[
                            Container(
                              child: isLoading
                                  ? Center(
                                      child:
                                          Image.asset(cupertinoActivityIndicator))
                                  : productFromServer['message'] == "Joined"
                                      ? Container(
                                          margin: EdgeInsets.all(10.0),
                                          child: Column(
                                            children: <Widget>[
                                               Row(children: [
                                                Expanded(
                                                  child: Container(
                                                     margin: EdgeInsets.only(
                                                           
                                                            bottom: 10),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                8.0),
                                                        color: dividerColor),
                                                    child: TextField(
                                                      decoration: InputDecoration(
                                                          border:
                                                              InputBorder.none,
                                                          contentPadding:
                                                              EdgeInsets.only(
                                                                  left: 10),
                                                          hintText:
                                                              'Search Shirts , jeans....',
                                                          hintStyle: TextStyle(
                                                              fontFamily:
                                                                  "proxima",
                                                              fontSize: 14)),
                                                    ),
                                                  ),
                                                ),
                                              ]),
                                              Container(
                                                  height: 50,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            right: 10,
                                                           ),
                                                        padding:
                                                            EdgeInsets.all(10.0),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6.0),
                                                            color: lightGrey,
                                                            border: Border.all(
                                                                color:
                                                                    lightGrey)),
                                                        child: Center(
                                                            child: Text(
                                                          "  All  ",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "proxima",
                                                              color: darkText,
                                                              fontSize: 16),
                                                        )),
                                                      ),
                                                      Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.73,
                                                          child: ListView(
                                                              scrollDirection:
                                                                  Axis.horizontal,
                                                              children:
                                                                  getTopcategories()))
                                                    ],
                                                  )),
                                             
                                              SizedBox(height: 7),
                                              Expanded(
                                                child: TabBarView(
                                                  children: [
                                                    GridView.count(
                                                      childAspectRatio:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.5 /
                                                              260,
                                                      crossAxisCount: 2,
                                                      crossAxisSpacing: 1,
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      children: getProducts(),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      : Container(
                                          margin: EdgeInsets.all(10.0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      top: 5, left: 5, right: 5),
                                                  padding: EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                      border: Border.all(
                                                          width: 2,
                                                          color: lightGrey)),
                                                  height: 70,
                                                  width: 70,
                                                  child: Icon(Icons.lock,
                                                      color: Colors.blue,
                                                      size: 50)),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text("This Account is Private",
                                                      style: TextStyle(
                                                          color: darkText,
                                                          fontFamily: "futura",
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.65,
                                                      child: Text(
                                                          "Please do follow to see his all products",
                                                          style: TextStyle(
                                                              color: mostlight,
                                                              fontFamily:
                                                                  "proxima",
                                                              fontSize: 14)))
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                            ),
                          ]))))
        ]),
      ),
      bottomNavigationBar: BottomTabs(1, true),
    );
  }

  dynamic productFromServer = new List();
  dynamic storyfromserver = new List();
  dynamic categoryfromserver = new List();
  dynamic followersfromserver = new List();

  Future<void> getProfile() async {
    isLoading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    id = prefs.getString('intValue');
    print("isdds" + id);
    try {
      final response = await http
          .post(profileApi, body: {"outlet_id": widget.data, "user_id": id});
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        print(responseJson.toString() + "hello");

        productFromServer = responseJson;
follow=productFromServer['data']  ['outlet_name'];
        setState(() {
          isError = false;

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

  Future<void> getStories() async {
    isLoading = true;
    try {
      print("josdfjhu");
      final response = await http.get(
        StoriesApi + widget.data,
      );
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        print(responseJson.toString() + "hello");
        if (response.statusCode == 200) {
          storyfromserver = responseJson['data'];
        }
        setState(() {
          isError = false;

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

  List<Widget> getStorestories() {
    List<Widget> productLists = new List();
    List categories = storyfromserver as List;
    for (int i = 0; i < categories.length; i++) {
      productLists.add(
        GestureDetector(
            child: Container(
                margin: EdgeInsets.only(top: 5, left: 5, right: 5),
                height: 85,
                width: 80,
                child: Padding(
                  padding: EdgeInsets.only(top: 4.0, bottom: 5.0),
                  child: Container(
                      child: ClipOval(
                          child: CircleAvatar(
                              radius: 60,
                              backgroundColor: lightGrey,
                              child: FadeInImage.assetNetwork(
                                image: categories[i]['photo'],
                                placeholder: cupertinoActivityIndicator,
                                fit: BoxFit.fill,
                                height: 90,
                              )))),
                )),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          MoreStories(data: widget.data, index: i)));
            }),
      );
    }
    return productLists;
  }

  Future<void> getCategories() async {
    isLoading = true;
    try {
      print("josdfjhu");
      final response = await http.get(
        CategoriesApi + widget.data,
      );
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        print(responseJson.toString() + "hello");
        if (response.statusCode == 200) {
          categoryfromserver = responseJson['data'] as List;
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

  List<Widget> getTopcategories() {
    List<Widget> productLists = new List();
    List categories = categoryfromserver;

    for (int i = 0; i < categories.length; i++) {
      productLists.add(GestureDetector(
        child: Container(
          height: 50,
          margin: EdgeInsets.only(right: 10),
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.0),
              color: white,
              border: Border.all(color: lightGrey)),
          child: Center(
              child: Text(
            "  " + categories[i]['category_name'] + "  ",
            style:
                TextStyle(fontFamily: "proxima", color: darkText, fontSize: 16),
          )),
        ),
        onTap: () {
          setState(() {
            /*   if (products[i]["isactive"] == "true") {
              catColor = lightGrey;
              print(products[i]["category_id"] + "true");
            } else if (products[i]["isactive"] == "false") {
              catColor = white;

              print("false");
            }*/
          });
        },
      ));
    }
    return productLists;
  }

  Future<void> getoutletStatus(String reason) async {
    isLoading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    id = prefs.getString('intValue');
    print("isdds" + id);
    try {
      print("nofjkdf" + id);

      print("josdfjhu");

      final response = await http.post(followOutlet, body: {
        "user_id": id,
        "outlet_id": widget.data,
        "status": "1",
        "reason": reason
      });
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        print(responseJson.toString() + "hello");
        if (response.statusCode == 200) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => storeProducts(data: widget.data)));
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

  _showDialog() async {
    await showDialog<String>(
      context: context,
      child: Container(
        padding: EdgeInsets.only(left: 10),
        height: 100,
        child: new AlertDialog(
          contentPadding: EdgeInsets.all(16.0),
          content: Container(
            height: 150,
            child: Column(
              children: <Widget>[
                Text("Why Would you want to join this store ?"),
                SizedBox(
                  height: 5,
                ),
                Container(
                  child: TextField(
                    controller: reason,
                    autofocus: true,
                    decoration: new InputDecoration(
                        labelText: 'Please Add Suitable Reason',
                        hintText: 'Reason'),
                  ),
                )
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.pop(context);
                }),
            new FlatButton(
                child: const Text('Done'),
                onPressed: () {
                  if (reason.text == "") {
                  } else {
                    getoutletStatus(reason.text);
                  }
                })
          ],
        ),
      ),
    );
  }

  unfollowDialog() async {
    await showDialog<String>(
      context: context,
      child: Container(
        padding: EdgeInsets.only(left: 10),
        height: 100,
        child: new AlertDialog(
          contentPadding: EdgeInsets.all(16.0),
          content: Container(
            height: 250,
            child: Column(
              children: <Widget>[
                Center(
                  child: Container(
                      margin: EdgeInsets.only(top: 5, left: 5, right: 5),
                      height: 100,
                      width: 90,
                      child: ClipOval(
                        child: FadeInImage.assetNetwork(
                          image: productFromServer['data']['logo'],
                          placeholder: cupertinoActivityIndicator,
                          height: 90,
                          width: 70,
                          fit: BoxFit.cover,
                        ),
                      )),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  productFromServer['data']['outlet_name'],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                FlatButton(
                    child: Text(
                      'Unfollow',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () => unfollow()),
                Divider(
                  thickness: 1.5,
                  color: dividerColor,
                  height: 3,
                ),
                FlatButton(
                    child: const Text(
                      'Cancel',
                      style: TextStyle(fontSize: 16),
                    ),
                    onPressed: () => Navigator.pop(context)),
                Divider(
                  thickness: 1.5,
                  color: dividerColor,
                  height: 3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getFollowersapi() async {
    isLoading = true;
    try {
      final response = await http.post(followersApi, body: {
        "outlet_id": widget.data,
      });
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        print(responseJson.toString() + "hello");

        followersfromserver = responseJson;

        setState(() {
          isError = false;
          isLoading = true;
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

  Future<void> unfollow() async {
    isLoading = true;
    try {
      final response = await http.post(unfollowOutlet,
          body: {"user_id": id, "outlet_id": widget.data});
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        print(responseJson.toString() + "hello");
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => storeProducts(data: widget.data)));

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

  dynamic productFromdddServer = new List();

  List<Widget> getProducts() {
    List<Widget> productLists = new List();
    List products = productFromdddServer as List;
    for (int i = 0; i < products.length; i++) {
      print("sdujh" + products.toString());
      if (productFromServer['message'] == "Joined") {
        productLists.add(Stack(children: <Widget>[
          Container(
              child: isLoading
                  ? Center(child: Image.asset(cupertinoActivityIndicator))
                  : GestureDetector(
                      child: productFromServer['data']['outlet_group'] == "0"
                          ? GestureDetector(
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
                          : productFromServer['data']['outlet_group'] == "1"
                              ? GestureDetector(
                                  child: Grid(
                                      id: products[i]['id'],
                                      name: products[i]['name'],
                                      desc: products[i]['description'],
                                      price: products[i]['silverprice']),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Store_detail(
                                              data: products[i]['id'],
                                              name: products[i]['name'],
                                              description: products[i]
                                                  ['description'],
                                              price: products[i]
                                                  ['silverprice'])),
                                    );
                                  },
                                )
                              : productFromServer['data']['outlet_group'] == "2"
                                  ? GestureDetector(
                                      child: Grid(
                                          id: products[i]['id'],
                                          name: products[i]['name'],
                                          desc: products[i]['description'],
                                          price: products[i]['goldprice']),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Store_detail(
                                                      data: products[i]['id'],
                                                      name: products[i]['name'],
                                                      description: products[i]
                                                          ['description'],
                                                      price: products[i]
                                                          ['goldprice'])),
                                        );
                                      },
                                    )
                                  : GestureDetector(
                                      child: Grid(
                                          id: products[i]['id'],
                                          name: products[i]['name'],
                                          desc: products[i]['description'],
                                          price: products[i]['platinumprice']),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Store_detail(
                                                      data: products[i]['id'],
                                                      name: products[i]['name'],
                                                      description: products[i]
                                                          ['description'],
                                                      price: products[i]
                                                          ['platinumprice'])),
                                        );
                                      },
                                    )))
        ]));
      } else {
        Container(
          margin: EdgeInsets.all(10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(top: 5, left: 5, right: 5),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 2, color: lightGrey)),
                  height: 70,
                  width: 70,
                  child: Icon(Icons.lock, color: Colors.blue, size: 50)),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("This Account is Private",
                      style: TextStyle(
                          color: darkText,
                          fontFamily: "futura",
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.65,
                      child: Text("Please do follow to see  all products",
                          style: TextStyle(
                              color: mostlight,
                              fontFamily: "proxima",
                              fontSize: 14)))
                ],
              )
            ],
          ),
        );
      }
    }
    return productLists;
  }

  Future<void> getProductsserver() async {
    isLoading = true;
    try {
      print("josdfhbvfghbhzsjhu");
      final response = await http.get(
        ProductsApi + widget.data,
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
      productLists.add(GestureDetector(
          child: productFromServer['data']['outlet_group'] == "0"
              ? GestureDetector(
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
                              description: products[i]['description'],
                              price: products[i]['price'])),
                    );
                  },
                )
              : productFromServer['data']['outlet_group'] == "1"
                  ? GestureDetector(
                      child: List_View(
                          id: products[i]['id'],
                          name: products[i]['name'],
                          desc: products[i]['description'],
                          price: products[i]['silverprice']),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Store_detail(
                                  data: products[i]['id'],
                                  name: products[i]['name'],
                                  description: products[i]['description'],
                                  price: products[i]['silverprice'])),
                        );
                      },
                    )
                  : productFromServer['data']['outlet_group'] == "2"
                      ? GestureDetector(
                          child: List_View(
                              id: products[i]['id'],
                              name: products[i]['name'],
                              desc: products[i]['description'],
                              price: products[i]['goldprice']),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Store_detail(
                                      data: products[i]['id'],
                                      name: products[i]['name'],
                                      description: products[i]['description'],
                                      price: products[i]['goldprice'])),
                            );
                          },
                        )
                      : GestureDetector(
                          child: List_View(
                              id: products[i]['id'],
                              name: products[i]['name'],
                              desc: products[i]['description'],
                              price: products[i]['platinumprice']),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Store_detail(
                                      data: products[i]['id'],
                                      name: products[i]['name'],
                                      description: products[i]['description'],
                                      price: products[i]['platinumprice'])),
                            );
                          },
                        )));
    }
    return productLists;
  }

  List<Widget> _randomChildren;

  List<Widget> _randomHeightWidgets(BuildContext context) {
    _randomChildren ??= List.generate(1, (index) {
      return Stack(children: <Widget>[
        Container(
            child: isLoading
                ? Center(child: Image.asset(cupertinoActivityIndicator))
                : Container(
                    margin: EdgeInsets.only(left: 10.0, right: 10, top: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                                height: 90,
                                width: 90,
                                child: ClipOval(
                                  child: FadeInImage.assetNetwork(
                                    image: productFromServer['data']['logo'],
                                    placeholder: cupertinoActivityIndicator,
                                    height: 100,
                                    width: 90,
                                    fit: BoxFit.cover,
                                  ),
                                )),
                            SizedBox(width: 10),
                            Expanded(
                                child: Container(
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                  Container(
                                      child: Text(
                                          productFromServer['data']
                                              ['outlet_name'],
                                          style: TextStyle(
                                              color: darkText,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              fontFamily: "futura"))),
                                  Container(
                                      child: Text(
                                          productFromServer['data']
                                              ['short_desc'],
                                          style: TextStyle(
                                            fontFamily: "proxima",
                                            color: lightestText,
                                            fontSize: 14,
                                          ),maxLines: 4,)),
                                  SizedBox(height: 10),
                                  Row(
                                    children: <Widget>[
                                      productFromServer['message'] ==
                                              "Join as Reseller"
                                          ? Expanded(
                                              child: GestureDetector(
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6.0),
                                                        color: Colors.pink,
                                                      ),
                                                      padding:
                                                          EdgeInsets.all(5.0),
                                                      child: Center(
                                                        child: Text(
                                                            productFromServer[
                                                                'message'],
                                                            style: TextStyle(
                                                                color: white,
                                                                fontSize: 16)),
                                                      )),
                                                  onTap: () {
                                                    if (productFromServer[
                                                            'message'] ==
                                                        "Join as Reseller") {
                                                      _showDialog();
                                                    } else {
                                                      unfollowDialog();
                                                    }
                                                  }),
                                            )
                                          : productFromServer['message'] ==
                                                  "Requested"
                                              ? Expanded(
                                                  child: GestureDetector(
                                                      child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6.0),
                                                            color: Colors.pink,
                                                          ),
                                                          padding:
                                                              EdgeInsets.all(
                                                                  5.0),
                                                          child: Center(
                                                            child: Text(
                                                                productFromServer[
                                                                    'message'],
                                                                style: TextStyle(
                                                                    color:
                                                                        white,
                                                                    fontSize:
                                                                        16)),
                                                          )),
                                                      onTap: () {
                                                        if (productFromServer[
                                                                'message'] ==
                                                            "Join as Reseller") {
                                                          _showDialog();
                                                        } else {
                                                          unfollowDialog();
                                                        }
                                                      }),
                                                )
                                              : Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    GestureDetector(
                                                        child: Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.32,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          6.0),
                                                              color:
                                                                  Colors.pink,
                                                            ),
                                                            padding:
                                                                EdgeInsets.all(
                                                                    5.0),
                                                            child: Center(
                                                              child: Text(
                                                                  productFromServer[
                                                                      'message'],
                                                                  style: TextStyle(
                                                                      color:
                                                                          white,
                                                                      fontSize:
                                                                          16)),
                                                            )),
                                                        onTap: () {
                                                          if (productFromServer[
                                                                  'message'] ==
                                                              "Join as Reseller") {
                                                            _showDialog();
                                                          } else {
                                                            unfollowDialog();
                                                          }
                                                        }),
                                                    SizedBox(width: 8),
                                                    GestureDetector(
                                                        child: Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.32,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          6.0),
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .pink),
                                                            ),
                                                            padding:
                                                                EdgeInsets.all(
                                                                    5.0),
                                                            child: Center(
                                                              child: Text(
                                                                  "Message",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .pink,
                                                                      fontSize:
                                                                          16)),
                                                            )),
                                                        onTap: () {
                                                          if (productFromServer[
                                                                  'message'] ==
                                                              "Join as Reseller") {
                                                            _showDialog();
                                                          } else {
                                                            unfollowDialog();
                                                          }
                                                        }),
                                                  ],
                                                ),
                                    ],
                                  )
                                ]))),
                          ],
                        ),
                        SizedBox(height: 5),
                        Divider(
                          height: 10,
                          thickness: 1.5,
                          color: dividerColor,
                        ),
                        SizedBox(height: 5),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column( mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                Container(
                                    child: Text("219",
                                        style: TextStyle(
                                            color: darkText,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20))),
                                Container(
                                    padding: EdgeInsets.all(5.0),
                                    child: Text("Reviewes",
                                        style: TextStyle(
                                            fontFamily: "proxima",
                                            color: lightestText,
                                            fontSize: 17)))
                              ]),
                              Column(mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                Container(
                                    child: Text(productFromServer['products'],
                                        style: TextStyle(
                                            color: darkText,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20))),
                                Container(
                                    padding: EdgeInsets.all(5.0),
                                    child: Text("Products",
                                        style: TextStyle(
                                            fontFamily: "proxima",
                                            color: lightestText,
                                            fontSize: 17)))
                              ]),
                              Column(mainAxisAlignment: MainAxisAlignment.spaceAround,children: <Widget>[
                                Stack(children: <Widget>[
                                  Container(
                                      child: isLoading
                                          ? Center(
                                              child: Image.asset(
                                              cupertinoActivityIndicator,
                                              height: 0,
                                            ))
                                          : Container(
                                              child: Text(
                                                  followersfromserver[
                                                      'total followers'],
                                                  style: TextStyle(
                                                      color: darkText,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20))))
                                ]),
                                Container(
                                    padding: EdgeInsets.all(5.0),
                                    child: Text("Resellers",
                                        style: TextStyle(
                                            fontFamily: "proxima",
                                            color: lightestText,
                                            fontSize: 17)))
                              ]),
                            ]),

                        SizedBox(height: 5),

                        Divider(
                          height: 10,
                          thickness: 1.5,
                          color: dividerColor,
                        ),

                        // Container(
                        //   child: Column(
                        //       mainAxisAlignment: MainAxisAlignment.start,
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: <Widget>[
                        //         SizedBox(height: 10),
                        //         /* Container(
                        //       child: Text(productFromServer['data']['outlet_name'],
                        //           style: TextStyle(
                        //               color: darkText,
                        //               fontWeight: FontWeight.bold,
                        //               fontSize: 15,fontFamily: "futura"))),*/
                        //         Container(
                        //             child: Text(productFromServer['data']['floor'],
                        //                 style: TextStyle(fontFamily: "proxima",color: lightestText, fontSize: 14,
                        //                 ))),
                        //         Container(
                        //             child: Text(productFromServer['data']['address'],
                        //                 style: TextStyle(fontFamily: "proxima",color: lightestText, fontSize: 14))),
                        //         Container(
                        //             child: Text(productFromServer['data']['phone'],
                        //                 style: TextStyle(fontFamily: "proxima",color: lightestText, fontSize: 14))),
                        //         Container(
                        //             child: Text(productFromServer['data']['city'],
                        //                 style: TextStyle(fontFamily: "proxima",color: lightestText, fontSize: 14))),
                        //       ]),
                        // ),
                        // SizedBox(height: 10),
                        // productFromServer['message']=="Follow"?   GestureDetector(
                        //     child: Container(
                        //         width:double.infinity,
                        //         decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(6.0),
                        //           color: Colors.pink,
                        //         ),
                        //         padding: EdgeInsets.all(5.0),
                        //         child: Center(
                        //           child: Text(productFromServer['message'],
                        //               style: TextStyle(color: white, fontSize: 16)),
                        //         )),
                        //     onTap: () {
                        //       if (productFromServer['message'] == "Follow") {
                        //         _showDialog();
                        //       } else {
                        //         unfollowDialog();
                        //       }
                        //     })
                        //     :
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: <Widget>[
                        //     Expanded(
                        //       child: GestureDetector(
                        //           child: Container(
                        //               decoration: BoxDecoration(
                        //                 borderRadius: BorderRadius.circular(6.0),
                        //                 color: Colors.pink,
                        //               ),
                        //               padding: EdgeInsets.all(5.0),
                        //               child: Center(
                        //                 child: Text(productFromServer['message'],
                        //                     style: TextStyle(color: white, fontSize: 16)),
                        //               )),
                        //           onTap: () {
                        //             if (productFromServer['message'] == "Follow") {
                        //               _showDialog();
                        //             } else {
                        //               unfollowDialog();
                        //             }
                        //           }),
                        //     ),
                        //     SizedBox(width: 10),
                        //     Expanded(
                        //         child: GestureDetector(
                        //             child: Container(
                        //                 decoration: BoxDecoration(
                        //                   borderRadius: BorderRadius.circular(6.0),
                        //                   border: Border.all(color: Colors.pink),
                        //                 ),
                        //                 padding: EdgeInsets.all(5.0),
                        //                 child: Center(
                        //                   child: Text("Message",
                        //                       style: TextStyle(
                        //                           color: Colors.pink, fontSize: 16)),
                        //                 )),
                        //             onTap: () {
                        //               if (productFromServer['message'] == "Follow") {
                        //                 _showDialog();
                        //               } else {
                        //                 unfollowDialog();
                        //               }
                        //             })),
                        //   ],
                        // ),
                        //
                        getStorestories().length == 0
                            ? Container(
                                height: 1,
                              )
                            : Container(
                                height: 90,
                                width: MediaQuery.of(context).size.width,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: getStorestories(),
                                ),
                              ),
                        SizedBox(height: 5),
                      ],
                    ),
                  ))
      ]);
    });

    return _randomChildren;
  }
}
