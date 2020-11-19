import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loading_gifs/loading_gifs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopmatic_front/utils/common.dart';
import 'package:shopmatic_front/widget/cart_product_cell.dart';

import 'orders.dart';

class Cart extends StatefulWidget {
dynamic image ;
  dynamic name;
  dynamic description;
dynamic Quantity;
dynamic id;
dynamic price;
Cart({Key key, this.image,this.name,this.description,this.Quantity,this.price,this.id}) : super(key: key);


  cartstate createState() => cartstate();
}

class cartstate extends State<Cart> {
  bool isError = false;
  bool isLoading = false;
  String uid="";
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: Text("My Cart", style: TextStyle(color: darkText)),
        ),
        body:ListView(children: <Widget>[
           Container(
      margin: EdgeInsets.only(top: 15, bottom: 15, right: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          itemToDelete == widget.id
              ? Container(
                  padding: EdgeInsets.all(12.0),
                  height: 43,
                  width: 43,
                  child: CircularProgressIndicator(
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(primaryColor)))
              : IconButton(
                  //onPressed: widget.delItem,
                  iconSize: 19,
                  icon: Icon(
                    Icons.delete,
                    color: transparentREd,
                  ),
                ),
          GestureDetector(
            onTap: () {},
            child: Container(
              color: white,
              padding: EdgeInsets.all(1),
              child: FadeInImage.assetNetwork(
                  height: 80,
                  width: 80,
                  placeholder: cupertinoActivityIndicator,
                  fit: BoxFit.fitWidth,
                  image: widget.image//imageList[skuList.indexOf(widget.productData['item_id'])]
                  ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(left: 10, top: 5),
                    child: Text(
                      widget.name,
                      style: TextStyle(
                          color: darkText,
                          fontFamily: "futura",
                          
                          fontWeight: FontWeight.normal,
                          fontSize: 14),
                    )), Container(
                    margin: EdgeInsets.only(left: 10, top: 5),
                    child: Text(
                      widget.description,
                      style: TextStyle(
                          color: lightestText,
                          fontFamily: "proxima",
                          fontWeight: FontWeight.normal,
                          fontSize: 13),
                          softWrap: true,overflow: TextOverflow.ellipsis,
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(left: 10, top: 2),
                        child: Text(
currency+widget.price,
                          style: TextStyle(
                              color: primaryColor,
                              fontFamily: "proxima",
                              fontWeight: FontWeight.bold,
                              fontSize: 19),
                        )),
                    Row(
                       
                      children: <Widget>[
                        IconButton(
                          //onPressed: cartOnHold ? null : widget.delQuant,
                          iconSize: 18,
                          icon: Icon(Icons.remove),
                        ),
                        cartOnHold &&
                                updatingItemId == widget.id
                            ? Container(
                                height: 15,
                                width: 15,
                                child: CircularProgressIndicator(
                                    valueColor:
                                        new AlwaysStoppedAnimation<Color>(
                                            primaryColor)),
                              )
                            : Text(widget.Quantity.toString(),
                                style:
                                    TextStyle(color: darkText, fontSize: 16)),
                        IconButton(
                         // onPressed: cartOnHold ? null : widget.addQuant,
                          color: primaryColor,
                          iconSize: 18,
                          icon: Icon(Icons.add),
                        ),
                      ],
                    )
                  ],
                ),
                // Container(
                //     margin: EdgeInsets.only(left: 10),
                //     child: Text("Store: " + widget.productData['storeName'])),

              ],
            ),
          )
        ],
      ),
    ),
   GestureDetector(
     child: Container(
margin: EdgeInsets.all(10.0),
decoration: BoxDecoration(
  borderRadius: BorderRadius.circular(6.0),
  color: Colors.black
),
child: RaisedButton(
   color: Colors.black,
  child: Text("Checkout",style: TextStyle(color: white),),
),
     ),onTap: ()=>createOrder(),

   )        ],));
  }

  Future<void> createOrder() async {
    isLoading = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uid = prefs.getString('intValue');
    try {
     // print(widget.id+widget.price+widget.Quantity+uid);
      final response = await http.post(
          createuserorder ,body: {
        "outlet_id":"23",
        "product_id":widget.id,
        "amount":widget.price.toString(),
        "quantity":widget.Quantity.toString(),
        "user_id":uid,
      }
      );


      if (response.statusCode == 200) {
        final responseJson = json.decode(response.body);
        print(responseJson.toString() + "hello");
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>order()));

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
