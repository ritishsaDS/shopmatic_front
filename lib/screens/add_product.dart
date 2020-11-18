import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopmatic_front/screens/manage_products.dart';
import 'package:shopmatic_front/utils/common.dart';
import 'package:http/http.dart' as http;

import 'manage_category.dart';

class addproduct extends StatefulWidget {
  addproductstate createState() => addproductstate();
}

class addproductstate extends State<addproduct> {
  final TextEditingController _controller = TextEditingController();
  bool isError = false;
  bool isLoading = false;
  bool viewVisible = false;
  File imageURI;
  Future<File> imageFile;
  String localImagePath;
  String caption = "";
  Future<File> file;
  Future<File> file1;
  Future<File> file2;
  Future<File> file3;
  String status = '';
  String base64Image="";
  String base64Image2="";
  String base64Image3="";
  String base64Image4="";
  File tmpFile;
  String errMessage = 'Error Uploading Image';
  TextEditingController name = TextEditingController();
  TextEditingController cat = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController gold = TextEditingController();
  TextEditingController silver = TextEditingController();
  TextEditingController platinum = TextEditingController();
  TextEditingController price = TextEditingController();

  void hideWidget() {
    setState(() {
      viewVisible = false;
      viewVisibles = true;
    });
  }

  bool viewVisibles = true;

