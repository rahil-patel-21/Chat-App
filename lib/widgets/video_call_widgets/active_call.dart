import 'package:flutter/material.dart';

class ActiveCall extends StatefulWidget {
  final bool isMe;
  final Widget videoWidgetA;
  final Widget videoWidgetB;
  ActiveCall(
      {@required this.isMe,
      @required this.videoWidgetA,
      @required this.videoWidgetB})
      : assert(isMe != null, videoWidgetA != null);
  @override
  _ActiveCallState createState() => _ActiveCallState();
}

class _ActiveCallState extends State<ActiveCall> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          !widget.isMe ? widget.videoWidgetA : widget.videoWidgetB,
          Expanded(
            child: Container(
              padding: EdgeInsets.only(
                  left: 10, top: MediaQuery.of(context).padding.top + 5),
              height: 160,
              width: 100,
              child: widget.isMe ? widget.videoWidgetA : widget.videoWidgetB,
            ),
          ),
        ],
      ),
    );
  }
}
