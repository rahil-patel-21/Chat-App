import 'package:flutter/material.dart';
import 'package:techexperiment001/constants.dart';

class ImageChatBubble extends StatelessWidget {
  ImageChatBubble({@required this.imageURL, @required this.msgOwner});
  final String imageURL;
  final bool msgOwner;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 250,
        width: 80,
        margin: msgOwner
            ? EdgeInsets.fromLTRB(80, 5, 5, 0)
            : EdgeInsets.fromLTRB(5, 5, 80, 0),
        decoration: BoxDecoration(
          border:
              Border.all(width: 4, color: msgOwner ? themecolorB : themeColorC),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            image: NetworkImage(imageURL),
            alignment: Alignment.centerRight,
            fit: BoxFit.cover,
          ),
        ),
        alignment: msgOwner ? Alignment.centerRight : Alignment.centerLeft);
  }
}
