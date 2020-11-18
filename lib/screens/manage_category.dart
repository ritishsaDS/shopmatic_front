import 'dart:convert';
import 'dart:ui';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:loading_gifs/loading_gifs.dart';
import 'package:shopmatic_front/utils/common.dart';

import 'add_category.dart';
import 'bottom_bar.dart';

class manageCategory extends StatefulWidget {
  StatemanageCategory createState() => StatemanageCategory();
}

class StatemanageCategory extends State<manageCategory> {
  bool isError = false;
  bool isLoading = false;

  @override
  void initState() {
    setState(() {
      getCategories();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(children: <Widget>[
        Container(
        child: isLoading
        ? Center(child: Image.asset(cupertinoActivityIndicator))
            :ListView(children: getTopcategory()))]),
        bottomNavigationBar: BottomTabs(5,true),
        floatingActionButton: Container(
          margin: EdgeInsets.only(left: 50, right: 30),
          width: MediaQuery.of(context).size.width,
          child: FloatingActionButton.extended(
            backgroundColor: const Color(0xff03dac6),
            foregroundColor: Colors.black,
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => addcategory()));
            },
            icon: Icon(Icons.add),
            label: Text(' Add Categories '),
          ),
        ),
      ),
    );
  }

  dynamic categoryfromserver = new List();

  Future<void> getCategories() async {
    isLoading = true;
    try {
      print("josdfjhu");
      final response = await http.get(
        CategoriesApi + "23",
      );
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

  List<Widget> getTopcategory() {
    List<Widget> productLists = new List();
    List products = categoryfromserver as List;
    for (int i = 0; i < products.length; i++) {
      print("sdujh" + products.toString());
      productLists.add(Stack(
        children: <Widget>[
          Container(
              margin: EdgeInsets.all(10.0),
              padding: EdgeInsets.all(10.0),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color:mostlight)),
              child: Center(
                child: Text(
                  "  " +
                      products[i]['category_name'].replaceAll("Fashion -", "") +
                      "  ",
                  style: TextStyle(
                      color: darkText, fontSize: 40, fontFamily: "proxima"),
                ),
              )),
          Positioned(
            right: 15,
            top: 20,
            child: GestureDetector(
              child: PopupMenuButton(
                  itemBuilder: (context) {
                    return <PopupMenuItem>[ PopupMenuItem(child: GestureDetector(
                      child: Text('Edit'),
                      onTap: () {

                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => addcategory(
                                  text:"Edit Category",
                                    id: products[i]['category_id'],
                                   /* name: products[i]['category_name'],*/
                                   )));
                      },
                    )),
                      PopupMenuItem(child:
                                  GestureDetector(
                                    child:  Text('Delete'),
                                    onTap: () {
                                      setState(() {
                                            deleteAlbum(products[i]['category_id']);
                                      });
                                    },




                          ))];
                  },
                child:Icon(Icons.more_vert,              color:darkText,

                )
              ),onTap: (){
            },
            )

          )
        ],
      ));
    }
    return productLists;
  }

  Future<void> deleteAlbum(String id) async {
    isLoading = true;
    try {
      print("josdfjhu");
      final response = await http.post(
        deleteCategory + id,

      );
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        print(responseJson.toString() + "hello");
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>manageCategory()));

        setState(() {
          isError = false;
          isLoading = false;
          print('setstate');
        });

        setState(() {
          getCategories();
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
