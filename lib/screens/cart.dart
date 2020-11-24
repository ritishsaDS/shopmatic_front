import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loading_gifs/loading_gifs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopmatic_front/utils/common.dart';
import 'package:shopmatic_front/widget/cart_product_cell.dart';
import 'package:shopmatic_front/widget/checkouCard.dart';

import 'DefaultButton.dart';
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
  String pQuantity="";
   
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
        body:ListView.builder(
     
      itemCount: 5,//CHANGED
      itemBuilder: (context, index) =>
           Dismissible(
            key: Key(widget.id),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              
               setState(() {
    
              });
            },
            background: 
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Color(0xFFFFE6E6),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Icon(Icons.delete)
                ])
                
                ),
                child:  Card(
                                  child: Container(
            
      margin: EdgeInsets.only( top:5, right: 10,left:10),
      child: Row(
       
        children: <Widget>[
         
          GestureDetector(
            onTap: () {},
            child:  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(12),
                            bottomLeft: Radius.circular(12),
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12))),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: FadeInImage.assetNetwork(
                        image: widget.image,
                        fit: BoxFit.cover,
                        placeholder: cupertinoActivityIndicator,
                        height: 90.0,
                        width: 100.0,
                      ),
                    ),
                  )),

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
                          
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      )),  Container(
                      margin: EdgeInsets.only(left: 10, top: 5),
                      child: Text(
                       widget.description,
                        style: TextStyle(
                            color: lightestText,
                            fontFamily: "proxima",
                            fontWeight: FontWeight.normal,
                            fontSize: 12),
                            softWrap: true,overflow: TextOverflow.ellipsis,
                      )),
                      Container(
                      margin: EdgeInsets.only(left: 10, top: 5),
                      child: Text(
                       currency+ widget.price,
                        style: TextStyle(
                            color: primaryColor,
                            fontFamily: "proxima",
                            fontWeight: FontWeight.bold,
                            fontSize: 13),
                            softWrap: true,overflow: TextOverflow.ellipsis,
                      )),
                  
                   Container(
                                        margin: EdgeInsets.all(10.0),
                                        child: Row(
                                          children: <Widget>[
                                            buildOutlineButton(
                                                icon: Icons.remove,
                                                press: () {
                                                  setState(() {
widget.Quantity--;
                                                  });
                                                }),
                                            Container(
                                                child: Text(
                                              "   " + widget.Quantity.toString()+ "   ",
                                              style: TextStyle(
                                                  fontFamily: "futura",
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13),
                                            )),
                                            buildOutlineButton(
                                              icon: Icons.add,
                                              press: () {
                                                setState(() {
                                                  widget.Quantity++;
                                                });
                                              },
                                            ),]))
                                                  // Container(
                  //     margin: EdgeInsets.only(left: 10),
                  //     child: Text("Store: " + widget.productData['storeName'])),

              ],
            ),
          )
        ],
      ),
    ),
                ),

                
                ),
        ) ,  bottomNavigationBar:CheckoutCard()
   );
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
   SizedBox buildOutlineButton({IconData icon, Function press}) {
    return SizedBox(
      width: 40,
      height: 32,
      child: OutlineButton(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13),
        ),
        onPressed: press,
        child: Icon(icon),
      ),
    );
  }

}
