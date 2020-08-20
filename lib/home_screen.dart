// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// // import 'package:techexperiment001/chat_screen.dart';
// // import 'package:techexperiment001/custom_tile.dart';
// // import 'package:techexperiment001/search_screen.dart';

// // import 'authcontroller.dart';
// // import 'constants.dart';
// // import 'message_model.dart';

// // class HomeScreen extends StatefulWidget {
// //   @override
// //   _HomeScreenState createState() => _HomeScreenState();
// // }

// // class _HomeScreenState extends State<HomeScreen> {
// //   User currentUser;
// //   @override
// //   void initState() {
// //     super.initState();
// //     final authBase = Provider.of<AuthBase>(context, listen: false);
// //     authBase.currentUser().then((User currentUser) {
// //       setState(() {
// //         this.currentUser = currentUser;
// //       });
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         centerTitle: true,
// //         title: Text('HomeScreen'),
// //       ),
// //       body: currentUser != null
// //           ? StreamBuilder(
// //               stream: Firestore.instance
// //                   .collection(messagesDB)
// //                   .document(currentUser.userNumber)
// //                   .collection('Recent Chats')
// //                   .orderBy(timeStampField, descending: true)
// //                   .snapshots(),
// //               builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
// //                 if (snapshot.connectionState == ConnectionState.active) {
// //                   if (snapshot.data == null) {
// //                     return Center(child: CircularProgressIndicator());
// //                   }
// //                   return ListView.builder(
// //                       itemCount: snapshot.data.documents.length,
// //                       itemBuilder: (context, index) {
// //                         Message _message = Message.fromMap(
// //                             snapshot.data.documents[index].data);
// //                         return CustomTile(
// //                             onTap: () => Navigator.push(
// //                                 context,
// //                                 MaterialPageRoute(
// //                                     builder: (context) => ChatScreen())),
// //                             leading: Text(
// //                                 _message.timeStamp.toDate().year.toString()),
// //                             title: Text(
// //                                 _message.receiverID != currentUser.userNumber
// //                                     ? _message.receiverID
// //                                     : _message.senderID),
// //                             subTitle: Text(_message.message));
// //                       });
// //                 } else {
// //                   return Center(
// //                     child: CircularProgressIndicator(),
// //                   );
// //                 }
// //               },
// //             )
// //           : Center(
// //               child: CircularProgressIndicator(),
// //             ),
// //       floatingActionButton: FloatingActionButton(
// //         onPressed: () => Navigator.push(
// //           context,
// //           MaterialPageRoute(
// //             builder: (context) => SearchScreen(),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// // import 'package:techexperiment001/chat_screen.dart';
// // import 'package:techexperiment001/contact_model.dart';
// // import 'package:techexperiment001/custom_tile.dart';
// // import 'package:techexperiment001/search_screen.dart';

// // import 'authcontroller.dart';
// // import 'constants.dart';
// // import 'message_model.dart';

// // class HomeScreen extends StatefulWidget {
// //   @override
// //   _HomeScreenState createState() => _HomeScreenState();
// // }

