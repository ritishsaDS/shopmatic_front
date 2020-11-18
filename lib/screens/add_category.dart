import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopmatic_front/screens/manage_story.dart';
import 'package:shopmatic_front/utils/common.dart';
import 'package:http/http.dart' as http;

import 'manage_category.dart';

class addcategory extends StatefulWidget{
  dynamic id;
  dynamic text;
  addcategory({this.text,this.id});
  categorystate createState() => categorystate();
}
class categorystate extends State<addcategory>{

  final TextEditingController name = TextEditingController();
  bool isError = false;
  bool isLoading = false;

  @override
  void initState() {
print("ibjfdojhifd"+widget.id);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       elevation: 2,
       iconTheme: IconThemeData(color: Colors.black),
       title: Text("Add Category",style: TextStyle(fontSize: 16,color: darkText)),
       centerTitle: true,
       backgroundColor: white,
     ),
     body: Column(
       children:<Widget> [
         Container(
decoration: BoxDecoration(
  borderRadius: BorderRadius.circular(8.0)
      ,border: Border.all(color: lightGrey)
),

           margin: EdgeInsets.all(10.0),
           child: TextField(
             controller: name,
             style: TextStyle(color: darkText),
             decoration: InputDecoration(
                 border: InputBorder.none,
                 contentPadding: EdgeInsets.only(top:10,left:10),
                 hintText: 'Enter Catgeory.....',hintStyle: TextStyle(color: lightText,fontSize: 16),



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
       decoration: BoxDecoration(
         borderRadius: BorderRadius.circular(8.0),
         color: lightGrey
       ),
       child:  FlatButton(
         child: Text(widget.text)
         ,onPressed: (){
           if(widget.text=="Edit Category"){
             print("if");
             edit_category(name.text,widget.id);
           }
           else{
         add_category(name.text);}
       },
       )
     )
       ],
     ),
   );

  }
  Future<void> add_category(String text) async {
    isLoading = true;
    try {
      print("josdfjhu");
      final response = await http.post(
          addCategories ,body: {
          "category_name":text
      }

      );
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        print(responseJson.toString() + "hello");
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>manageCategory()));

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
  Future<void> edit_category(String text,String id) async {
    isLoading = true;
    try {
      print("josdfjhu");
      final response = await http.post(
          editcategory ,
          body: {
        "category_name":text,
        "category_id":id,
      }
      );
      print("jiopfdpjidfko["+widget.id+response.statusCode.toString());

      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        print(responseJson.toString() + "hello");
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>manageCategory()));

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

