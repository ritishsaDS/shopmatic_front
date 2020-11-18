import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loading_gifs/loading_gifs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopmatic_front/utils/common.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/widgets/story_view.dart';
import 'package:http/http.dart' as http;



class MoreStories extends StatefulWidget {
  dynamic data;
  MoreStories({Key key, this.data}) : super(key: key);

  @override
  _MoreStoriesState createState() => _MoreStoriesState();
}

class _MoreStoriesState extends State<MoreStories> {
  bool isError=false;
  bool isLoading = false;
  String id;

  final storyController = StoryController();
  @override
  void initState() {
    getProfile();
    getStories();

    super.initState();
  }
  @override
  void dispose() {
    storyController.dispose();
    super.dispose();
  }
  List<StoryItem> storyItems = [];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:  Stack(
          children: <Widget>[
      Container(
      child: isLoading
      ? Center(
          child:Image.asset(cupertinoActivityIndicator)
    )

        : GestureDetector(
        child:Stack(
          children: <Widget>[
            StoryView(
              storyItems:
              getStorestories()
              ,

              onStoryShow: (s) {
                print("Showing a story");
              },
              onComplete: () {
                Navigator.pop(context);
                print("Completed a cycle");
              },
              progressPosition: ProgressPosition.top,
              repeat: true,
              controller: storyController,
            ),
            Container(
              padding: EdgeInsets.only(
                top: 48,
                left: 16,
                right: 16,
              ),
              child: _buildProfileView(),
            )
          ],
        )
      )
    )]));
  }
  dynamic storyfromserver = new List();
  dynamic productFromServer = new List();


  Future<void> getStories() async {
    isLoading = true;
    try {
      print("josdfjhu");
      final response = await http.get(
        StoriesApi+ widget.data ,
      );
      print("kmdfpjodfpjio"+widget.data.toString());
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        print(responseJson.toString() + "hello");
        if(response.statusCode==200){
          storyfromserver = responseJson['data'] as List ;
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
  List<StoryItem> getStorestories() {
    List<StoryItem> storyItems = new List();
    List story = storyfromserver as List;
      for (int j = 0; j < story.length; j++) {
      storyItems.add(StoryItem.pageImage(url: story[j]["photo"], controller: storyController,caption: story[j]['caption']),);
    }
    return
      storyItems;
  }

  Widget _buildProfileView() {
    return  Stack(
      children: <Widget>[
    Container(
    child: isLoading
    ? Center(
        child:Image.asset(cupertinoActivityIndicator)
    )

        :Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ClipOval(
            child: CircleAvatar(
                radius: 24,
                backgroundColor: lightGrey,
                child: FadeInImage.assetNetwork(
                  image: productFromServer['data']['logo'],
                  placeholder: cupertinoActivityIndicator,
                  fit: BoxFit.fill,
                  height: 90,
                ))),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Text(
                productFromServer['data']["outlet_name"],
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              /*Text(
                productFromServer['data']["created_on"],
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),*/

            ],
          ),
        )
      ],
    ))]);
  }
  Future<void> getProfile() async {
    isLoading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    id = prefs.getString('intValue');
    print("isdds" + id);
    try {
      final response = await http.post(

          profileApi ,body:{
        "outlet_id": widget.data,
        "user_id":id

      }
      );
      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        print(responseJson.toString() + "hello");

        productFromServer = responseJson;

        //print('jhifuh' + productFromServer.toString()); //;

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
}
