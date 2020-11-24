import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shopmatic_front/screens/DefaultButton.dart';
import 'package:shopmatic_front/utils/common.dart';

class CheckoutCard extends StatelessWidget {
  const CheckoutCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
     
      // height: 174,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: 
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

               Container(
                 padding : EdgeInsets.only(left:15),
                 child: Text.rich(
                  TextSpan(
                    text: "Total:\n",style: TextStyle(fontFamily: "proxima",color: lightText,),
                    children: [
                      TextSpan(
                        text: "\$337.15    ",
                        style: TextStyle(fontSize: 16, color: darkText,fontFamily: "futura",fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
               ),
                Expanded(
                
                  child: GestureDetector(
     child: Container(
margin: EdgeInsets.all(10.0),
decoration: BoxDecoration(
  borderRadius: BorderRadius.circular(6.0),
  color:Colors.black,
),
child: FlatButton(
   
  child: Text("Checkout",style: TextStyle(color: white,fontFamily: "futura",fontSize: 16),),
),
     ),onTap: ()=>createOrder(),
     
        )       
                     ),
                   ],
                 ),
             
           ),
         );
       }
     
       createOrder() {}
}