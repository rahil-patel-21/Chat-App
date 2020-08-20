import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:techexperiment001/contact_model.dart';
import 'package:techexperiment001/widgets/confirm_verification_dialouge.dart';

import 'constants.dart';
import 'message_model.dart';

class User {
  User({
    @required this.userID,
    @required this.userNumber,
  });
  final String userID;
  final String userNumber;
}

abstract class AuthBase {
  Stream<User> get onAuthStateChanged;
  Future<User> currentUser();
  Future<User> verifyPhoneNumber(String phoneNumber, BuildContext buildContext,
      TextEditingController codeController);
  Future<void> signOut();
  Future<List<ContactUser>> fetchAllContacts(User currentUser);
  Future<void> addMessageToDB(Message messageForMe, Message messageForThem);
  // Future<String> photoURL(FirebaseUser _firebaseUser);
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;
  final _firestore = Firestore.instance;

  // Future<String> photoURL(FirebaseUser _firebaseUser) async {
  //   String photuURL;
  //   await Firestore.instance
  //       .collection('AllUsers')
  //       .document(_firebaseUser.phoneNumber)
  //       .get()
  //       .then((value) => photuURL = value.data['PhotoURL']);
  //   print(photuURL + 'izz');
  //   return photuURL;
  // }

  User _firebaseUser(FirebaseUser _firebaseUser) {
    if (_firebaseUser == null) {
      return null;
    } else {
      return User(
        userID: _firebaseUser.uid,
        userNumber: _firebaseUser.phoneNumber,
      );
    }
  }

  @override
  Future<List<ContactUser>> fetchAllContacts(User currentUser) async {
    List<ContactUser> contactList = List<ContactUser>();

    List<Contact> contacts =
        (await ContactsService.getContacts(withThumbnails: false)).toList();

    QuerySnapshot querySnapshot =
        await _firestore.collection('AllUsers').getDocuments();

    for (int i = 0; i < querySnapshot.documents.length; i++) {
      if (querySnapshot.documents[i].documentID != currentUser.userNumber) {
        String photoURL = querySnapshot.documents[i].data['PhotoURL'];

        String phoneNumber = querySnapshot.documents[i].documentID.substring(
            querySnapshot.documents[i].documentID.length - 10,
            querySnapshot.documents[i].documentID.length);

        String contactNumberA = querySnapshot.documents[i].documentID;

        for (Contact contact in contacts) {
          List<String> contactNumber = [];
          if (contact.phones.length > 0) {
            for (int i = 0; i < contact.phones.length; i++) {
              if (!contactNumber.contains(contact.phones
                      .elementAt(i)
                      .value
                      .trim()
                      .replaceAll(" ", '')) &&
                  contact.phones
                      .elementAt(i)
                      .value
                      .trim()
                      .replaceAll(" ", "")
                      .contains(phoneNumber)) {
                print('Done');
                contactNumber.add(contact.phones
                    .elementAt(i)
                    .value
                    .trim()
                    .replaceAll(" ", ''));
                contactList.add(ContactUser(
                    photoURL: photoURL,
                    contactName: contact.displayName,
                    contactNumber: contactNumberA));

                contactList.sort((a, b) {
                  return a.contactName
                      .toLowerCase()
                      .compareTo(b.contactName.toLowerCase());
                });
              }
            }
          }
        }
      }
    }
    return contactList;
  }

  @override
  Future<void> addMessageToDB(
      Message messageForMe, Message messageForThem) async {
    var mapForMe = messageForMe.toMap();
    var mapForThem = messageForThem.toMap();
    await _firestore
        .collection(messagesDB)
        .document(messageForThem.companionID)
        .collection(messageForMe.companionID)
        .add(mapForMe);

    await _firestore
        .collection(messagesDB)
        .document(messageForThem.companionID)
        .collection('Recent Chats')
        .document(messageForMe.companionID)
        .setData(mapForMe);

    await _firestore
        .collection(messagesDB)
        .document(messageForMe.companionID)
        .collection('Recent Chats')
        .document(messageForThem.companionID)
        .setData(mapForThem);

    await _firestore
        .collection(messagesDB)
        .document(messageForMe.companionID)
        .collection(messageForThem.companionID)
        .add(mapForThem);
  }

