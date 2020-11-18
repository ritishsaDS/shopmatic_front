import 'package:flutter/material.dart';
import 'package:shopmatic_front/utils/common.dart';

import '../main.dart';
import 'orderbyOutlet.dart';
import 'orderbyUser.dart';

class order extends StatefulWidget{
  orderstate createState()=> orderstate();
}
class orderstate extends State<order>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body:   Container(

        child: DefaultTabController(
            length: 2, // Added
            initialIndex: 0,
            child: ListView(
              children: <Widget>[
                Material(
                  child: new TabBar(
                    tabs: [
                      Tab(
                          icon:Container(
                            child: Row(children: <Widget>[
                              Icon(Icons.supervised_user_circle,color: Colors.black,size: 30,),
              Text(" Orders by User",style: TextStyle(color: darkText))
              ],),),
                          ),
                      Tab(
                        icon:Container(
                          child:Row(children: <Widget>[
                      Icon(Icons.store,color: Colors.black,size: 30,),
                      Text(" Orders by Outlet",style: TextStyle(color: darkText))
                      ],),),
                        )
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height *
                      0.745,
                  child: new TabBarView(
                    children: [
                      //  Grid(data:widget.data),
                     userorder(),
                      outletorder(),
                    ],
                  ),
                ),
              ],
            )),
      )
    );
  }

}
