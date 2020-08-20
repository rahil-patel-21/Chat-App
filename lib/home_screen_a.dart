import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:techexperiment001/chat_screen_a.dart';
import 'package:techexperiment001/constants/reference_constants.dart';
import 'package:techexperiment001/screens/live_screen.dart';

import 'authcontroller.dart';
import 'constants.dart';
import 'contact_model.dart';
import 'dashboard.dart';
import 'hamburger_menu.dart';
import 'message_model.dart';
import 'story_panel.dart';

final Color backgroundColor = Color(0xFF1D1B1D);

class HomeScreenA extends StatefulWidget {
  HomeScreenA({@required this.contactList, @required this.currentUser});
  final User currentUser;
  final List<ContactUser> contactList;
  @override
  _HomeScreenAState createState() => _HomeScreenAState();
}

class _HomeScreenAState extends State<HomeScreenA> {
  String photoURL;
  bool isCollapsed = false;
  double screenWidth;
  Duration duration = const Duration(milliseconds: 100);

  @override
  void initState() {
    super.initState();
    //  getPhotoURL(widget.currentUser);
  }

  // Future<void> getPhotoURL(User currentUser) async {
  //   await Firestore.instance
  //       .collection('AllUsers')
  //       .document(currentUser.userNumber)
  //       .get()
  //       .then((value) => setState(() {
  //             photoURL = value.data['PhotoURL'];
  //           }));
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenWidth = size.width;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        color: Color(0xFF102027),
        child: Stack(
          children: <Widget>[
            DashBoard(
              photoURL: photoURL,
            ),
            homeScreen(),
          ],
        ),
      ),
    );
  }

  Widget homeScreen() {
    return AnimatedPositioned(
      duration: duration,
      left: isCollapsed ? 0.60 * screenWidth : 0.0,
      right: isCollapsed ? -0.60 * screenWidth : 0.0,
      top: 0.0,
      bottom: 0.0,
      child: Scaffold(
        //drawer: DividerC(),
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  setState(() {
                    isCollapsed = !isCollapsed;
                  });
                },
                child: HamburgerMenu(),
              ),
            ],
          ),
          title: Text(
            'Chats',
            style: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              iconSize: 30.0,
              color: Colors.white,
              onPressed: () {},
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              StoryPanel(
                photoURL: photoURL ?? '',
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.0),
                      topRight: Radius.circular(25.0),
                    ),
                  ),
                  child: StreamBuilder(
                    stream: Firestore.instance
                        .collection(messagesDB)
                        .document(widget.currentUser.userNumber)
                        .collection('Recent Chats')
                        .orderBy('timestamp', descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      try {
                        if (snapshot.connectionState ==
                            ConnectionState.active) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              itemCount: snapshot.data.documents.length,
                              itemBuilder: (context, index) {
                                Message _message = Message.fromMap(
                                    snapshot.data.documents[index].data);
                                ContactUser customContactUser;
                                for (int i = 0;
                                    i < widget.contactList.length;
                                    i++) {
                                  if (_message.companionID ==
                                      widget.contactList[i].contactNumber) {
                                    customContactUser = widget.contactList[i];
                                  }
                                }
                                if (customContactUser == null) {
                                  customContactUser = ContactUser(
                                      photoURL: '',
                                      contactNumber: _message.companionID);
                                }

                                return _ChatItem(
                                    customContactUser.contactName ??
                                        customContactUser.contactNumber,
                                    customContactUser.photoURL,
                                    _message.readStatus == false ? 1 : 0,
                                    true,
                                    _message.message,
                                    DateFormat.jm()
                                        .format(_message.timeStamp.toDate()),
                                    // DateFormat.EEEE()
                                    //     .format(_message.timeStamp.toDate()), -> Saturday,
                                    // DateFormat.Hm()
                                    //     .format(_message.timeStamp.toDate()), -> 15:09,
                                    // DateFormat.MMMd()
                                    //     .format(_message.timeStamp.toDate()), -> May 16,
                                    // DateFormat.yMd()
                                    //     .format(_message.timeStamp.toDate()), -> 5/16/2020,
                                    // DateFormat.yMMMM()
                                    //     .format(_message.timeStamp.toDate()),
                                    // DateFormat.yMEd()
                                    //     .format(_message.timeStamp.toDate()),
                                    // DateFormat.MMMEd()
                                    //     .format(_message.timeStamp.toDate()),
                                    customContactUser,
                                    widget.currentUser);
                              },
                            );
                          }
                          return Container();
                        }
                      } catch (e) {
                        return Container();
                      }

                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: themeColorC,
          // onPressed: () async {
          //   Map<String, String> map = {};
          //   List<Contact> contacts =
          //       (await ContactsService.getContacts(withThumbnails: false))
          //           .toList();
          //   for (var contact in contacts) {
          //     if (contact.phones.length > 0) {
          //       var phoneNumber = contact.phones.elementAt(0).value;
          //       var name = contact.displayName;
          //       map[name] = phoneNumber;
          //     }
          //   }
          //   print(map.toString() + 'izz');
          // },
          onPressed: () async {
            await liveStreamsCollection
                .document(widget.currentUser.userNumber)
                .setData({'Live Stream': true});
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => LiveScreen(isMeLive: true)));
          },
          // builder: (context) => ContactScreen(
          //       contactUserList: widget.contactList,
          //     ))),
          // onPressed: () => Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => SearchScreen(
          //       currentUser: widget.currentUser,
          //       contactUserList: widget.contactList,
          //     ),
          //   ),
          // ),
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

