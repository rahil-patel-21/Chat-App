import 'package:flutter/material.dart';

class VideoCallToolBar extends StatefulWidget {
  final bool muted;
  final VoidCallback onToggleMute;
  final VoidCallback onSwitchCamera;
  final VoidCallback onDisconnectingCall;
  VideoCallToolBar(
      {@required this.muted,
      @required this.onToggleMute,
      @required this.onSwitchCamera,
      @required this.onDisconnectingCall})
      : assert(muted != null, onToggleMute != null);
  _VideoCallToolBarState createState() => _VideoCallToolBarState();
}

class _VideoCallToolBarState extends State<VideoCallToolBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RawMaterialButton(
            onPressed: widget.onToggleMute,
            child: Icon(
              widget.muted ? Icons.mic_off : Icons.mic,
              color: widget.muted ? Colors.white : Colors.blueAccent,
              size: 20.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: widget.muted ? Colors.blueAccent : Colors.white,
            padding: const EdgeInsets.all(12.0),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              RawMaterialButton(
                onPressed: widget.onDisconnectingCall,
                child: Icon(
                  Icons.call_end,
                  color: Colors.white,
                  size: 35.0,
                ),
                shape: CircleBorder(),
                elevation: 2.0,
                fillColor: Colors.redAccent,
                padding: const EdgeInsets.all(15.0),
              ),
              SizedBox(height: 35)
            ],
          ),
          RawMaterialButton(
            onPressed: widget.onSwitchCamera,
            child: Icon(
              Icons.switch_camera,
              color: Colors.blueAccent,
              size: 20.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: Colors.white,
            padding: const EdgeInsets.all(12.0),
          )
        ],
      ),
    );
  }
}
