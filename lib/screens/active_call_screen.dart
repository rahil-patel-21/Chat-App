// Dart Import
import 'dart:async';

//Flutter Imports
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

// Local Imports
import '../contact_model.dart';
import '../widgets/video_call_widgets/tool_bar.dart';
import '../streams/call_stream.dart';
import '../utilities/call_utils.dart';
import '../authcontroller.dart';
import '../constants/reference_constants.dart';
import '../widgets/video_call_widgets/active_call.dart';
import '../widgets/video_call_widgets/out_going_call.dart';

// Package Dependencies Imports
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CallScreen extends StatefulWidget {
  final User currentUser;
  final ContactUser contactUser;

  CallScreen({@required this.currentUser, @required this.contactUser})
      : assert(currentUser != null, contactUser != null);

  @override
  _CallScreenState createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  static final _users = <int>[];
  final _infoStrings = <String>[];
  bool muted = false;
  StreamSubscription callStreamSubscription;

  bool isMe = true;
  bool statusBar = false;
  bool toolBar = true;

  @override
  void initState() {
    super.initState();
    addPostFrameCallBack();
    initializeAgoraRTC();
    changeStatusBarState();
  }

  void changeStatusBarState() {
    setState(() {
      statusBar = !statusBar;
      statusBar
          ? SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom])
          : SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    });
  }

  void changeToolBarState() {
    setState(() {
      toolBar = !toolBar;
    });
  }

  Future<void> initializeAgoraRTC() async {
    if (APP_ID.isEmpty) {
      setState(() {
        _infoStrings.add(
          'APP_ID missing, please provide your APP_ID in settings.dart',
        );
        _infoStrings.add('Agora Engine is not starting');
      });
      return;
    }

    await _initAgoraRtcEngine();
    _addAgoraEventHandlers();
    await AgoraRtcEngine.enableWebSdkInteroperability(true);
    await AgoraRtcEngine.setParameters(
        '''{\"che.video.lowBitRateStreamParameter\":{\"width\":320,\"height\":180,\"frameRate\":15,\"bitRate\":140}}''');
    await AgoraRtcEngine.joinChannel(null, 'TemporaryChannelID', null, 0);
  }

  Future<void> _initAgoraRtcEngine() async {
    await AgoraRtcEngine.create(APP_ID);
    await AgoraRtcEngine.enableVideo();
  }

  void _addAgoraEventHandlers() {
    AgoraRtcEngine.onError = (dynamic code) {
      setState(() {
        final info = 'onError: $code';
        _infoStrings.add(info);
      });
    };

    AgoraRtcEngine.onJoinChannelSuccess = (
      String channel,
      int uid,
      int elapsed,
    ) {
      setState(() {
        final info = 'onJoinChannel: $channel, uid: $uid';
        _infoStrings.add(info);
      });
    };

    AgoraRtcEngine.onLeaveChannel = () {
      setState(() {
        _infoStrings.add('onLeaveChannel');
        _users.clear();
      });
    };

    AgoraRtcEngine.onUserJoined = (int uid, int elapsed) {
      setState(() {
        final info = 'userJoined: $uid';
        _infoStrings.add(info);
        _users.add(uid);
      });
    };

    AgoraRtcEngine.onUserOffline = (int uid, int reason) {
      CallUtils.disconnectingCall(
          currentUser: widget.currentUser,
          contactUser: widget.contactUser,
          context: context);
      setState(() {
        final info = 'userOffline: $uid';
        _infoStrings.add(info);
        _users.remove(uid);
      });
    };

    AgoraRtcEngine.onFirstRemoteVideoFrame =
        (int uid, int width, int height, int elapsed) {
      setState(() {
        final info = 'firstRemoteVideo: $uid ${width}x $height';
        _infoStrings.add(info);
      });
    };
  }

  addPostFrameCallBack() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      callStreamSubscription = callStream(currentUser: widget.currentUser)
          .listen((DocumentSnapshot documentSnapshot) {
        switch (documentSnapshot.data) {
          case null:
            CallUtils.disconnectingCall(
                currentUser: widget.currentUser,
                contactUser: widget.contactUser,
                context: context);
            Navigator.pop(context);
            break;

          default:
            break;
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _users.clear();
    AgoraRtcEngine.leaveChannel();
    AgoraRtcEngine.destroy();
    callStreamSubscription.cancel();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  List<Widget> _getRenderViews() {
    final List<AgoraRenderWidget> list = [
      AgoraRenderWidget(0, local: true, preview: true),
    ];
    _users.forEach((int uid) => list.add(AgoraRenderWidget(uid)));
    return list;
  }

  Widget _videoView(Widget view) {
    return Expanded(
      child: view,
    );
  }

  void _onToggleMute() {
    setState(() {
      muted = !muted;
    });
    AgoraRtcEngine.muteLocalAudioStream(muted);
  }

  void _onSwitchCamera() {
    AgoraRtcEngine.switchCamera();
  }

  void _onDisconnectingCall() {
    CallUtils.disconnectingCall(
        currentUser: widget.currentUser,
        contactUser: widget.contactUser,
        context: context);
  }

  Widget _videoCallWidget() {
    final views = _getRenderViews();
    switch (views.length) {
      case 1:
        return OutGoingCall(
          isMe: isMe,
          videoWidget: _videoView(views[0]),
          imageURL: widget.contactUser.photoURL,
          contactUserName: widget.contactUser.contactName,
        );
      case 2:
        return ActiveCall(
            isMe: isMe,
            videoWidgetA: _videoView(views[0]),
            videoWidgetB: _videoView(views[1]));
      default:
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          changeStatusBarState();
          changeToolBarState();
        },
        child: Center(
          child: Stack(
            children: <Widget>[
              _videoCallWidget(),
              toolBar
                  ? VideoCallToolBar(
                      muted: muted,
                      onToggleMute: _onToggleMute,
                      onSwitchCamera: _onSwitchCamera,
                      onDisconnectingCall: _onDisconnectingCall,
                    )
                  : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
