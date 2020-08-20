// Dart Import
import 'dart:async';

//Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package Dependencies Imports
import 'package:agora_rtc_engine/agora_rtc_engine.dart';

// Local Imports
import '../constants/reference_constants.dart';

class LiveScreen extends StatefulWidget {
  final bool isMeLive;
  LiveScreen({@required this.isMeLive}) : assert(isMeLive != null);
  @override
  _LiveScreenState createState() => _LiveScreenState();
}

class _LiveScreenState extends State<LiveScreen> {
  static final _users = <int>[];

  @override
  void initState() {
    super.initState();
    initializeAgoraRTC();
  }

  Future<void> initializeAgoraRTC() async {
    await _initAgoraRtcEngine();
    _addAgoraEventHandlers();
    // await AgoraRtcEngine.enableWebSdkInteroperability(true);
    //  await AgoraRtcEngine.setParameters(
    //     '''{\"che.video.lowBitRateStreamParameter\":{\"width\":320,\"height\":180,\"frameRate\":15,\"bitRate\":140}}''');
    await AgoraRtcEngine.joinChannel(null, 'TemporaryChannelID', null, 0);
  }

  Future<void> _initAgoraRtcEngine() async {
    await AgoraRtcEngine.create(APP_ID);
    if (widget.isMeLive) {
      await AgoraRtcEngine.enableVideo();
    }
  }

  void _addAgoraEventHandlers() {
    AgoraRtcEngine.onLeaveChannel = () {
      setState(() {
        _users.clear();
      });
    };

    AgoraRtcEngine.onUserJoined = (int uid, int elapsed) {
      setState(() {
        _users.add(uid);
      });
    };
  }

  @override
  void dispose() {
    super.dispose();
    _users.clear();
    AgoraRtcEngine.leaveChannel();
    AgoraRtcEngine.destroy();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  List<Widget> _getRenderViews() {
    final List<AgoraRenderWidget> list = [];
    _users.forEach((int uid) => list.add(AgoraRenderWidget(uid)));
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _getRenderViews()[0]);
  }
}
