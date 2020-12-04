import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopmatic_front/utils/common.dart';
import 'dart:math';
import 'package:badges/badges.dart';
final ThemeData iOSTheme = new ThemeData(
  primarySwatch: Colors.red,
  primaryColor: Colors.grey[400],
  primaryColorBrightness: Brightness.dark,
);

final ThemeData androidTheme = new ThemeData(
  primarySwatch: Colors.blue,
  accentColor: Colors.green,
);

 String defaultUserName = "John Doe";

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext ctx) {
    return new MaterialApp(
      title: "Chat Application",
      theme: defaultTargetPlatform == TargetPlatform.iOS
        ? iOSTheme
        : androidTheme,
      home: new Chat(),
    );
  }
}

class Chat extends StatefulWidget {
  @override
  State createState() => new ChatWindow();
}

class ChatWindow extends State<Chat> with TickerProviderStateMixin {
  final List<Msg> _messages = <Msg>[];
  final TextEditingController _textController = new TextEditingController();
  bool _isWriting = false;
 @override
  void initState()  {
    getusername();
        
        super.initState();
      }
    
      @override
      Widget build(BuildContext ctx) {
        return new Scaffold(
          appBar: new AppBar(
            title: new Text("Chat Application"),
            elevation:
              Theme.of(ctx).platform == TargetPlatform.iOS ? 0.0 : 6.0,
//                  actions: <Widget>[
// GestureDetector(
//   child:   Transform.rotate(
//   angle: 505 * pi / 270,
//   child:         Container(padding: EdgeInsets.only(right: 10),
//       child:  Badge(
//             showBadge: p2badge,
//             badgeContent: Text(
//               badge.toString(),
//               style: TextStyle(color: Colors.white),
//             ),
//             child: Icon(
//               Icons.send,
//               color:primaryColor,
//             ),
//           ))),
//        onTap: () {
  
//   // Navigator.pushReplacement(context,
//   //     MaterialPageRoute(builder: ( context) => WelcomeScreen()));
// },

// )
//           ],
       
          ),
          
          body: new Column(children: <Widget>[
            new Flexible(
                child: new ListView.builder(
                  itemBuilder: (_, int index) => _messages[index],
                  itemCount: _messages.length,
                  reverse: true,
                  padding: new EdgeInsets.all(6.0),
                )),
            new Divider(height: 1.0),
            new Container(
              child: _buildComposer(),
              decoration: new BoxDecoration(color: Theme.of(ctx).cardColor),
            ),
          ]),
        );
      }
    
    
      Widget _buildComposer() {
        return new IconTheme(
            data: new IconThemeData(color: Theme.of(context).accentColor),
            child: new Container(
              margin: const EdgeInsets.symmetric(horizontal: 9.0),
              child: new Row(
                children: <Widget>[
                  new Flexible(
                      child: new TextField(
                        controller: _textController,
                        onChanged: (String txt) {
                          setState(() {
                            _isWriting = txt.length > 0;
                          });
                        },
                        onSubmitted: _submitMsg,
                        decoration:
                          new InputDecoration.collapsed(hintText: "Enter some text to send a message"),
                      ),
                  ),
                  new Container(
                    margin: new EdgeInsets.symmetric(horizontal: 3.0),
                    child: Theme.of(context).platform == TargetPlatform.iOS
                      ? new CupertinoButton(
                        child: new Text("Submit"),
                        onPressed: _isWriting ? () => _submitMsg(_textController.text)
                            : null
                    )
                        : new IconButton(
                        icon: new Icon(Icons.send,color:primaryColor),
                        onPressed: _isWriting
                          ? () => _submitMsg(_textController.text)
                            : null,
                    )
                  ),
                ],
              ),
              decoration: Theme.of(context).platform == TargetPlatform.iOS
              ? new BoxDecoration(
                border:
                  new Border(top: new BorderSide(color: Colors.brown))) :
                  null
            ),
        );
      }
    
      void _submitMsg(String txt) {
        _textController.clear();
        setState(() {
          _isWriting = false;
        });
        Msg msg = new Msg(
          txt: txt,
          animationController: new AnimationController(
              vsync: this,
            duration: new Duration(milliseconds: 800)
          ),
        );
        setState(() {
          _messages.insert(0, msg);
        });
        msg.animationController.forward();
         p2badge = true;
    setState(() {
      badge1 = badge1 +1;

      //data = product;
      //dataList=product;
    });
      }
    
      @override
      void dispose() {
        for (Msg msg in _messages) {
          msg.animationController.dispose();
        }
        super.dispose();
      }
    
      Future<void> getusername() async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
    
        defaultUserName = prefs.getString('name');
      }

}

class Msg extends StatelessWidget {
  Msg({this.txt, this.animationController});
  final String txt;
  final AnimationController animationController;

  @override
  Widget build(BuildContext ctx) {
    return new SizeTransition(
      sizeFactor: new CurvedAnimation(
          parent: animationController, curve: Curves.easeOut),
      axisAlignment: 0.0,
      child: new Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            new Container(
              margin: const EdgeInsets.only(right: 18.0),
              child: new CircleAvatar(child: new Text(defaultUserName[0])),
            ),
            new Expanded(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  new Text(defaultUserName, style: Theme.of(ctx).textTheme.subhead),
                  new Container(
                    margin: const EdgeInsets.only(top: 6.0),
                    child: new Text(txt),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}