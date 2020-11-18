import 'package:flutter/material.dart';
import 'package:shopmatic_front/utils/common.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'manage_story.dart';

class show extends StatefulWidget {
  Future<File> image;

  show(this.image);
  showstate createState()=> showstate(image);


}

class showstate extends State<show>{
   String userName;
  bool isError = false;
  bool isLoading = false;
   final Future<File> image;
  String encoded;
  String filename;
  String status = '';
  String base64Image;
  File tmpFile;
  String errMessage = 'Error Uploading Image';
  final TextEditingController _controller = TextEditingController();
  showstate(this.image);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
backgroundColor: Colors.black,
        body:   Container(
            child: ListView(
              children: <Widget>[
                showImage(),

                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                    Container(
                      width:MediaQuery.of(context).size.width-80,
                     child: TextField(
                        controller: _controller,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(

                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(top:20,left:10),
                          hintText: 'Enter Your Caption.....',hintStyle: TextStyle(color: white,fontSize: 16),


                          /* Container(
                                  child:Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children:<Widget>[
                                      Visibility(
                                        maintainState: true,
                                        visible: true,
                                        child:
                                      ),
                                      Visibility(
                                        maintainState: true,
                                         visible: true,
                                        child: IconButton(
                                            icon:Icon(Icons.close,color: Colors.black,)
                                        ),
                                      )
                                    ]
                                  )
                                )*/
                        ),
                      ),
                    ),
                      Container(
                        width: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40.0),
                            color:Colors.blue
                        ),
                        child: IconButton(icon:Icon(Icons.send,size:30,color: white,),onPressed: (){
                          isLoading=true;

                          startUpload( _controller.text);
                        },),
                      )
                    ],
                  ),
                ),

              ],
            )
        ),
    );
  }
  setStatus(String message) {
    setState(() {
      status = message;
    });
  }
   startUpload(String filename) {
     setStatus('Uploading Image...');
     if (null == tmpFile) {
       setStatus(errMessage);
       return;
     }

     print("["+base64Image+"]");
 getStories(filename);
  }

  Future<void> getStories(String fileName) async {
    try {
      print("josdfjhu");
      final response = await http.post(
        addstories ,body: {
        "image": base64Image,
        "caption": fileName,

      }
      );
      print("nkdbnk"+response.statusCode.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        print(responseJson.toString() + "hello");
Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>manageStory()));
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
      future: image,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (image!=null) {
          tmpFile = snapshot.data;
          base64Image = base64Encode(snapshot.data.readAsBytesSync());
          return GestureDetector(
            child: Container(
                margin: EdgeInsets.only(top: 5, left: 5, right: 5),
                height: MediaQuery.of(context).size.height-120,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                    padding: EdgeInsets.only(top: 4.0, bottom: 5.0),
                    child: Container(
                        height: MediaQuery.of(context).size.height-70,
                        width: MediaQuery.of(context).size.width,
                        child:  Image.file(snapshot.data,

                            height: MediaQuery.of(context).size.height-70,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.fitWidth)
                    ),)),
          );
        } else if (image==null) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          print("nkldfkgl"+image.toString());
          return image !=null ?Container(
              margin: EdgeInsets.only(top: 5, left: 5, right: 5),
              height: MediaQuery.of(context).size.height-120,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: EdgeInsets.only(top: 4.0, bottom: 5.0),
                child: Container(
                    height: MediaQuery.of(context).size.height-70,
                    width: MediaQuery.of(context).size.width,
                    child:  Image.file(snapshot.data,

                        height: MediaQuery.of(context).size.height-70,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.fitWidth)
                ),)):
         Navigator.pushReplacement(context,MaterialPageRoute(builder:(context) => manageStory()));
        }
      },
    );
  }
}
