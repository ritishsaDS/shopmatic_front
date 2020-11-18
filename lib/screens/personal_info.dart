import 'dart:io';
import 'dart:convert';
import 'package:badges/badges.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_gifs/loading_gifs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopmatic_front/screens/personal_info.dart';
import 'package:shopmatic_front/screens/store_products.dart';
import 'package:shopmatic_front/screens/tile.dart';
import 'package:shopmatic_front/screens/userprofile.dart';
import 'package:shopmatic_front/utils/common.dart';
import 'package:http/http.dart' as http;

import 'bottom_bar.dart';
import 'cart.dart';

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  dynamic username;
  dynamic userphone;
  dynamic useremail;
  dynamic useradd;
  dynamic image;

  EditProfilePage(
      {this.username,
      this.userphone,
      this.useremail,
      this.useradd,
      this.image});

  @override
  _EditProfilePageState createState() =>
      _EditProfilePageState(username, userphone, useremail, useradd, image);
}

class _EditProfilePageState extends State<EditProfilePage> {
  Future<File> file;
  String status = '';
  String base64Image;
  File tmpFile;
  String errMessage = 'Error Uploading Image';

  bool isError = false;
  bool isLoading = false;
  String id = "";
  String name = "";
  String email = "";
  String phone = "";
  String address = "";
  bool images =true;
  bool _isEditingText = false;
  TextEditingController namecontroller;
  TextEditingController emailcontroller;
  TextEditingController phonecontroller;
  TextEditingController addresscontroller;
  final username;
  final userphone;
  final useremail;
  final useradd;
  final image;

  var uploadEndPoint;

  _EditProfilePageState(
      this.username, this.userphone, this.useremail, this.useradd, this.image);

  @override
  void initState() {
    getSingleProduct();
    name = username;
    email = useremail;
    phone = userphone;
    address = useradd;
    namecontroller = TextEditingController(text: name);
    emailcontroller = TextEditingController(text: email);
    phonecontroller = TextEditingController(text: phone);
    addresscontroller = TextEditingController(text: address);
    super.initState();
  }

  @override
  void dispose() {
    namecontroller.dispose();
    emailcontroller = TextEditingController(text: email);
    phonecontroller = TextEditingController(text: phone);
    addresscontroller = TextEditingController(text: address);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: white,
        title: Text(
          "Edit Profile",
          style: TextStyle(color: darkText),
        ),
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () {},
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              SizedBox(
                height: 15,
              ),
              showImage(),
              SizedBox(
                height: 35,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 35.0),
                child: TextField(
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 3),
                      labelText: "Full Name",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )),
                  onSubmitted: (newValue) {
                    setState(() {
                      name = newValue;
                      _isEditingText = false;
                    });
                  },
                  autofocus: true,
                  controller: namecontroller,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 35.0),
                child: TextField(
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 3),
                      labelText: "Email",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )),
                  onSubmitted: (newValue) {
                    setState(() {
                      email = newValue;
                      _isEditingText = false;
                    });
                  },
                  autofocus: true,
                  controller: emailcontroller,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 35.0),
                child: TextField(
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 3),
                      labelText: "Phone",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )),
                  onSubmitted: (newValue) {
                    setState(() {
                      phone = newValue;
                      _isEditingText = false;
                    });
                  },
                  autofocus: true,
                  controller: phonecontroller,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 35.0),
                child: TextField(
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 3),
                      labelText: "Address",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )),
                  onSubmitted: (newValue) {
                    setState(() {
                      address = newValue;
                      _isEditingText = false;
                    });
                  },
                  autofocus: true,
                  controller: addresscontroller,
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlineButton(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () {
                    },
                    child: Text("CANCEL",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.black)),
                  ),
                  RaisedButton(
                    onPressed: () {
                      editprofile(namecontroller.text, emailcontroller.text,
                          phonecontroller.text, addresscontroller.text);
                      startUpload();

                    },
                    color: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      "SAVE",
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.white),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  dynamic productFromServer = new List();

  Future<void> getSingleProduct() async {
    isLoading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString('intValue');
    try {
      final response = await http.post(getuserprofile, body: {"user_id": id});
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        print(responseJson.toString() + "hello");

        productFromServer = responseJson;

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

  Future<void> editprofile(
      String name, String email, String phone, String address) async {
    isLoading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString('intValue');
    try {
      final response = await http.post(editprofileapi, body: {
        "user_id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "address": address,
        "gender": "1",
        "image": productFromServer["data"]['image']
      });
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        print(responseJson.toString() + "hello");

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => userProfile()));
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

  chooseImage() {
    images=true;
    setState(() {
      file = ImagePicker.pickImage(source: ImageSource.gallery);
    });
    setStatus('');
  }

  setStatus(String message) {
    setState(() {
      status = message;
    });
  }

  startUpload() {
    setStatus('Uploading Image...');
    if (null == tmpFile) {
      setStatus(errMessage);
      return;
    }
    String fileName = tmpFile.path.split('/').last;
    upload(fileName);
  }

  upload(String fileName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString('intValue');
    http.post(editprofileimageapi, body: {
      "image": base64Image,
      "user_id": id,
    }).then((result) {
      setStatus(result.statusCode == 200 ? result.body : errMessage);
    }).catchError((error) {
      setStatus(error);
    });
  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: file,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          tmpFile = snapshot.data;
          base64Image = base64Encode(snapshot.data.readAsBytesSync());
          return Center(
            child: Stack(
              children: [
                Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 4,
                        color: Theme.of(context).scaffoldBackgroundColor),
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 2,
                          blurRadius: 10,
                          color: Colors.black.withOpacity(0.1),
                          offset: Offset(0, 10))
                    ],
                    shape: BoxShape.circle,
                  ),
                  child: Image.file(
                    snapshot.data,
                  ),
                ),
                Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 4,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                        color: Colors.green,
                      ),
                      child: GestureDetector(
                        child:Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),onTap: (){
                        chooseImage();
                      },
                      )
                    )),
              ],
            ),
          );
        } else if (null != snapshot.error) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return Center(
            child: Stack(
              children: [
                Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 4,
                          color: Theme.of(context).scaffoldBackgroundColor),
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.1),
                            offset: Offset(0, 10))
                      ],
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            image,
                          ))),
                ),
                Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 4,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                        color: Colors.green,
                      ),
                      child:  GestureDetector(
                        child:Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),onTap: (){
                        chooseImage();
                      },
                      )
                    )),
              ],
            ),
          );
        }
      },
    );
  }
}
