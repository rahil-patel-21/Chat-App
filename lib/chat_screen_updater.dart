import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:techexperiment001/chat_bubble_image.dart';
import 'authcontroller.dart';
import 'chat_bubble_a.dart';
import 'chat_bubble_b.dart';
import 'constants.dart';
import 'contact_model.dart';

final _fireStore = Firestore.instance;

class ChatScreenUpdater extends StatelessWidget {
  ChatScreenUpdater({@required this.currentUser, @required this.contactUser});
  final User currentUser;
  final ContactUser contactUser;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _fireStore
          .collection(messagesDB)
          .document(currentUser.userNumber)
          .collection(contactUser.contactNumber)
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator(
              backgroundColor: Colors.blueAccent,
            );
          }
          final messages = snapshot.data.documents;
          List<Widget> messageWidgets = [];
          int experimentUserContactNumber = 0;
          int experimentContactNumber = 0;
          bool isContinuousThis = false;

          for (var message in messages) {
            final messageText = message.data['message'];
            final msgSender = message.data['SenderID'];
            if (message.data['Read Status'] == false) {
              Firestore.instance
                  .collection(messagesDB)
                  .document(currentUser.userNumber)
                  .collection(contactUser.contactNumber)
                  .document(message.documentID)
                  .updateData({'Read Status': true});
            }

            if (msgSender == this.currentUser.userNumber) {
              experimentContactNumber = 0;
              if (experimentUserContactNumber == 0) {
                experimentUserContactNumber++;
              } else if (experimentUserContactNumber > 0) {
                isContinuousThis = true;
              }
            } else {
              experimentUserContactNumber = 0;
              if (experimentContactNumber == 0) {
                experimentContactNumber++;
              } else if (experimentContactNumber > 0) {
                isContinuousThis = true;
              }
            }
            if (message.data['type'] == 'Text') {
              final StatelessWidget widgetForMessage = isContinuousThis
                  ? ChatBubbleB(
                      isContinuous: msgSender == this.currentUser.userNumber,
                      senderEmail: msgSender,
                      textMessage: messageText,
                    )
                  : ChatBubble(
                      isMe: msgSender == this.currentUser.userNumber,
                      senderEmail: msgSender,
                      textMessage: messageText,
                    );
              messageWidgets.add(widgetForMessage);
            } else if (message.data['type'] == 'Image') {
              bool msgOwner =
                  msgSender == currentUser.userNumber ? true : false;

              final StatelessWidget widgetForImage = ImageChatBubble(
                msgOwner: msgOwner,
                imageURL: message.data['ImageURL'],
              );
              messageWidgets.add(widgetForImage);
            }

            isContinuousThis = false;
          }

          List<Widget> finalMessagesWidgets = messageWidgets.toList();

          return Expanded(
            child: ListView(
              reverse: true,
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
              children: finalMessagesWidgets,
            ),
          );
        }
        return Container();
      },
    );
  }
}
