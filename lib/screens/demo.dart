import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_gifs/loading_gifs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopmatic_front/screens/store_products.dart';
import 'package:shopmatic_front/screens/story.dart';
import 'package:shopmatic_front/screens/tab2.dart';
import 'package:shopmatic_front/utils/common.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:http/http.dart' as http;

import 'Grid_view.dart';
import 'Home_screen.dart';
import 'List_view.dart';
import 'followers.dart';
import 'tab1.dart';
import 'bottom_bar.dart';
import 'profile_screen.dart';
import 'store_detail.dart';

class InstaProfilePage extends StatefulWidget {
  @override
  _InstaProfilePageState createState() => _InstaProfilePageState();
}

class _InstaProfilePageState extends State<InstaProfilePage>
    with SingleTickerProviderStateMixin {
  bool isError = false;
  bool isLoading = false;
  dynamic api;
  File imageURI;
  Future<File> imageFile;
  String localImagePath;
  String caption = "";
  Future<File> file;
  String status = '';
  String base64Image;
  Color followc = Colors.pink;
  File tmpFile;
  String errMessage = 'Error Uploading Image';
  String Category = "MYShop";
  Color catColor = Colors.white;
  TabController _controller;
  String follow = "Follow";
  String id;

  TextEditingController reason = TextEditingController();

  @override
  void initState() {
    getProfile();
    getStories();
    getCategories();
    getProductsserver();
    getFollowersapi();
    _controller = new TabController(length: 2, vsync: this);
    super.initState();
  }

  double get randHeight => Random().nextInt(100).toDouble();

  List<Widget> _randomChildren;

  // Children with random heights - You can build your widgets of unknown heights here
  // I'm just passing the context in case if any widgets built here needs  access to context based data like Theme or MediaQuery
  List<Widget> _randomHeightWidgets(BuildContext context) {
    _randomChildren ??= List.generate(1, (index) {
      return SafeArea(
        child: Container(
            margin: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    getStorestories().length == 0
                        ? Container(
                            margin: EdgeInsets.only(top: 5, left: 5, right: 5),
                            height: 90,
                            width: 90,
                            child: ClipOval(
                              child: FadeInImage.assetNetwork(
                                image: productFromServer['data']['logo'],
                                placeholder: cupertinoActivityIndicator,
                                height: 80,
                                width: 70,
                                fit: BoxFit.cover,
                              ),
                            ))
                        : GestureDetector(
                            child: Container(
                                margin:
                                    EdgeInsets.only(top: 5, left: 5, right: 5),
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                        width: 2, color: Colors.pinkAccent)),
                                height: 70,
                                width: 70,
                                child: ClipOval(
                                  child: FadeInImage.assetNetwork(
                                    image: productFromServer['data']['logo'],
                                    placeholder: cupertinoActivityIndicator,
                                    height: 80,
                                    width: 70,
                                    fit: BoxFit.cover,
                                  ),
                                )),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          MoreStories(data: "23")));
                            }),
                    Column(

                        children: <Widget>[

                      Container(
                          margin: EdgeInsets.only(left: 10.0),
                          child: Text("219",
                              style: TextStyle(
                                  color: darkText,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16))),
                      Container(
                          margin: EdgeInsets.only(left: 10.0),
                          padding: EdgeInsets.all(5.0),
                          child: Text("Joined",
                              style: TextStyle(
                                  color: mostlight,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16)))
                    ]),
                    Column(children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(left: 10.0),
                          child: Text("219",
                              style: TextStyle(
                                  color: darkText,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16))),
                      Container(
                          margin: EdgeInsets.only(left: 10.0),
                          padding: EdgeInsets.all(5.0),
                          child: Text("Posts",
                              style: TextStyle(
                                  color: mostlight,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16)))
                    ]),
                    Column(children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(left: 10.0),
                          child: Text(
                              followersfromserver['total followers'].toString(),
                              style: TextStyle(
                                  color: darkText,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16))),
                      Container(
                          margin: EdgeInsets.only(left: 10.0),
                          padding: EdgeInsets.all(5.0),
                          child: Text("Followers",
                              style: TextStyle(
                                  color: mostlight,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16)))
                    ])
                  ],
                ),

                Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 10),
                          Container(
                              child: Text(
                                  productFromServer['data']['floor'],
                                  style: TextStyle(
                                      color: lightestText,
                                      fontSize: 14))),
                          Container(
                              child: Text(
                                  productFromServer['data']['phone'],
                                  style: TextStyle(
                                      color: lightestText,
                                      fontSize: 14))),
                          Container(
                              child: Text(
                                  productFromServer['data']['address'],
                                  style: TextStyle(
                                      color: lightestText,
                                      fontSize: 14))),

                        ]),
                SizedBox(height: 20),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: <Widget>[
                   GestureDetector(
                       child:Container(
                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(6.0),
                             color: followc,
                           ),
                           padding: EdgeInsets.all(5.0),
                           child: Center(
                             child: Text("          "+productFromServer['message']+"          ",
                                 style: TextStyle(
                                     color: white, fontSize: 16)),
                           )),
                       onTap:(){
                         if(productFromServer['message']=="Follow"){
                           _showDialog();
                         }else {
                           unfollowDialog();
                         }
/*                                    setState(()  {
                                        if(follow=="Follow"){

                                          getoutletStatus();
                                          follow="Followed";
                                          followc=Colors.blue;
                                        }
                                        else {
                                          follow="Follow";
                                        }
                                        getFolow();

                                      });*/
                       }
                   ),
                   SizedBox(
                       width:15
                   ),
                   GestureDetector(
                       child:Container(
                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(6.0),
                             border:Border.all(color: darkText),
                           ),
                           padding: EdgeInsets.all(5.0),
                           child: Center(
                             child: Text("          "+"Message"+"          ",
                                 style: TextStyle(
                                     color: Colors.pink, fontSize: 16)),
                           )),
                       onTap:(){
                         if(productFromServer['message']=="Follow"){
                           _showDialog();
                         }else {
                           unfollowDialog();
                         }
/*                                    setState(()  {
                                        if(follow=="Follow"){

                                          getoutletStatus();
                                          follow="Followed";
                                          followc=Colors.blue;
                                        }
                                        else {
                                          follow="Follow";
                                        }
                                        getFolow();

                                      });*/
                       }
                   ),

                 ],
               ),
                getStorestories().length == 0
                    ? Container(
                        height: 1,
                      )
                    : Container(
                        height: 70,
                        width: MediaQuery.of(context).size.width,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: getStorestories(),
                        ),
                      ),
                Row(
                  children: <Widget>[
                    Container(
                      width: 275,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.0),
                          color: lightGrey),
                      margin: EdgeInsets.only(right: 10, top: 10),
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '   Search for products....',

                          /* Container(
                                    child:Row(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children:<Widget>[
                                        Visibility(
                                          maintainState: true,
                                          visible: true,
                                          child:
                                        ),
                                        Visibility(
                                          maintainState: true,
                                           visible: true,
                                          child: IconButton(
                                              icon:Icon(Icons.close,color: Colors.black,)
                                          ),
                                        )
                                      ]
                                    )
                                  )*/
                        ),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(right: 10, top: 10),
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.0),
                          color: Colors.grey,
                        ),
                        child: GestureDetector(
                          child: Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                          onTap: () {
                            //startUpload();
                          },
                        )),
                  ],
                ),
                Container(
                    margin: EdgeInsets.all(10.0),
                    child: Text("Top Categories",
                        style: TextStyle(
                            color: darkText,
                            fontWeight: FontWeight.bold,
                            fontSize: 16))),
                Container(
                    height: 40,
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.0),
                              color: lightGrey,
                              border: Border.all(color: lightGrey)),
                          child: Center(
                              child: Text(
                            "  All  ",
                            style: TextStyle(
                                fontFamily: "proxima",
                                color: darkText,
                                fontSize: 16),
                          )),
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.73,
                            child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: getTopcategories()))
                      ],
                    )),
              ],
            )),
      );
    });

    return _randomChildren;
  }

