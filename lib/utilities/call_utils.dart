import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../authcontroller.dart';
import '../models/call_model.dart';
import '../constants/reference_constants.dart';
import '../contact_model.dart';
import '../screens/active_call_screen.dart';

class CallUtils {
  static Future<void> connectingCall(
      {@required User currentUser,
      @required ContactUser contactUser,
      @required BuildContext context}) async {
    try {
      DocumentSnapshot documentSnapshot = await callCollection
          .document(contactUser.contactNumber)
          .snapshots()
          .first;
      if (documentSnapshot.data == null) {
        String callChannelID = Random().nextInt(100000).toString();
        final Call call = Call(
            callerNumber: contactUser.contactNumber,
            callChannelID: callChannelID);
        await callCollection
            .document(contactUser.contactNumber)
            .setData(call.dataToMap(call));
        await callCollection
            .document(currentUser.userNumber)
            .setData(call.dataToMap(call));
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CallScreen(
                currentUser: currentUser,
                contactUser: contactUser,
              ),
            ));
      } else {
        String callChannelID = Random().nextInt(100000).toString();
        final Call call = Call(
            callerNumber: contactUser.contactNumber,
            callChannelID: callChannelID);
        await callCollection
            .document(contactUser.contactNumber)
            .setData(call.dataToMap(call));
        await callCollection
            .document(currentUser.userNumber)
            .setData(call.dataToMap(call));
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CallScreen(
                currentUser: currentUser,
                contactUser: contactUser,
              ),
            ));
      }
    } catch (error) {
      print(error.toString());
    }
  }

  static Future<void> disconnectingCall(
      {@required User currentUser,
      @required ContactUser contactUser,
      @required BuildContext context}) async {
    try {
      await callCollection.document(currentUser.userNumber).delete();
      await callCollection.document(contactUser.contactNumber).delete();
      Navigator.pop(context);
    } catch (error) {
      print(error.toString());
    }
  }
}
