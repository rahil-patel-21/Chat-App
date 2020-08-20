import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:techexperiment001/function_area.dart';
import 'package:techexperiment001/utilities/call_utils.dart';
import 'dart:io';
import 'authcontroller.dart';
import 'chat_screen_updater.dart';
import 'constants.dart';
import 'contact_model.dart';
import 'message_model.dart';

FunctionArea _functionArea = FunctionArea();

class ChatScreen extends StatefulWidget {
  ChatScreen({@required this.contactUser, @required this.currentUser});
  final ContactUser contactUser;
  final User currentUser;
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final textEditingController = TextEditingController();
  String message = ' ';

  @override
  void initState() {
    super.initState();
    Firestore.instance
        .collection(messagesDB)
        .document(widget.currentUser.userNumber)
        .collection('Recent Chats')
        .document(widget.contactUser.contactNumber)
        .updateData({'Read Status': true});
  }

  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ImageSendProvider _imageSendProvider =
    //     Provider.of<ImageSendProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.videocam),
            onPressed: () {
              CallUtils.connectingCall(
                  currentUser: widget.currentUser,
                  contactUser: widget.contactUser,
                  context: context);
            },
          )
        ],
        title: Text(widget.contactUser.contactName),
        backgroundColor: themeColor,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ChatScreenUpdater(
              contactUser: widget.contactUser,
              currentUser: widget.currentUser,
            ),
            // _imageSendProvider.getImageSendingState == ImageSendingState.Sending
            //     ? CircularProgressIndicator()
            //     : Container(),
            EditTextWidget(
              textEditingController: textEditingController,
              message: message,
              widget: widget,
            ),
          ],
        ),
      ),
    );
  }
}

class EditTextWidget extends StatefulWidget {
  const EditTextWidget({
    Key key,
    @required this.textEditingController,
    @required this.message,
    @required this.widget,
  }) : super(key: key);

  final TextEditingController textEditingController;
  final String message;
  final ChatScreen widget;

  @override
  _EditTextWidgetState createState() => _EditTextWidgetState();
}

Future<void> pickImage(
    {@required ImageSource imageSource,
    @required User currentUser,
    @required ContactUser contactUser,
    @required BuildContext context}) async {
  // ImageSendProvider _imageSendProvider =
  //     Provider.of<ImageSendProvider>(context, listen: false);
  // _imageSendProvider.setSending();
  File selectedImage = await FunctionArea.pickImage(imageSource: imageSource);
  // .whenComplete(() => _imageSendProvider.setNotSending());

  Message _messageForMe = Message(
      type: 'Image',
      timeStamp: Timestamp.now(),
      readStatus: true,
      companionID: contactUser.contactNumber,
      senderID: currentUser.userNumber);
  Message _messageForThem = Message(
      type: 'Image',
      timeStamp: Timestamp.now(),
      readStatus: false,
      companionID: currentUser.userNumber,
      senderID: currentUser.userNumber);
  await _functionArea.uploadImage(
      selectedImage, _messageForMe, _messageForThem);
}

class _EditTextWidgetState extends State<EditTextWidget> {
  String message = ' ';
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  controller: widget.textEditingController,
                  onChanged: (value) {
                    setState(() {
                      message = value;
                    });
                  },
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 2,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.white),
                    filled: true,
                    fillColor: themeColorC,
                    suffixIcon: Icon(
                      Icons.attach_file,
                      color: Colors.white,
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                        borderSide: BorderSide(color: themeColorC)),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                    hintText: 'Type Message Here . . .',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0))),
                  ),
                ),
              ),
              SizedBox(
                width: 2.0,
              ),
              message.trim().length > 1
                  ? RawMaterialButton(
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        if (message.trim().length == 0) {
                        } else {
                          Message _messageForMe = Message(
                              message: message,
                              type: 'Text',
                              timeStamp: Timestamp.now(),
                              readStatus: true,
                              companionID:
                                  widget.widget.contactUser.contactNumber,
                              senderID: widget.widget.currentUser.userNumber);
                          Message _messageForThem = Message(
                              message: message,
                              type: 'Text',
                              timeStamp: Timestamp.now(),
                              readStatus: false,
                              companionID: widget.widget.currentUser.userNumber,
                              senderID: widget.widget.currentUser.userNumber);

                          final authBase =
                              Provider.of<AuthBase>(context, listen: false);
                          authBase.addMessageToDB(
                            _messageForMe,
                            _messageForThem,
                          );
                        }
                        widget.textEditingController.clear();
                      },
                      constraints:
                          BoxConstraints.tightFor(width: 45.0, height: 45.0),
                      shape: CircleBorder(),
                      fillColor: themeColorC,
                    )
                  : GestureDetector(
                      // onTap: () => pickImage(imageSource: ImageSource.camera),
                      child: RawMaterialButton(
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          pickImage(
                              imageSource: ImageSource.camera,
                              currentUser: widget.widget.currentUser,
                              contactUser: widget.widget.contactUser,
                              context: context);
                        },
                        constraints:
                            BoxConstraints.tightFor(width: 45.0, height: 45.0),
                        shape: CircleBorder(),
                        fillColor: themeColorC,
                      ),
                    ),
            ],
          ),
        ),
      ],
    );
  }
}
