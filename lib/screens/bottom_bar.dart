import 'dart:async';

import 'package:badges/badges.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopmatic_front/screens/settings.dart';
import 'package:shopmatic_front/utils/common.dart';

import 'Home_screen.dart';
import 'demo.dart';
import 'follow_requests.dart';
import 'followers.dart';
import 'orders.dart';


class BottomTabs extends StatefulWidget {
  int index;
  bool showCat;

  BottomTabs(this.index, this.showCat);

  @override
  _BottomTabsState createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {
  Timer timer;

  int countCart = 0;

  /*void startTimer() {
    timer = new Timer.periodic(Duration(seconds: 2), (timer) {
      setState(() {
        countCart = 0;
        for (var pro in cartTemporary) {
          countCart = countCart + pro['quantity'];
          //print(pro['quantity']);
        }
      });
    });
  }*/

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
   // startTimer();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: bottomTabHeight,
      child: Stack(
        children: <Widget>[  
          Align(
            alignment: Alignment.topCenter,
            child: Wrap(
              children: <Widget>[
                SizedBox(
                  width: double.infinity,
                  child: Container(
                    color: transparentBlack,
                    height: 1,
                  ),
                ),
              ],
            ),
          ),
          Align(
            child: Container(
              alignment: Alignment.topCenter,
              height: bottomTabHeight,
              width: MediaQuery.of(context).size.width,
              color: white,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        //Navigator.popUntil(context, StoreDetail(null));
                        if (widget.index == 1) {

                          // return;
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Home(),
                              ));
                        }
                         },
                      child:
                         Center(
                           child: Icon(
                             Icons.home,size: 30,
                             color:
                             widget.index == 1 ? primaryColor : lightestText,
                           ),
                         )
                      ),
                  ),

                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                        onTap: () {
                          //Navigator.popUntil(context, StoreDetail(null));
                          if (widget.index == 2) {

                            // return;
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Home(),
                                ));
                          }

                          // Navigator.popUntil(context, ModalRoute.withName('/store'));
                        },
                        child:
                        Center(
                          child: Icon(
                            Icons.developer_board,size: 30,
                            color:
                            widget.index == 2 ? primaryColor : lightestText,
                          ),
                        )
                    ),
                  ),

                   Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: ()
                  {
                    if(widget.index == 3)
                    {
                      return;
                    }
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => order(),
                        ));
                  },
                    child: Container(

                    child:
                      Icon(Icons.control_point,size:30,color:  widget.index == 3 ? primaryColor : lightestText,),
                     // Icon(Icons.shopping_cart, color:  index == 4 ? primaryColor : lightestText,),


                  ),
                ),
              ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        if(widget.index==3){
                          return;
                        }
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    InstaProfilePage() //Search( widget.storeData['id'].toString()),
                            ));
                        //isLoggedIn();
                      },
                      child:
                          //Icon(Icons.call, color:  widget.index == 4 ? primaryColor : lightestText,),
                          Container(

                            child: ColorFiltered(
                              colorFilter: ColorFilter.mode(
                                  widget.index == 4
                                      ? primaryColor
                                      : lightestText,
                                  BlendMode.srcATop),
                              child:  Icon(Icons.favorite_border,size: 30,),
                            ),



                      ),
                    ),
                  ),

                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {

                        if(widget.index==5){
                          return;
                        }
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    settings() //Search( widget.storeData['id'].toString()),
                                ));
                      },
                      child: Container(

                              child: ColorFiltered(
                                colorFilter: ColorFilter.mode(
                                    widget.index == 5
                                        ? primaryColor
                                        : lightestText,
                                    BlendMode.srcATop),
                                child:
                                    Icon(Icons.settings,size: 30,),
                              ),
                            ), //Icon(Icons.shopping_cart,color:  widget.index == 5 ? primaryColor : lightestText,),
                          ),
                          // Icon(Icons.shopping_cart, color:  index == 4 ? primaryColor : lightestText,),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
