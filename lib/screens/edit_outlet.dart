import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:loading_gifs/loading_gifs.dart';
import 'package:shopmatic_front/screens/profile_screen.dart';
import 'package:shopmatic_front/utils/common.dart';

import 'Home_screen.dart';

class editOutlet extends StatefulWidget {
  dynamic data;
  dynamic name;
  dynamic address;
  dynamic image;
  dynamic phone;
  editOutlet({this.data, this.name, this.address, this.image, this.phone});
  editoutletstate createState() => editoutletstate(data, name, address, phone);
}

class editoutletstate extends State<editOutlet> {
  final TextEditingController _controller = TextEditingController();
  bool isError = false;
  bool isLoading = false;
  bool viewVisible = false;
  final odata;
  final oname;
  final oaddress;
  final ophone;

  File imageURI;
  Future<File> imageFile;
  String localImagePath;
  String caption = "";
  Future<File> file;
  String status = '';
  String base64Image;
  String name;
  String phone;
  String address;
  File tmpFile;
  String errMessage = 'Error Uploading Image';
  TextEditingController nameController;
  TextEditingController phoneController;
  TextEditingController addressController;
  editoutletstate(this.odata, this.oname, this.oaddress, this.ophone);
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
  void initState() {
    name = oname;
    phone = ophone;
    address = oaddress;
    nameController = TextEditingController(text: name);
    phoneController = TextEditingController(text: phone);
    addressController = TextEditingController(text: address);
    super.initState();
  }

  @override
  void dispose() {
    nameController = TextEditingController(text: name);
    addressController = TextEditingController(text: address);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 2,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text("Edit Outlet",
              style: TextStyle(
                  fontSize: 16, fontFamily: "futura", color: darkText)),
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
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                          filled: true,
                          labelText: "Outlet Name",
                          hintText: widget.name,
                          labelStyle:
                              TextStyle(fontFamily: "proxima", fontSize: 12),
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
                      TextFormField(
                          controller: phoneController,
                          inputFormatters: [
                            WhitelistingTextInputFormatter.digitsOnly
                          ],
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            filled: true,
                            labelText: "Phone",
                            labelStyle:
                                TextStyle(fontFamily: "proxima", fontSize: 12),
                            fillColor: Colors.white,
                            
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
                    TextFormField(
                        controller: addressController,
                        decoration: InputDecoration(
                          filled: true,
                          labelText: "Address",
                          hintText: widget.address,
                          labelStyle:
                              TextStyle(fontFamily: "proxima", fontSize: 12),
                          fillColor: Colors.white,
                         
                        )),
                  ]),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 10),
             
              color: Colors.white,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                       decoration: new InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.grey, width: 1.0),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ), labelText: "Pin Code",
                                  labelStyle: TextStyle(color: Colors.grey),
                                  fillColor: Colors.white,
                                  border: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(8.0),
                                    borderSide: new BorderSide(),
                                  ),),)
                  ]),
            ),
            Container(
                margin: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0), color: lightGrey),
                child: FlatButton(
                  child: Text("Edit Outlet"),
                  onPressed: () {
                    startUpload();
                  },
                ))
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

  Future<void> addproduct(String name, String address, String desc) async {
    isLoading = true;
    try {
      print(widget.data);
      final response = await http.post(editoutlet, body: {
        "outlet_name": name,
        "address": address,
        "phone": desc,
        "outlet_id": widget.data,
        "short_description": "This is a heaven for faishioners ",
        "city": "Jalandhar",
        "state": "Punjab",
      });
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        print(responseJson.toString() + "hello");
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => profile()));

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
          print("njdenk");
          base64Image = base64Encode(snapshot.data.readAsBytesSync());
          return GestureDetector(
            child: Container(
                height: MediaQuery.of(context).size.height * 0.2,
                color: Colors.white10,
                child: GestureDetector(
                  child: Image.file(snapshot.data,
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fitWidth),
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
          print("njdedssdsdnk");

          return Stack(
            children: <Widget>[
              GestureDetector(
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    color: Colors.white10,
                    child: FadeInImage.assetNetwork(
                      placeholder: cupertinoActivityIndicator,
                      image: widget.image,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fitWidth,
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
    String productName = nameController.text;
    String productDesc = phoneController.text;
    String adress = addressController.text;

    setStatus('Uploading Image...');
    if (null == tmpFile) {
      addproduct(productName, adress, productDesc);
      setStatus(errMessage);
      return;
    }
  addproduct(productName, adress, productDesc);
  editImage(base64Image);
    print("nklssfok" + base64Image);
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

  Future<void> editImage(String image) async {
    isLoading = true;
    try {
      print("josdfjhu");
      final response = await http.post(editoutletImage, body: {
        "outlet_id": "23",
        "image": image,
      });
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        print(responseJson.toString() + "hello");
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => profile()));

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
}
