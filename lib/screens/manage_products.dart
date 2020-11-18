import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_gifs/loading_gifs.dart';
import 'package:shopmatic_front/utils/common.dart';

import 'add_product.dart';
import 'editProduct.dart';
import 'manage_productListing.dart';

class manageproducts extends StatefulWidget {
  /*dynamic image ;
  dynamic name;
  dynamic description;

  manageproducts({Key key, this.image,this.name,this.description}) : super(key: key);*/

  stateproducts createState() => stateproducts();
}

class stateproducts extends State<manageproducts> {
  bool viewVisible = false;
  File imageURI;

  bool viewVisibles = true;
  String base64Image;

  void showWidget() {
    setState(() {
      viewVisible = true;
      viewVisibles = false;
    });
  }

  @override
  void initState() {
    getProductsserver();

    super.initState();
  }

  bool isError = false;
  bool isLoading = false;
  Future<File> file;

  @override
  Widget build(BuildContext context) {
    // var myFile = new File(widget.image);

    return (Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Add Product",
          style: TextStyle(fontSize: 16, color: darkText),
        ),
        backgroundColor: white,
      ),
      body: ListView(children: getProducts()),
      floatingActionButton: Container(
        margin: EdgeInsets.only(left: 50, right: 30),
        width: MediaQuery.of(context).size.width,
        child: FloatingActionButton.extended(
          backgroundColor: const Color(0xff03dac6),
          foregroundColor: Colors.black,
          onPressed: () {
            /* Codec<String, String> stringToBase64 = utf8.fuse(base64);
            base64Image = base64Encode(imageURI.readAsBytesSync());
            addproduct(cat.text, name.text, description.text, base64Image);*/
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => addproduct()));
          },
          icon: Icon(Icons.add),
          label: Text(' Add Product '),
        ),
      ),
    ));
  }

  dynamic productFromServer = new List();

  Future<void> getProductsserver() async {
    isLoading = true;
    try {
      print("josdfhbvfghbhzsjhu");
      final response = await http.get(
        ProductsApi + "23",
      );
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
          product_listing(id:products[i]['id'],name:products[i]['name'],desc:products[i]['description'])
      );
    }
    return productLists;
  }

}
