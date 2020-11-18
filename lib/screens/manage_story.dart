import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_gifs/loading_gifs.dart';
import 'package:shopmatic_front/screens/show_image.dart';
import 'package:shopmatic_front/screens/story.dart';
import 'package:shopmatic_front/utils/common.dart';
class manageStory extends StatefulWidget {
  storystate createState() => storystate();

}
bool isError = false;
bool isLoading = false;
dynamic api;
File imageURI;
Future<File> imageFile;
String localImagePath;
Future<File> file;

String caption = "";
String status = '';
String base64Image;
String errMessage = 'Error Uploading Image';
String Category = "MYShop";


class storystate extends State<manageStory> {
  @override
  void initState() {
    getStories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: white,

        iconTheme: new IconThemeData(color: Colors.black),

        title: Text("My Stories", style: TextStyle(color: darkText)),
      ),
      body:Stack(children: <Widget>[
      Container(
      child: isLoading
      ? Center(child: Image.asset(cupertinoActivityIndicator))
        : getStorestories().length==0?Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 100,
            ),
            Center(
              child: Image.asset("assets/images/folloe.png"),
            ),
            SizedBox(
              height: 10,
            ),
            Text("sorry..\n No story added by you",style: TextStyle(color: darkText,fontFamily: "proxima",fontSize: 20),),
            Center(
              child: GestureDetector(
                  child:Container(
                    width: 200,
                    margin: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.0)
                          ,
                          border: Border.all(color: Colors.blue)
                      ),
                      padding: EdgeInsets.all(5.0),
                      child: Center(
                        child: Text("   "+"Add Story"+"   ",
                            style: TextStyle(
                                color: Colors.blue, fontSize: 16)),
                      )),
                  onTap:(){
                    getImageFromGallery();

                  }
              ),
            )
          ],
        ),
      ):Container(
          child: Stack(
            children: <Widget>[
              ListView(
                children: getStorestories(),
              ),
            ],
          )
      ),)]),
      floatingActionButton: FloatingActionButton(
          child: GestureDetector(
            child: Icon(Icons.camera), onTap: () {
            getImageFromGallery();
          },
          )
      ),
    );
  }

  dynamic productFromServer = new List();
  dynamic storyfromserver = new List();
  dynamic productfromserver = new List();
  dynamic categoryfromserver = new List();


  Future<void> getStories() async {
    isLoading = true;
    try {
      print("josdfjhu");
      final response = await http.get(
        api = StoriesApi + "23",
      );
      print("kmdfpjodfpjio" + api.toString());
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
      print("sdujh" + categories.toString());
      productLists.add(
        GestureDetector(
            child: Container(
              margin: EdgeInsets.only(top: 5, left: 5, right: 5),
              width: 60,
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Row(
                        children: <Widget>[

                          Container(
                              margin: EdgeInsets.all(10.0),
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(categories[i]['caption']),
                              SizedBox(
                                height: 5,
                              ),
                              Text(categories[i]['views']+" Views",style:TextStyle(color:lightestText)),
                            ],
                          )
                        ],
                      ),
                      Positioned(
                          right: 0,
                          top: 0,
                          child: GestureDetector(
                            child: PopupMenuButton(
                                itemBuilder: (context) {
                                  return <PopupMenuItem>[
                                    PopupMenuItem(child:
                                    GestureDetector(
                                      child: Text('Delete'),
                                      onTap: () {
                                        setState(() {
                                          deleteAlbum(
                                              categories[i]['story_id']);
                                        });
                                      },


                                    ))
                                  ];
                                },
                                child: Icon(Icons.more_vert, color: darkText,

                                )
                            ), onTap: () {},
                          )

                      )
                    ],
                  ),
                  Divider(
                    height: 10,
                    thickness: 1.5,
                    color: dividerColor,
                  )
                ],
              ),
            ),
            onTap: () {
               Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MoreStories(data: api)));
            }),
      );
    }
    return productLists;
  }

  Future<void> deleteAlbum(String id) async {
    isLoading = true;
    try {
      print("josdfjhu");
      final response = await http.post(
        deleteStory + id,
      );
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        print(responseJson.toString() + "hello");
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>manageStory()));
        setState(() {
          isError = false;
          isLoading = false;
          print('setstate');
        });

        /*setState(() {
          getCategories();
        });*/
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

  Future getImageFromGallery() async {
    file =  ImagePicker.pickImage(source: ImageSource.gallery);

      Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => show(file)),
      );
    }


  }


