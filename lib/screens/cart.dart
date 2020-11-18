import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:loading_gifs/loading_gifs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopmatic_front/utils/common.dart';
import 'package:http/http.dart' as http;
import 'package:shopmatic_front/widget/cart_product_cell.dart';

import 'orders.dart';
import 'store_products.dart';

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
        body:ListView(children: createProduct(cartTemporary)));
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
  List<Widget> createProduct(dynamic cartListFromLocal) {
    double subtotal = 0;
    List<Widget> productList = new List();
    if (cartListFromLocal.length > 0) {
      for (int i = 0; i < cartListFromLocal.length; i++) {
        print(cartListFromLocal[i]);
        subtotal = subtotal +
            double.parse(cartListFromLocal[i]['price']
                .replaceAll("\$", "")
                .replaceAll(",", "")) *
                double.parse(cartListFromLocal[i]['quantity'].toString());
        productList.add(CartProductCell(
          productData: cartListFromLocal[i],
          addQuant: () {
            setState(() {
              cartListFromLocal[i]['quantity'] =
                  cartListFromLocal[i]['quantity'] + 1;
            });
          },
          delQuant: () {
            setState(() {
              if (cartListFromLocal[i]['quantity'] > 1) {
                cartListFromLocal[i]['quantity'] =
                    cartListFromLocal[i]['quantity'] - 1;
              }
            });
          },
          delItem: () {
            setState(() {
              cartListFromLocal.removeAt(i);
            });
          },
        ));
      }
      productList.add(Container(
        color: lightGrey,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(15),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'SubTotal:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              cartOnHold
                  ? Container(
                height: 15,
                width: 15,
                child: CircularProgressIndicator(
                    valueColor:
                    new AlwaysStoppedAnimation<Color>(primaryColor)),
              )
                  : Text(
                '\₹' + subtotal.toStringAsFixed(2),
                // /*+ calculateDriverTip(double.parse(dropdownValue)) + shipping + calculateDriverTip(serviceFeePercent)*/).toStringAsFixed(2),
                style:
                TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ]),
      ));
      productList.add(Container(
        height: 45,
        color: primaryColor,
        margin: EdgeInsets.all(15),
        child: new FlatButton(
            onPressed: () {
             // isLoggedIn();
            },
            child: isLoading
                ? CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(white))
                : Text(
              "Checkout",
              style: TextStyle(
                  color: white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            )),
      ));
      productList.add(SizedBox(
        height: 50,
      ));
    } else {
      productList.add(new Container(
          height: MediaQuery.of(context).size.width,
          child: Container(
            margin: EdgeInsets.only(top: 100),
            child: Column(
              children: <Widget>[
                Container(
                    child: Icon(
                      Icons.add_shopping_cart,
                      size: 80,
                      color: darkText,
                    )),
                SizedBox(height: 20),
                Text(
                  'Cart is empty!',
                  style: TextStyle(
                      color: darkText,
                      fontWeight: FontWeight.normal,
                      fontSize: 22),
                ),
              ],
            ),
          )));
    }

    return productList;
  }

}
