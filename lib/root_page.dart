import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'authcontroller.dart';

import './log_in_screen.dart';
import './welcome_screen.dart';

class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authBase = Provider.of<AuthBase>(context, listen: false);
    return StreamBuilder(
      stream: authBase.onAuthStateChanged,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User user = snapshot.data;
          return user == null ? LoginScreen() : WelcomeScreen();
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
