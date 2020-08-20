import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:techexperiment001/constants.dart';

class CustomContactTile extends StatelessWidget {
  CustomContactTile(
      {@required this.imageURL,
      @required this.title,
      @required this.subTitle,
      @required this.onTap})
      : assert(imageURL != null, title != null);
  final String title, subTitle, imageURL;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 3, 5, 0),
        child: Row(
          children: <Widget>[
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(imageURL),
            ),
            Expanded(
                child: Container(
              margin: EdgeInsets.only(left: 15),
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: <Widget>[
                          Text(subTitle),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