/*
  List<Widget> show(BuildContext context){
    _randomChildren ??= ;
  }
*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Persistent AppBar that never scrolls
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        iconTheme: new IconThemeData(color: Colors.black),
        title: Text(productFromServer['data']['outlet_name'],
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15,fontFamily: "futura")),
      ),
      body: Stack(
          children: <Widget>[
      Container(
      child: isLoading
      ? Center(
          child:Image.asset(cupertinoActivityIndicator)
    )

        :DefaultTabController(
        length: 2,
        child: NestedScrollView(
          // allows you to build a list of elements that would be scrolled away till the body reached the top
          headerSliverBuilder: (context, _) {
            return [
              SliverList(
                delegate: SliverChildListDelegate(
                  _randomHeightWidgets(context),
                ),
              ),
            ];
          },
          // You tab view goes here
          body: Column(
            children: <Widget>[
              TabBar(
                tabs: [
                  Tab(
                    icon: Icon(Icons.view_module, color: Colors.black),
                  ),
                  Tab(
                    icon: Icon(Icons.list, color: Colors.black),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    GridView.count(
                      childAspectRatio:
                          MediaQuery.of(context).size.width * 0.5 / 300,
                      crossAxisCount: 2,
                      crossAxisSpacing: 1,
                      scrollDirection: Axis.vertical,
                      children: getProducts(),
                    ),
                    ListView(
                      children: getProductsL(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ))]),
      bottomNavigationBar: BottomTabs(1, true),
    );
  }

  dynamic productFromServer = new List();
  dynamic productFromdddServer = new List();
  dynamic storyfromserver = new List();
  dynamic categoryfromserver = new List();
  dynamic followersfromserver = new List();

  Future<void> getProfile() async {
    isLoading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    id = prefs.getString('intValue');
    print("isdds" + id);
    try {
      final response =
          await http.post(profileApi, body: {"outlet_id": "23", "user_id": id});
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        print(responseJson.toString() + "hello");

        productFromServer = responseJson;

        //print('jhifuh' + productFromServer.toString()); //;

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

  Future<void> getStories() async {
    isLoading = true;
    try {
      print("josdfjhu");
      final response = await http.get(
        api = StoriesApi + "23",
      );
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        print(responseJson.toString() + "hello");
        if (response.statusCode == 200) {
          storyfromserver = responseJson['data'];
          print('jhifuh' + storyfromserver.toString());
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

  List<Widget> getStorestories() {
    List<Widget> productLists = new List();
    List categories = storyfromserver as List;
    for (int i = 0; i < categories.length; i++) {
      if (i == 0) {
        productLists.add(
          GestureDetector(
              child: Container(
                  margin: EdgeInsets.only(top: 5, left: 5, right: 5),
                  height: 70,
                  width: 60,
                  child: Padding(
                    padding: EdgeInsets.only(top: 4.0, bottom: 5.0),
                    child: Container(
                        child: ClipOval(
                            child: CircleAvatar(
                                radius: 35,
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
                        builder: (context) => MoreStories(data: "23")));
              }),
        );
      } else {}
    }
    return productLists;
  }

  Future<void> getCategories() async {
    isLoading = true;
    try {
      print("josdfjhu");
      final response = await http.get(
        CategoriesApi + "23",
      );
      print("kmdfpjodfpjio" + api.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        print(responseJson.toString() + "hello");
        if (response.statusCode == 200) {
          categoryfromserver = responseJson['data'];
          print('jhifuh' + categoryfromserver.toString());
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
    List products = categoryfromserver as List;

    for (int i = 0; i < products.length; i++) {
      products[i]['isactive'] = "false";
      productLists.add(GestureDetector(
        child: Container(
          height: 30,
          margin: EdgeInsets.only(right: 10),
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.0),
              color: products[i]['isactive'] == "true" ? lightGrey : white,
              border: Border.all(color: lightGrey)),
          child: Center(
              child: Text(
            "  " +
                products[i]['category_name'].replaceAll("Fashion -", "") +
                "  ",
            style:
                TextStyle(fontFamily: "proxima", color: darkText, fontSize: 16),
          )),
        ),
        onTap: () {
          products[i]["isactive"] = "true";

          setState(() {
            if (products[i]["isactive"] == "true") {
              catColor = lightGrey;
              print(products[i]["category_id"] + "true");
            } else if (products[i]["isactive"] == "false") {
              catColor = white;

              print("false");
            }
          });
        },
      ));
    }
    return productLists;
  }

  Future<void> getemail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    id = prefs.getString('intValue');
    print("isdds" + id);
  }

  Future<void> getoutletStatus(String reason) async {
    isLoading = true;
    try {
      print("nofjkdf" + id);

      print("josdfjhu");

      final response = await http.post(followOutlet, body: {
        "user_id": id,
        "outlet_id": "23",
        "status": "1",
        "reason": reason
      });
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        print(responseJson.toString() + "hello");
        if (response.statusCode == 200) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => storeProducts(data: "23")));
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
                onPressed: () => getoutletStatus(reason.text))
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
        "outlet_id": "23",
      });
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        print(responseJson.toString() + "hello");

        followersfromserver = responseJson;

        //print('jhifuh' + productFromServer.toString()); //;

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

  Future<void> unfollow() async {
    isLoading = true;
    try {
      final response = await http
          .post(unfollowOutlet, body: {"user_id": id, "outlet_id": "23"});
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        print(responseJson.toString() + "hello");
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => storeProducts(data: "23")));

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

// productFromServer = new Listt();
      // showToast('Somehing went wrong');
    }
  }

  List<Widget> getProducts() {
    List<Widget> productLists = new List();
    List products = productFromdddServer as List;
    for (int i = 0; i < products.length; i++) {
      print("sdujh" + products.toString());
      if(productFromServer['message']=="Followed"){
      productLists.add(
          Stack(
              children: <Widget>[
          Container(
          child: isLoading
          ? Center(
              child:Image.asset(cupertinoActivityIndicator)
      )

        :GestureDetector(
         child: productFromServer['data']['outlet_group'] == "0" ? GestureDetector(
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
              ) : productFromServer['data']['outlet_group'] == "1" ?GestureDetector(
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
              ):productFromServer['data']['outlet_group']=="2"?GestureDetector(
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
              ): GestureDetector(
        child: Grid(
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
      )))]));}
      else{
        Container(
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
        );
      }
      /*GestureDetector(
          child:    Container(
              child: ListTile(
                title: Text(products[i]['name'],style: TextStyle(fontFamily: "ProximaNova",fontSize: 13),),
                */
      /*leading:  ClipRRect(
                    borderRadius: BorderRadius.circular(6.0),
                    child: FadeInImage.assetNetwork(
                      image: products[i]['image'],
                      placeholder: cupertinoActivityIndicator,
                      height: 90,
                      width: 90,
                      fit: BoxFit.cover,
                    )),*/
      /*
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

  List<Widget> getProductsL() {
    List<Widget> productLists = new List();
    List products = productFromdddServer as List;
    for (int i = 0; i < products.length; i++) {
      print("sdujh" + products.toString());
      productLists.add(GestureDetector(
        child: List_View(
            id: products[i]['id'],
            name: products[i]['name'],
            desc: products[i]['description']),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Store_detail(
                      data: products[i]['id'],
                      name: products[i]['name'],
                      description: products[i]['description'],
                    )),
          );
        },
      ));

    }
    return productLists;
  }
}
