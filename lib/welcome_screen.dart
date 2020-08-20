import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'authcontroller.dart';
import 'contact_model.dart';
import 'home_screen_a.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  User currentUser;
  List<ContactUser> contactList;
  @override
  void initState() {
    super.initState();
    getUserAndContacts();
  }

  Future<void> getUserAndContacts() async {
    final authBase = Provider.of<AuthBase>(context, listen: false);
    authBase.currentUser().then((User _currentUser) {
      authBase
          .fetchAllContacts(_currentUser)
          .then((List<ContactUser> _contactList) {
        setState(() {
          this.currentUser = _currentUser;
          this.contactList = _contactList;
        });
      }).then((value) {
        Future.delayed(Duration(seconds: 3)).then((value) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HomeScreenA(
                        currentUser: currentUser,
                        contactList: contactList,
                      )));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: <Widget>[
          Expanded(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Icon(
                    Icons.message,
                    color: Colors.white,
                    size: 50,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'By TechAddict Inc.',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
