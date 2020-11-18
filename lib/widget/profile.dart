import 'package:flutter/material.dart';


class ProfileListItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool hasNavigation;

  const ProfileListItem({
    Key key,
    this.icon,
    this.text,
    this.hasNavigation = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(
        horizontal:10,
      ).copyWith(
        bottom: 20,
      ),
      padding: EdgeInsets.symmetric(
        horizontal:10,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: Theme.of(context).backgroundColor,
      ),
      child: Row(
        children: <Widget>[
          Icon(
            this.icon,
            size: 30,
          ),
          SizedBox(width: 20),
          Text(
            this.text,
            /*style: kTitleTextStyle.copyWith(
              fontWeight: FontWeight.w500,
            ),*/
          ),
          Spacer(),
          if (this.hasNavigation)
            Icon(
              Icons.arrow_right,
              size: 30,
            ),
        ],
      ),
    );
  }
}
