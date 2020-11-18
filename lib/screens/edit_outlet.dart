import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopmatic_front/screens/manage_products.dart';
import 'package:shopmatic_front/utils/common.dart';
import 'package:http/http.dart' as http;

import 'Home_screen.dart';

class editOutlet extends StatefulWidget{
  dynamic data;
  dynamic name;
  dynamic address;
  editOutlet({this.data,this.name,this.address});
  editoutletstate createState()=> editoutletstate(data,name,address);
}
class editoutletstate extends State<editOutlet>{
  final TextEditingController _controller = TextEditingController();
  bool isError = false;
  bool isLoading = false;
  bool viewVisible = false;
  final odata;
  final oname;
  final oaddress;
  File imageURI;
  Future<File> imageFile;
  String localImagePath;
  String caption = "";
  Future<File> file;
  String status = '';
  String base64Image;
  String name;
  String address;
  File tmpFile;
  String errMessage = 'Error Uploading Image';
  TextEditingController nameController   ;
  TextEditingController phoneController=TextEditingController()  ;
  TextEditingController addressController;
  editoutletstate(this.odata,this.oname,this.oaddress);
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

    address = oaddress;
    nameController = TextEditingController(text: name);
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
                      controller: nameController,
                      decoration: InputDecoration(
                          filled: true,
                          labelText: "Outlet Name",
                          hintText: widget.name,
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
                          controller: phoneController,

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
                        controller: addressController,



                        decoration: InputDecoration(
                          filled: true,
                          labelText: "Address",
                          hintText: widget.address,
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
                  child: Text("Edit Outlet")
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
      print(widget.data);
      final response = await http.post(editoutlet, body: {
        "outlet_name": name,
        "address": address,
        "phone": desc,
        "outlet_id": widget.data,
        "image": base64Image,
        "city":"Jalandhar",
        "state":"Punjab",
      });
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        print(responseJson.toString() + "hello");
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));

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
    String productName = nameController.text;
    String productDesc=phoneController.text;
    String adress=addressController.text;

    print("nklssfok" + base64Image);
    addproduct(productName,adress,productDesc,base64Image);
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