// // class _HomeScreenState extends State<HomeScreen> {
// //   User currentUser;
// //   List<ContactUser> contactList;
// //   @override
// //   void initState() {
// //     super.initState();
// //     final authBase = Provider.of<AuthBase>(context, listen: false);
// //     authBase.currentUser().then((User _currentUser) {
// //       authBase
// //           .fetchAllContacts(_currentUser)
// //           .then((List<ContactUser> _contactList) {
// //         setState(() {
// //           this.currentUser = _currentUser;
// //           this.contactList = _contactList;
// //         });
// //       });
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         centerTitle: true,
// //         title: Text('HomeScreen'),
// //       ),
// //       body: currentUser != null && contactList != null
// //           ? ListView.builder(
// //               itemCount: contactList.length,
// //               itemBuilder: (context, index) {
// //                 return StreamBuilder(
// //                   stream: Firestore.instance
// //                       .collection(messagesDB)
// //                       .document(currentUser.userNumber)
// //                       .collection(contactList[index].contactNumber)
// //                       .snapshots(),
// //                   builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
// //                     try {
// //                       if (snapshot.connectionState == ConnectionState.active) {
// //                         if (snapshot.data != null) {
// //                           if (snapshot.data.documents[0].data != null) {
// //                             Message _message = Message.fromMap(snapshot
// //                                 .data
// //                                 .documents[snapshot.data.documents.length - 1]
// //                                 .data);
// //                             ContactUser contactUseR = contactList[index];
// //                             return CustomTile(
// //                                 onTap: () => Navigator.push(
// //                                     context,
// //                                     MaterialPageRoute(
// //                                         builder: (context) => ChatScreen(
// //                                               contactUser: contactUseR,
// //                                             ))),
// //                                 leading: Text(_message.timeStamp
// //                                     .toDate()
// //                                     .year
// //                                     .toString()),
// //                                 title: Text(_message.receiverID),
// //                                 subTitle: Text(_message.message));
// //                           }
// //                         }
// //                         return Container();
// //                       } else {
// //                         return Container();
// //                       }
// //                     } catch (error) {
// //                       return Container();
// //                     }
// //                   },
// //                 );
// //               },
// //             )
// //           : Center(
// //               child: CircularProgressIndicator(),
// //             ),
// //       floatingActionButton: FloatingActionButton(
// //         onPressed: () => Navigator.push(
// //           context,
// //           MaterialPageRoute(
// //             builder: (context) => SearchScreen(),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:techexperiment001/chat_screen.dart';
// import 'package:techexperiment001/contact_model.dart';
// import 'package:techexperiment001/custom_tile.dart';
// import 'package:techexperiment001/search_screen.dart';

// import 'authcontroller.dart';
// import 'constants.dart';
// import 'message_model.dart';

// class HomeScreen extends StatefulWidget {
//   HomeScreen({@required this.currentUser, @required this.contactList})
//       : assert(currentUser != null);
//   final User currentUser;
//   final List<ContactUser> contactList;
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () {
//         return;
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           title: Text('HomeScreen'),
//         ),
//         body: widget.currentUser.userNumber != null
//             ? StreamBuilder(
//                 stream: Firestore.instance
//                     .collection(messagesDB)
//                     .document(widget.currentUser.userNumber)
//                     .collection('Recent Chats')
//                     .orderBy('timestamp', descending: true)
//                     .snapshots(),
//                 builder: (context, snapshot) {
//                   try {
//                     if (snapshot.connectionState == ConnectionState.active) {
//                       if (snapshot.hasData) {
//                         return ListView.builder(
//                           itemCount: snapshot.data.documents.length,
//                           itemBuilder: (context, index) {
//                             Message _message = Message.fromMap(
//                                 snapshot.data.documents[index].data);
//                             ContactUser customContactUser;
//                             if (_message.receiverID ==
//                                 widget.currentUser.userNumber) {
//                             } else {
//                               for (int i = 0;
//                                   i < widget.contactList.length;
//                                   i++) {
//                                 if (_message.receiverID ==
//                                     widget.contactList[i].contactNumber) {
//                                   customContactUser = widget.contactList[i];
//                                 }
//                               }
//                             }

//                             return CustomTile(
//                               onTap: () => Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => ChatScreen(
//                                       contactUser: customContactUser),
//                                 ),
//                               ),
//                               leading: Container(),
//                               title: Text(customContactUser.contactName),
//                               subTitle: Text(_message.message),
//                             );
//                           },
//                         );
//                       }
//                       return Container();
//                     }
//                   } catch (e) {
//                     return Container();
//                   }

//                   return Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 },
//               )
//             : Container(),
//         // floatingActionButton: FloatingActionButton(
//         //   onPressed: () => Navigator.push(
//         //     context,
//         //     MaterialPageRoute(
//         //       builder: (context) => SearchScreen(),
//         //     ),
//         //   ),
//         // ),
//       ),
//     );
//   }
// }