  void showWidget() {
    setState(() {
      viewVisible = true;
      viewVisibles = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 2,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text("Add Product",
              style: TextStyle(fontSize: 16, color: darkText)),
          centerTitle: true,
          backgroundColor: white,
        ),
        body: ListView(
          children: <Widget>[
           Container(

             color: background,
             child: Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: <Widget>[
                 image1(),
                 image2(),
                 image3(),
                 image4(),
               ],
             ),
           ),
            Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextField(
                      controller: name,
                      decoration: InputDecoration(
                          filled: true,
                          labelText: "Product title",
                          labelStyle: TextStyle(
                              fontFamily: "ProximaNova", fontSize: 12),
                          fillColor: Colors.white,
                          prefixIcon: Icon(
                            Icons.image,
                            color: Colors.blue,
                          )),
                    )
                  ],
                )),
            Container(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.48,
                    padding: EdgeInsets.only(bottom: 10),
                    color: Colors.white,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextField(
                              controller: price,

                              inputFormatters: [
                                WhitelistingTextInputFormatter.digitsOnly
                              ],
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                filled: true,
                                labelText: "Original Price",
                                labelStyle: TextStyle(
                                    fontFamily: "ProximaNova", fontSize: 12),
                                fillColor: Colors.white,
                                prefixIcon: Icon(
                                  Icons.loyalty,
                                  color: Colors.blue,
                                ),
                              )),
                        ]),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.48,
                    padding: EdgeInsets.only(bottom: 10),
                    color: Colors.white,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextField(
                              controller: gold,

                              inputFormatters: [
                                WhitelistingTextInputFormatter.digitsOnly
                              ],
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                filled: true,
                                labelText: "Gold User Discount ",
                                labelStyle: TextStyle(
                                    fontFamily: "ProximaNova", fontSize: 12),
                                fillColor: Colors.white,
                                prefixIcon: Icon(
                                  Icons.content_copy,
                                  color: Colors.blue,
                                ),
                              )),
                        ]),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.48,
                    padding: EdgeInsets.only(bottom: 10),
                    color: Colors.white,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextField(
                              controller: silver,

                              inputFormatters: [
                                WhitelistingTextInputFormatter.digitsOnly
                              ],
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                filled: true,
                                labelText: "Silver User Discount",
                                labelStyle: TextStyle(
                                    fontFamily: "ProximaNova", fontSize: 12),
                                fillColor: Colors.white,
                                prefixIcon: Icon(
                                  Icons.loyalty,
                                  color: Colors.blue,
                                ),
                              )),
                        ]),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.48,
                    padding: EdgeInsets.only(bottom: 10),
                    color: Colors.white,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextField(
                              controller: platinum,

                              inputFormatters: [
                                WhitelistingTextInputFormatter.digitsOnly
                              ],
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                filled: true,
                                labelText: "Platinum User Discount",
                                labelStyle: TextStyle(
                                    fontFamily: "ProximaNova", fontSize: 12),
                                fillColor: Colors.white,
                                prefixIcon: Icon(
                                  Icons.content_copy,
                                  color: Colors.blue,
                                ),
                              )),
                        ]),
                  ),
                ],
              ),
            ),

            Container(
              padding: EdgeInsets.only(bottom: 10),
              color: Colors.white,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextField(
                        inputFormatters: [
                          WhitelistingTextInputFormatter.digitsOnly
                        ],
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          filled: true,
                          labelText: "Stock Quantity",
                          labelStyle: TextStyle(
                              fontFamily: "ProximaNova", fontSize: 12),
                          fillColor: Colors.white,
                          prefixIcon: Icon(
                            Icons.content_copy,
                            color: Colors.blue,
                          ),
                        )),
                  ]),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Visibility(
                    maintainSize: false,
                    maintainAnimation: true,
                    maintainState: true,
                    visible: viewVisibles,
                    child: Container(
                        padding: EdgeInsets.all(20.0),
                        child: GestureDetector(
                          child: Text(
                            "+ Add options (e.g.colour,size)",
                            style: TextStyle(
                                fontFamily: "ProximaNova",
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue),
                          ),
                          onTap: () => showWidget(),
                        ))),
                Visibility(
                    maintainSize: false,
                    maintainAnimation: true,
                    maintainState: true,
                    visible: viewVisible,
                    child: Container(
                        padding: EdgeInsets.all(20.0),
                        child: GestureDetector(
                          child: CircleAvatar(
                            backgroundColor: Colors.white10,
                            child: Icon(Icons.close, color: Colors.red),
                          ),
                          onTap: () => hideWidget(),
                        ))),
              ],
            ),
            Visibility(
              maintainSize: false,
              maintainAnimation: true,
              maintainState: true,
              visible: viewVisible,
              child: Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextField(
                        onChanged: (text) {
                          print("Text $text");
                        },
                        decoration: InputDecoration(
                            filled: true,
                            labelText: "Color",
                            labelStyle: TextStyle(
                                fontFamily: "ProximaNova", fontSize: 12),
                            fillColor: Colors.white,
                            prefixIcon: Icon(
                              Icons.image,
                              color: Colors.blue,
                            )),
                      )
                    ],
                  )),
            ),
            Visibility(
              maintainSize: false,
              maintainAnimation: true,
              maintainState: true,
              visible: viewVisible,
              child: Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextField(
                        onChanged: (text) {
                          print("Text $text");
                        },
                        decoration: InputDecoration(
                            filled: true,
                            labelText: "size",
                            labelStyle: TextStyle(
                                fontFamily: "ProximaNova", fontSize: 12),
                            fillColor: Colors.white,
                            prefixIcon: Icon(
                              Icons.image,
                              color: Colors.blue,
                            )),
                      )
                    ],
                  )),
            ),
            Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextField(
                      controller: description,
                      onChanged: (text) {
                        print("Text $text");
                      },
                      decoration: InputDecoration(
                          filled: true,
                          labelText: "Product Description",
                          labelStyle: TextStyle(
                              fontFamily: "ProximaNova", fontSize: 12),
                          fillColor: Colors.white,
                          prefixIcon: Icon(
                            Icons.image,
                            color: Colors.blue,
                          )),
                    )
                  ],
                )),
            Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextField(
                      controller: cat,
                      onChanged: (text) {
                        print("Text $text");
                      },
                      decoration: InputDecoration(
                          filled: true,
                          labelText: "Category",
                          labelStyle: TextStyle(
                              fontFamily: "ProximaNova", fontSize: 12),
                          fillColor: Colors.white,
                          prefixIcon: Icon(
                            Icons.image,
                            color: Colors.blue,
                          )),
                    )
                  ],
                )),
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: lightGrey
                ),
                child:  FlatButton(
                  child: Text("Add Product")
                  ,onPressed: (){
                 startUpload();
                },
                )
            )
          ],
        ));
  }

  Future getImageFromGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      print(image.path);
      String userName = image.path;
    }

    setState(() {
      imageURI = image;
    });
  }

  Future<void> addproduct(
      String category, String name, String desc,String price, String gold, String silver,String platinum, base64Image,base64Image1,base64Image2,base64Image3) async {
    isLoading = true;
    try {
      print("josdfjhu");
      final response = await http.post(addProductApi, body: {
        "category_id": "1",
        "name": name,
        "outlet_id": "23",
        "description": desc,
        "image": base64Image + ","+base64Image1+","+base64Image2+","+base64Image3,
        "silver_discount":silver,
        "gold_discount":gold,
        "platinum_discount":platinum,
        "price":price,


      });
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        print(responseJson.toString() + "hello");
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>manageproducts()));

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

  Widget image1() {
    return FutureBuilder<File>(
      future: file,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          tmpFile = snapshot.data;
          print("njdenk" );
          base64Image = base64Encode(snapshot.data.readAsBytesSync());
          return GestureDetector(
            child: Container(
              margin: EdgeInsets.all(5.0),
                width: 75,
                height: 78,
                color: Colors.white10,
                child: GestureDetector(
                  child: Image.file(snapshot.data,
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fitHeight),


                  onTap: () {
                    chooseImage();
                  },
                )),
          );
        } else if (null != snapshot.error) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          print("njdedssdsdnk" );

          return Stack(
            children: <Widget>[
              GestureDetector(
                child: Card(
                    child: Container(

                      width: 75,
                      height: 78,

                      child: Stack(
                          children: <Widget>[
                      Center(
                          child: Icon(Icons.add),
                    )]))),
                onTap: () {
                  setState(() {
                    file = ImagePicker.pickImage(source: ImageSource.gallery);
                    print("njsdfvij" + file.toString());
                  });                },
              )
            ],
          );
        }
      },
    );
  }
  Widget image2() {
    return FutureBuilder<File>(
      future: file1,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          tmpFile = snapshot.data;
          print("njdenk" );
          base64Image2 = base64Encode(snapshot.data.readAsBytesSync());
          return GestureDetector(
            child: Container(
                margin: EdgeInsets.all(5.0),
                width: 75,
                height: 78,
                color: Colors.white10,
                child: GestureDetector(
                  child: Image.file(snapshot.data,
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fitHeight),


                  onTap: () {
                    setState(() {
                      file1 = ImagePicker.pickImage(source: ImageSource.gallery);
                      print("njsdfvij" + file.toString());
                    });
                  },
                )),
          );
        } else if (null != snapshot.error) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          print("njdedssdsdnk" );

          return Stack(
            children: <Widget>[
              GestureDetector(
                child: Card(
                    child: Container(

                        width: 75,
                        height: 78,

                        child: Stack(
                            children: <Widget>[
                              Center(
                                child: Icon(Icons.add),
                              )]))),
                onTap: () {
                  setState(() {
                    file1 = ImagePicker.pickImage(source: ImageSource.gallery);
                    print("njsdfvij" + file.toString());
                  });
                },
              )
            ],
          );
        }
      },
    );
  }

  Widget image3(){
    return FutureBuilder<File>(
      future: file2,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          tmpFile = snapshot.data;
          print("njdenk" );
          base64Image3 = base64Encode(snapshot.data.readAsBytesSync());
          return GestureDetector(
            child: Container(
                margin: EdgeInsets.all(5.0),
                width: 75,
                height: 78,
                color: Colors.white10,
                child: GestureDetector(
                  child: Image.file(snapshot.data,
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fitHeight),


                  onTap: () {
                    setState(() {
                      file2 = ImagePicker.pickImage(source: ImageSource.gallery);
                      print("njsdfvij" + file.toString());
                    });
                  },
                )),
          );
        } else if (null != snapshot.error) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          print("njdedssdsdnk" );

          return Stack(
            children: <Widget>[
              GestureDetector(
                child: Card(
                    child: Container(

                        width: 75,
                        height: 78,

                        child: Stack(
                            children: <Widget>[
                              Center(
                                child: Icon(Icons.add),
                              )]))),
                onTap: () {
                  setState(() {
                    file2 = ImagePicker.pickImage(source: ImageSource.gallery);
                    print("njsdfvij" + file.toString());
                  });
                },
              )
            ],
          );
        }
      },
    );
  }
  Widget image4(){
    return FutureBuilder<File>(
      future: file3,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          tmpFile = snapshot.data;
          print("njdenk" );
          base64Image4 = base64Encode(snapshot.data.readAsBytesSync());
          return GestureDetector(
            child: Container(
                margin: EdgeInsets.all(5.0),
                width: 75,
                height: 78,
                color: Colors.white10,
                child: GestureDetector(
                  child: Image.file(snapshot.data,
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fitHeight),


                  onTap: () {
                    setState(() {
                      file3 = ImagePicker.pickImage(source: ImageSource.gallery);
                      print("njsdfvij" + file.toString());
                    });
                  },
                )),
          );
        } else if (null != snapshot.error) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          print("njdedssdsdnk" );

          return Stack(
            children: <Widget>[
              GestureDetector(
                child: Card(
                    child: Container(

                        width: 75,
                        height: 78,

                        child: Stack(
                            children: <Widget>[
                              Center(
                                child: Icon(Icons.add),
                              )]))),
                onTap: () {
                  setState(() {
                    file3 = ImagePicker.pickImage(source: ImageSource.gallery);
                    print("njsdfvij" + file.toString());
                  });
                },
              )
            ],
          );
        }
      },
    );
  }

  startUpload() {
    setStatus('Uploading Image...');
    if (null == tmpFile) {
      setStatus(errMessage);
      return;
    }
    String productName = name.text;
    String productDesc=description.text;
    String oprice=price.text;
    String dgold=gold.text;
    String dsilver=silver.text;
    String dplatinum=platinum.text;


    addproduct("1",productName,productDesc,oprice,dgold,dsilver,dplatinum,base64Image,base64Image2,base64Image3,base64Image4);
  }

  chooseImage() {
    setState(() {
      file = ImagePicker.pickImage(source: ImageSource.gallery);
      print("njsdfvij" + file.toString());
    });
    setStatus('');
  }

  setStatus(String message) {
    setState(() {
      status = message;
    });
  }
}