class DividerC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10.0, left: 87.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: SizedBox(
          width: double.infinity,
          height: 0.6,
        ),
      ),
    );
  }
}

class _ChatItem extends StatelessWidget {
  final String imgURL, name, message, date;
  final int unread;
  final bool active;
  final ContactUser contactUser;
  final User currentUser;

  _ChatItem(this.name, this.imgURL, this.unread, this.active, this.message,
      this.date, this.contactUser, this.currentUser);

  Widget _activeIcon(isActive) {
    if (isActive) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: EdgeInsets.all(3),
          width: 16,
          height: 16,
          color: Colors.white,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Container(
              color: Color(0xff43ce7d), // flat green
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(
              currentUser: currentUser,
              contactUser: contactUser,
            ),
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 7),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              color: Colors.white,
              margin: EdgeInsets.only(right: 12.0),
              child: Stack(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      print('You want to see the display pictute.');
                    },
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(imgURL),
                      radius: 30.0,
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: _activeIcon(active),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 6.0, right: 6.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      this.name,
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Font005',
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      margin: EdgeInsets.only(top: 4.0),
                      child: message != null
                          ? Text(this.message,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                                height: 1.1,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis)
                          : Row(
                              children: <Widget>[
                                Icon(Icons.photo, color: Colors.grey),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Image',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                    )
                  ],
                ),
              ),
            ),
            Column(
              children: <Widget>[
                Text(
                  date,
                  style: TextStyle(
                    color: Colors.grey[350],
                  ),
                ),
                StreamBuilder(
                  stream: Firestore.instance
                      .collection(messagesDB)
                      .document(currentUser.userNumber)
                      .collection(contactUser.contactNumber)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      if (snapshot.hasData) {
                        int readCounter = 0;
                        for (int i = 0;
                            i < snapshot.data.documents.length;
                            i++) {
                          if (snapshot.data.documents[i].data['Read Status'] ==
                              false) {
                            readCounter++;
                          }
                        }
                        return _UnreadIndicator(readCounter);
                      }
                      return Container();
                    }
                    return Container();
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _UnreadIndicator extends StatelessWidget {
  final int unread;
  _UnreadIndicator(this.unread);
  @override
  Widget build(BuildContext context) {
    if (unread == 0) {
      return Container(); // return empty container
    } else {
      return Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height: 30,
            color: Color(0xFF34515e),
            width: 30,
            padding: EdgeInsets.all(0),
            alignment: Alignment.center,
            child: Text(
              unread.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
    }
  }
}
