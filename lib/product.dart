import 'package:flutter/material.dart';

import 'DefaultButton.dart';


class Body extends StatelessWidget {
 

  

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
       
        TopRoundedContainer(
          color: Colors.white,
          child: Column(
            children: [
              ProductDescription(
               
                pressOnSeeMore: () {},
              ),
              TopRoundedContainer(
                color: Color(0xFFF6F7F9),
                child: Column(
                  children: [
                    
                    TopRoundedContainer(
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 15,
                          right: 15,
                          bottom: 40,
                          top: 15,
                        ),
                        child: DefaultButton(
                          text: "Add To Cart",
                          press: () {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
  
}
class TopRoundedContainer extends StatelessWidget {
  const TopRoundedContainer({
    Key key,
    @required this.color,
    @required this.child,
  }) : super(key: key);

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: (20)),
      padding: EdgeInsets.only(top: (20)),
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: child,
    );
  }
}
class ProductDescription extends StatelessWidget {
  const ProductDescription({
    Key key,
   
    this.pressOnSeeMore,
  }) : super(key: key);

  
  final GestureTapCallback pressOnSeeMore;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: (20)),
          child: Text(
            "product.title",
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            padding: EdgeInsets.all((15)),
            width: (64),
            decoration: BoxDecoration(
              color:
                 Color(0xFFF5F6F9),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            child: Icon(Icons.favorite,  size:(16),
              color:
                  Color(0xFFDBDEE4),
            
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: (20),
            right: (64),
          ),
          child: Text(
          "  A shirt is a cloth garment for the upper body (from the neck to the waist). Originally an undergarment worn exclusively by men, it has become, in American English, a catch-all term for a broad variety of upper-body garments and undergarments.",style: TextStyle(fontSize: 10),
            maxLines: 3,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: (20),
            vertical: 10,
          ),
          child: GestureDetector(
            onTap: () {},
            child: Row(
              children: [
                Text(
                  "See More Detail",
                  style: TextStyle(
                      fontWeight: FontWeight.w600, fontSize:10,color: Colors.pink),
                ),
                SizedBox(width: 5),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color:Colors.pink,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
