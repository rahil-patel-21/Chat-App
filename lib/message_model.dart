import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  Message(
      {this.message,
      this.type,
      this.timeStamp,
      this.readStatus,
      this.companionID,
      this.senderID,
      this.photoURL});
  String type;
  String message;
  Timestamp timeStamp;
  String photoURL;
  bool readStatus;
  String companionID;
  String senderID;

  Message.imageMessage(
      {this.message,
      this.photoURL,
      this.timeStamp,
      this.type,
      this.readStatus});

  Map toMap() {
    var map = Map<String, dynamic>();
    map['ImageURL'] = this.photoURL;
    map['type'] = this.type;
    map['message'] = this.message;
    map['timestamp'] = this.timeStamp;
    map['Read Status'] = this.readStatus;
    map['CompanionID'] = this.companionID;
    map['SenderID'] = this.senderID;
    return map;
  }

  Message.fromMap(Map<String, dynamic> map) {
    this.type = map['type'];
    this.message = map['message'];
    this.timeStamp = map['timestamp'];
    this.readStatus = map['Read Status'];
    this.companionID = map['CompanionID'];
    this.senderID = map['SenderID'];
    this.photoURL = map['ImageURL'];
  }
}
