import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopmatic_front/screens/manage_products.dart';
import 'package:shopmatic_front/utils/common.dart';
import 'package:http/http.dart' as http;

class addOutlet extends StatefulWidget{
  outletstate createState()=> outletstate();
}
class outletstate extends State<addOutlet>{
  final TextEditingController _controller = TextEditingController();
  bool isError = false;
  bool isLoading = false;
  bool viewVisible = false;
  File imageURI;
  Future<File> imageFile;
  String localImagePath;
  String caption = "";
  Future<File> file;
  String status = '';
  String base64Image;
  File tmpFile;
  String errMessage = 'Error Uploading Image';
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();

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
            showImage(),
            Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextField(
                      controller: name,
                      decoration: InputDecoration(
                          filled: true,
                          labelText: "Outlet Name",
                          labelStyle: TextStyle(
                              fontFamily: "proxima", fontSize: 12),
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
              child: Container(
                width: MediaQuery.of(context).size.width * 0.45,
                padding: EdgeInsets.only(bottom: 10),
                color: Colors.white,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextField(
                          controller: phone,

                          inputFormatters: [
                            WhitelistingTextInputFormatter.digitsOnly
                          ],
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            filled: true,
                            labelText: "Phone",
                            labelStyle: TextStyle(
                                fontFamily: "proxima", fontSize: 12),
                            fillColor: Colors.white,
                            prefixIcon: Icon(
                              Icons.loyalty,
                              color: Colors.blue,
                            ),
                          )),
                    ]),
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 10),
              color: Colors.white,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextField(
                        controller: address,

                        inputFormatters: [
                          WhitelistingTextInputFormatter.digitsOnly
                        ],

                        decoration: InputDecoration(
                          filled: true,
                          labelText: "Address",
                          labelStyle: TextStyle(
                              fontFamily: "proxima", fontSize: 12),
                          fillColor: Colors.white,
                          prefixIcon: Icon(
                            Icons.content_copy,
                            color: Colors.blue,
                          ),
                        )),
                  ]),
            ),

            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: lightGrey
                ),
                child:  FlatButton(
                  child: Text("Add Outlet")
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
       String name,String address, String desc, base64Image) async {
    isLoading = true;
    try {
      print("josdfjhu");
      final response = await http.post(addOutletApi, body: {
        "outlet_name": name,
        "address": address,
        "phone": desc,
        "place_id":"1",
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
    String productDesc=phone.text;
    String adress=address.text;

    print("nklssfok" + base64Image);
    addproduct(productName,productDesc,adress,base64Image);
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
