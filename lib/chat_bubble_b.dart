import 'package:flutter/material.dart';
import 'constants.dart';

class ChatBubbleB extends StatelessWidget {
  final String textMessage, senderEmail, nnumber;
  final bool isContinuous;
  ChatBubbleB(
      {this.textMessage, this.senderEmail, this.isContinuous, this.nnumber});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
      child: Column(
        crossAxisAlignment:
            isContinuous ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: isContinuous
                ? EdgeInsets.only(left: 25.0)
                : EdgeInsets.only(right: 25.0),
            child: Material(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              elevation: 3.0,
              color: isContinuous ? themecolorB : themeColorC,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                child: Text(
                  textMessage,
                  style: TextStyle(
                    fontSize: 15.0,
                    color: isContinuous ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
