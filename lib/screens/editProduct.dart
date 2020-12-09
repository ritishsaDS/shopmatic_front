import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_gifs/loading_gifs.dart';
import 'package:shopmatic_front/screens/manage_products.dart';
import 'package:shopmatic_front/utils/common.dart';
import 'package:http/http.dart' as http;

import 'manage_category.dart';
import 'manage_story.dart';

class editproduct extends StatefulWidget {
   dynamic id;
   dynamic pid;
  dynamic name;
  dynamic desc;
  dynamic oprice;
  dynamic gprice;
  dynamic sprice;
  dynamic pprice;
dynamic image;
  editproduct(
      {Key key,
      this.id,
      this.name,
      this.desc,
      this.oprice,
      this.gprice,
      this.sprice,
      this.pid,
      this.image,
      this.pprice})
     ;
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
  Future<File> file1;
  Future<File> file2;
  Future<File> file3;
  String status = '';
  String base64Image="";
  String base64Image2="";
  String base64Image3="";
  String base64Image4="";
 String iid1="";
 String iid2="";
 String iid3="";
 String iid4="";
  bool ischanged=false;
  String query="";
  File tmpFile;
  String errMessage = 'Error Uploading Image';
  TextEditingController name ;
  TextEditingController cat;
  TextEditingController description ;
   TextEditingController price ;
  TextEditingController gold_price;
  TextEditingController silver_price ;
   TextEditingController pl_price ;
 

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
 name = TextEditingController(text: widget.name);
    pl_price = TextEditingController(text: widget.pprice);
    description = TextEditingController(text: widget.desc);
     price = TextEditingController(text: widget.oprice);
    silver_price = TextEditingController(text: widget.sprice);
    gold_price = TextEditingController(text: widget.gprice);
    iid1=widget.pid[0];
    iid2=widget.pid[1];
    iid3=widget.pid[2];
    iid4=widget.pid[3];
    print("bjihdsjnodsoi"+iid1.toString());
      print("bjihdsjnodsoi"+iid2.toString());
        print("bjihdsjnodsoi"+iid3.toString());
          print("bjihdsjnodsoi"+iid4.toString());
    super.initState();
  }
  
  @override
  void dispose() {
   name = TextEditingController(text: widget.name);
    cat = TextEditingController(text: widget.oprice);
    description = TextEditingController(text: widget.desc);
    super.dispose();
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
                    Column(
                      children: <Widget>[
                        Container(
                            child: TextField(
                             
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
                                     onSubmitted: (newValue) {
                    setState(() {
                      //name = newValue;
                      ischanged = false;
                    });
                  },
                       controller: name,        style: TextStyle(fontSize: 15),
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
                    width: MediaQuery.of(context).size.width * 0.48,
                    padding: EdgeInsets.only(bottom: 10),
                    color: Colors.white,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextField(
                              controller: price,
  onSubmitted: (newValue) {
                    setState(() {
                      //name = newValue;
                      ischanged = false;
                    });
                  },
                              inputFormatters: [
                                WhitelistingTextInputFormatter.digitsOnly
                              ],
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                filled: true,
                                hintText: currency+widget.oprice,
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
                              controller: gold_price,
  onSubmitted: (newValue) {
                    setState(() {
                      //name = newValue;
                      ischanged = false;
                    });
                  },
                              inputFormatters: [
                                WhitelistingTextInputFormatter.digitsOnly
                              ],
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                filled: true,
                                   hintText: currency+widget.gprice,
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
                            controller: silver_price,
  onSubmitted: (newValue) {
                    setState(() {
                      //name = newValue;
                      ischanged = false;
                    });
                  },
                              inputFormatters: [
                                WhitelistingTextInputFormatter.digitsOnly
                              ],
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                filled: true,
                                   hintText: currency+widget.sprice,
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
                              controller: pl_price,
  onSubmitted: (newValue) {
                    setState(() {
                      //name = newValue;
                      ischanged = false;
                    });
                  },
                              inputFormatters: [
                                WhitelistingTextInputFormatter.digitsOnly
                              ],
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                filled: true,
                                   hintText:currency+ widget.pprice,
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

                   
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: <Widget>[
            //     Visibility(
            //         maintainSize: false,
            //         maintainAnimation: true,
            //         maintainState: true,
            //         visible: viewVisibles,
            //         child: Container(
            //             padding: EdgeInsets.all(20.0),
            //             child: GestureDetector(
            //               child: Text(
            //                 "+ Add options (e.g.colour,size)",
            //                 style: TextStyle(
            //                     fontFamily: "ProximaNova",
            //                     fontSize: 15,
            //                     fontWeight: FontWeight.bold,
            //                     color: Colors.blue),
            //               ),
            //               onTap: () => showWidget(),
            //             ))),
            //     Visibility(
            //         maintainSize: false,
            //         maintainAnimation: true,
            //         maintainState: true,
            //         visible: viewVisible,
            //         child: Container(
            //             padding: EdgeInsets.all(20.0),
            //             child: GestureDetector(
            //               child: CircleAvatar(
            //                 backgroundColor: Colors.white10,
            //                 child: Icon(Icons.close, color: Colors.red),
            //               ),
            //               onTap: () => hideWidget(),
            //             ))),
            //   ],
            // ),
            // Visibility(
            //   maintainSize: false,
            //   maintainAnimation: true,
            //   maintainState: true,
            //   visible: viewVisible,
            //   child: Container(
            //       color: Colors.white,
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: <Widget>[
            //           TextField(
            //             onChanged: (text) {
            //               print("Text $text");
            //             },
            //             decoration: InputDecoration(
            //                 filled: true,
            //                 labelText: "Color",
            //                 labelStyle: TextStyle(
            //                     fontFamily: "ProximaNova", fontSize: 12),
            //                 fillColor: Colors.white,
            //                 prefixIcon: Icon(
            //                   Icons.image,
            //                   color: Colors.blue,
            //                 )),
            //           )
            //         ],
            //       )),
            // ),
            // Visibility(
            //   maintainSize: false,
            //   maintainAnimation: true,
            //   maintainState: true,
            //   visible: viewVisible,
            //   child: Container(
            //       color: Colors.white,
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: <Widget>[
            //           TextField(
            //             onChanged: (text) {
            //               print("Text $text");
            //             },
            //             decoration: InputDecoration(
            //                 filled: true,
            //                 labelText: "size",
            //                 labelStyle: TextStyle(
            //                     fontFamily: "ProximaNova", fontSize: 12),
            //                 fillColor: Colors.white,
            //                 prefixIcon: Icon(
            //                   Icons.image,
            //                   color: Colors.blue,
            //                 )),
            //           )
            //         ],
            //       )),
            // ),
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
                          hintText: widget.desc,
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
              margin: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.black
                ),
                child:  FlatButton(
                  child: Text("Edit Product",style:TextStyle(fontFamily: "futura",color:white))
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
       String name, String desc, base64Image, String price,String goldprice,String silverprice,String plprice) async {
    isLoading = true;
    try {
      print("josdfjhu");
      final response = await http.post(editProductApi, body: {
        "category_id": "1",
        "name": name,
        "id": widget.id,
        "description": desc,
        "price":price,
        "gold_discount":goldprice,
        "silver_discount":silverprice,
        "platinum-discount":plprice,
      
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
     String productName = name.text;
    String productDesc=description.text;

    setStatus('Uploading Image...');
    if (null == tmpFile) {
      print("ojpsdfjpoidfopj"+productDesc);
        addproduct(productName,productDesc,base64Image,price.text,gold_price.text,silver_price.text,pl_price.text);
      setStatus(errMessage);
      return;
    }
   
    print("nklssfok" + base64Image);
   // addproduct("1",productName,productDesc,base64Image);
    addimage(base64Image,base64Image2,base64Image3,base64Image4);
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
                                
                                widget.image[0]==null? Center(
                              child: Icon(Icons.add),
                        ):FadeInImage.assetNetwork(placeholder: cupertinoActivityIndicator, image: widget.image[0],fit:BoxFit.cover)
                         ]))),
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
                                
                                widget.image[1]==null? Center(
                              child: Icon(Icons.add),
                        ):FadeInImage.assetNetwork(placeholder: cupertinoActivityIndicator, image: widget.image[1],fit:BoxFit.cover)
                         ]))),
                    onTap: () {
                      setState(() {
                        file1 = ImagePicker.pickImage(source: ImageSource.gallery);
                        print("njsdfvij" + file1.toString());
                      });                },
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
                                
                                widget.image[2]==null? Center(
                              child: Icon(Icons.add),
                        ):FadeInImage.assetNetwork(placeholder: cupertinoActivityIndicator, image: widget.image[2],fit:BoxFit.cover)
                         ]))),
                    onTap: () {
                      setState(() {
                        file2 = ImagePicker.pickImage(source: ImageSource.gallery);
                        print("njsdfvij" + file2.toString());
                      });                },
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
                          fit: BoxFit.cover),
    
    
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
                                
                                widget.image[3]==null? Center(
                              child: Icon(Icons.add),
                        ):FadeInImage.assetNetwork(placeholder: cupertinoActivityIndicator, image: widget.image[3],fit:BoxFit.cover)
                         ]))),
                    onTap: () {
                      setState(() {
                        file3 = ImagePicker.pickImage(source: ImageSource.gallery);
                        print("njsdfvij" + file3.toString());
                      });                },
                  )
                ],
              );
            }
          },
        );
      }
    
       Future<void> addimage(String base64image, String base64image2, String base64image3, String base64image4)async {
    isLoading = true;
    try {
      print("josdfjhu");
      final response = await http.post(editProductimage, body: {
        "product_id":widget.id,
         "image": base64Image + ","+base64Image2+","+base64Image3+","+base64Image4,
         "id":iid1+','+iid2+","+iid3+","+iid4

         
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



 
}
