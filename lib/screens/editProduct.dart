import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopmatic_front/screens/manage_products.dart';
import 'package:shopmatic_front/utils/common.dart';
import 'package:http/http.dart' as http;

import 'manage_category.dart';
import 'manage_story.dart';

class editproduct extends StatefulWidget {
  dynamic name;
  dynamic description;
  dynamic id;
  dynamic image;
  editproduct({this.name,this.description,this.id,this.image});
  editproductstate createState() => editproductstate();
}

class editproductstate extends State<editproduct> {
  final TextEditingController _controller = TextEditingController();
  bool isError = false;
  bool isLoading = false;
  bool viewVisible = false;
  File imageURI;
  Future<File> imageFile;
  String localImagePath;
  Future<File> file;
  String base64Image;
  bool ischanged=false;
  String query="";
  File tmpFile;
  String errMessage = 'Error Uploading Image';
  TextEditingController name = TextEditingController();
  TextEditingController cat = TextEditingController();
  TextEditingController description = TextEditingController();

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
  } @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
query=widget.name;
    return Scaffold(
        appBar: AppBar(
          elevation: 2,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text("Edit Product",
              style: TextStyle(fontSize: 16, color: darkText)),
          centerTitle: true,
          backgroundColor: white,
        ),
        body: ListView(
          children: <Widget>[
            showImage(),
            Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                            child: TextField(
                              controller: name,
                              //textCapitalization: TextCapitalization.characters,

                              decoration: InputDecoration(
                                  filled: true,
                                  hintText: widget.name,
                                  labelText: "Product title",
                                  labelStyle: TextStyle(
                                      fontFamily: "ProximaNova", fontSize: 12),
                                  fillColor: Colors.white,
                                  prefixIcon: Icon(
                                    Icons.image,
                                    color: Colors.blue,
                                  )),
                              style: TextStyle(fontSize: 15),
                            ),

                        ),

                       /* TextField(
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
                        ),*/
                      ],
                    ),
                   /* TextField(
                      controller: name,
                      enabled: true,
                      //textCapitalization: TextCapitalization.characters,
                      onChanged: (text) {
                        query = text;
                        // print(query);
                        ischanged = true;
                      },
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
                    )*/
                  ],
                )),
            Container(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.45,
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
                                labelText: "Selling Price",
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
                    width: MediaQuery.of(context).size.width * 0.45,
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
                                labelText: "Original Price",
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
                          hintText: widget.description,
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
                  child: Text("Edit Product")
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
      String category, String name, String desc, base64Image) async {
    isLoading = true;
    try {
      print("josdfjhu");
      final response = await http.post(editProductApi, body: {
        "category_id": "1",
        "name": name,
        "id": widget.id,
        "description": desc,
        "image": base64Image
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

  Widget showImage() {
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
                height: MediaQuery.of(context).size.height * 0.2,
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
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    color: Colors.white10,
                    child: Center(
                        child:Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.add_photo_alternate,size: 55,),
                            Text("Tap to add image ",style: TextStyle(fontFamily: "proxima",fontSize: 16),)
                          ],
                        )
                    )),
                onTap: () {
                  chooseImage();
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

    print("nklssfok" + base64Image);
    addproduct("1",productName,productDesc,base64Image);
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
