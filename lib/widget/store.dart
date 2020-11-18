import 'package:flutter/material.dart';
import 'package:loading_gifs/loading_gifs.dart';
import 'package:shopmatic_front/screens/profile_screen.dart';
import 'package:shopmatic_front/screens/store_products.dart';
import 'package:shopmatic_front/utils/common.dart';

class storescreen extends StatefulWidget {
  dynamic productData;

  storescreen(this.productData);

  storestate createState() => storestate();
}

class storestate extends State<storescreen> {
  @override
  Widget build(BuildContext context) {
    dynamic textToSend = widget.productData['outlet_id'];

    // TODO: implement build
    return
     GestureDetector(
       child: Container(margin: EdgeInsets.only(left: 12, right: 12),
           child: Column(
               children: <Widget>[
                 Row(children: <Widget>[ GestureDetector(
                 child: ClipRRect(
                   borderRadius: BorderRadius.circular(6.0),
                   child: FadeInImage.assetNetwork(
                     image:widget.productData['logo'],
                     fit: BoxFit.fitWidth,
                     placeholder:cupertinoActivityIndicator ,
                     height: 70.0,
                     width: 100.0,
                     ),),
               ),
                   Container(padding: EdgeInsets.only(left: 10), child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: <Widget>[
                   Text(widget.productData['outlet_name'], style: TextStyle(color: darkText,
                       fontWeight: FontWeight.bold,
                       fontFamily: "futura",
                       fontSize: 15)),
                   Container(
                     padding: EdgeInsets.only(top: 3, bottom: 3),
                     width: 200,
                     child: Text(
                       widget.productData['address'],
                       style: TextStyle(
                           color: lightText, fontSize: 14, fontFamily: "proxima"),
                       overflow: TextOverflow.ellipsis,
                       softWrap: false,
                       maxLines: 2,),),
                   Container(
                     padding: EdgeInsets.only(top: 3, bottom: 3),

                     child:RichText(
                       text: TextSpan(
                         children: [
                           WidgetSpan(
                             child: Icon(Icons.location_on, size: 14,color: primaryColor,),
                           ),
                           TextSpan(
                             text:""+ widget.productData['place_name'],
                             style: TextStyle(
                               fontSize: 13,fontFamily: "proxima",color: lightestText
                             ),
                           ),


                         ],
                       ),
                     ),),
                 ],)),
               ]), Divider(
                 height: 30, thickness: 1.5, color: dividerColor,)
               ])),onTap: (){
         Navigator.push(context, MaterialPageRoute(builder: (context)=>storeProducts(
            data:widget.productData['outlet_id'],name:widget.productData['outlet_name']
         )));
     },
     )
    ;
  }

}
