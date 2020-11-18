import 'package:flutter/material.dart';
import 'package:shopmatic_front/screens/plantinum_member.dart';
import 'package:shopmatic_front/screens/silver_member.dart';
import 'package:shopmatic_front/utils/common.dart';

import 'gold_group.dart';

class groupmember extends StatefulWidget {
  memberstate createState() => memberstate();
}

class memberstate extends State<groupmember>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    _controller = new TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: white,
          iconTheme: new IconThemeData(color: Colors.black),
          title: Text("Followers", style: TextStyle(color: darkText)),
        ),
        body: Container(
          child: DefaultTabController(
              length: 3, // Added
              initialIndex: 0,
              child: ListView(
                children: <Widget>[
                  Material(
                    child: TabBar(
                      tabs: [
                        Tab(
                          child: Text(
                            "Gold Group",
                            style: TextStyle(
                                color: darkText, fontFamily: "proxima"),
                          ),
                        ),
                        Tab(
                          child: Text(
                            "Silver Group",
                            style: TextStyle(
                                color: darkText, fontFamily: "proxima"),
                          ),
                        ),
                        Tab(
                          child: Text(
                            "Platinum Group",
                            style: TextStyle(
                                color: darkText, fontFamily: "proxima"),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.745,
                    child: new TabBarView(
                      children: [
                        //  Grid(data:widget.data),

                        gold(),
                        silver(),
                        plantinum()
                      ],
                    ),
                  ),
                ],
              )),
        ));
  }
}
