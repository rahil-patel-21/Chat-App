import 'package:flutter/material.dart';
import 'constants.dart';

class ChatBubble extends StatelessWidget {
  final String textMessage, senderEmail, nnumber;
  final bool isMe;
  ChatBubble({this.textMessage, this.senderEmail, this.isMe, this.nnumber});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          // Text(
          //   senderEmail,
          //   style: TextStyle(fontSize: 10.0, color: Colors.black54),
          // ),
          Padding(
            padding: isMe
                ? EdgeInsets.only(left: 25.0)
                : EdgeInsets.only(right: 25.0),
            child: Material(
              borderRadius: isMe
                  ? BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0),
                    )
                  : BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                      topRight: Radius.circular(8.0),
                    ),
              elevation: 3.0,
              color: isMe ? themecolorB : themeColorC,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                child: Text(
                  textMessage,
                  style: TextStyle(
                    fontSize: 15.0,
                    color: isMe ? Colors.white : Colors.black,
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
