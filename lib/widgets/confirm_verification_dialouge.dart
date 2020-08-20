import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ConfirmCodeDialouge extends StatefulWidget {
  ConfirmCodeDialouge({@required this.verificationID});
  final String verificationID;
  @override
  _ConfirmCodeDialougeState createState() => _ConfirmCodeDialougeState();
}

class _ConfirmCodeDialougeState extends State<ConfirmCodeDialouge> {
  TextEditingController codeController = TextEditingController();
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Enter Confirmatiom Code"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            controller: codeController,
          ),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          child: Text("Confirm"),
          textColor: Colors.white,
          color: Colors.blue,
          onPressed: () async {
            final code = codeController.text.toString().trim();
            print(code + 'is Pressed');
            AuthCredential credential = PhoneAuthProvider.getCredential(
                verificationId: widget.verificationID, smsCode: code);

            final authResult =
                await _firebaseAuth.signInWithCredential(credential);

            FirebaseUser user = authResult.user;

            if (user != null) {
              Navigator.of(context).pop();

              print('Reached');
            } else {
              print("Error");
            }
          },
        )
      ],
    );
  }
}