  @override
  Stream<User> get onAuthStateChanged {
    return _firebaseAuth.onAuthStateChanged.map(_firebaseUser);
  }

  @override
  Future<User> currentUser() async {
    final user = await _firebaseAuth.currentUser();
    return _firebaseUser(user);
  }

  @override
  Future<User> verifyPhoneNumber(String phoneNumber, BuildContext buildContext,
      TextEditingController codeController) async {
    FirebaseUser _user;
    await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential authCredential) async {
          final authResult =
              await _firebaseAuth.signInWithCredential(authCredential);
          _user = authResult.user;
        },
        verificationFailed: (AuthException authException) {
          print(authException.toString());
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
          showDialog(
              context: buildContext,
              barrierDismissible: false,
              builder: (context) {
                return ConfirmCodeDialouge(
                  verificationID: verificationId,
                );
              });
        },
        codeAutoRetrievalTimeout: null);
    return _firebaseUser(_user);
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}

// Widget widget = AlertDialog(
//   title: Text("Enter Confirmatiom Code"),
//   content: Column(
//     mainAxisSize: MainAxisSize.min,
//     children: <Widget>[
//       TextField(
//         controller: _codeController,
//       ),
//     ],
//   ),
//   actions: <Widget>[
//     FlatButton(
//       child: Text("Confirm"),
//       textColor: Colors.white,
//       color: Colors.blue,
//       onPressed: () async {
//         final code = _codeController.text.trim();
//         AuthCredential credential = PhoneAuthProvider.getCredential(
//             verificationId: verificationId, smsCode: code);

//         final authResult = await _firebaseAuth.signInWithCredential(credential);

//         FirebaseUser user = authResult.user;

//         if (user != null) {
//           Navigator.of(context).pop();

//           print('Reached');
//         } else {
//           print("Error");
//         }
//       },

//     )
//   ],
// );

//  @override
//   Future<List<ContactUser>> fetchAllContacts(User currentUser) async {
//     List<ContactUser> contactList = List<ContactUser>();

//     List<Contact> contacts =
//         (await ContactsService.getContacts(withThumbnails: false)).toList();

//     QuerySnapshot querySnapshot =
//         await _firestore.collection('AllUsers').getDocuments();

//     for (int i = 0; i < querySnapshot.documents.length; i++) {
//       if (querySnapshot.documents[i].documentID != currentUser.userNumber) {
//         String photoURL = querySnapshot.documents[i].data['PhotoURL'];

//         String phoneNumber = querySnapshot.documents[i].documentID.substring(
//             querySnapshot.documents[i].documentID.length - 10,
//             querySnapshot.documents[i].documentID.length);

//         String contactNumberA = querySnapshot.documents[i].documentID;

//         for (Contact contact in contacts) {
//           List<String> contactNumber = [];
//           if (contact.phones.length > 0) {
//             for (int i = 0; i < contact.phones.length; i++) {
//               if (contact.phones
//                       .elementAt(i)
//                       .value
//                       .replaceAll(' ', '')
//                       .trim()
//                       .contains(phoneNumber) &&
//                   !contactNumber.contains(contact.phones
//                       .elementAt(i)
//                       .value
//                       .replaceAll(' ', '')
//                       .substring(contact.phones.elementAt(i).value.length - 10,
//                           contact.phones.elementAt(i).value.length))) {
//                 contactNumber.add(contact.phones
//                     .elementAt(i)
//                     .value
//                     .replaceAll(' ', '')
//                     .substring(
//                         contact.phones.elementAt(i).value.length - 10,
//                         contact.phones
//                             .elementAt(i)
//                             .value
//                             .replaceAll(' ', '')
//                             .length));
//                 contactList.add(ContactUser(
//                     photoURL: photoURL,
//                     contactName: contact.displayName,
//                     contactNumber: contactNumberA));

//                 contactList.sort((a, b) {
//                   return a.contactName
//                       .toLowerCase()
//                       .compareTo(b.contactName.toLowerCase());
//                 });
//               }
//             }
//           }
//         }
//       }
//     }
//     return contactList;
//   }
