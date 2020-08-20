import 'package:flutter/material.dart';

class OutGoingCall extends StatefulWidget {
  final bool isMe;
  final Widget videoWidget;
  final String imageURL;
  final String contactUserName;
  OutGoingCall(
      {@required this.isMe,
      @required this.videoWidget,
      @required this.imageURL,
      @required this.contactUserName})
      : assert(isMe != null, videoWidget != null);
  @override
  _OutGoingCallState createState() => _OutGoingCallState();
}

class _OutGoingCallState extends State<OutGoingCall> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          widget.videoWidget,
          Expanded(
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                      backgroundImage: NetworkImage(widget.imageURL),
                      radius: 40),
                  SizedBox(height: 12),
                  Text('Connecting . . .',
                      style: TextStyle(fontSize: 14, color: Colors.white60),
                      textAlign: TextAlign.center),
                  SizedBox(height: 16),
                  Text(widget.contactUserName,
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.white70,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class _OutGoingCallState extends State<OutGoingCall> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Stack(
//         children: <Widget>[
//           !widget.isMe
//               ? widget.videoWidget
//               : Container(
//                   color: Colors.lightBlue,
//                   child:
//                       SizedBox(height: double.infinity, width: double.infinity),
//                 ),
//           Expanded(
//             child: Container(
//               padding: EdgeInsets.only(
//                   left: 10, top: MediaQuery.of(context).padding.top + 5),
//               height: 160,
//               width: 100,
//               child: widget.isMe ? widget.videoWidget : SizedBox(height: 50),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
