import 'package:flutter/foundation.dart';

class ContactUser {
  ContactUser(
      {this.contactName,
      @required this.contactNumber,
      @required this.photoURL});
  String contactName;
  final String contactNumber;
  String photoURL;
}
