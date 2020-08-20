// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:techexperiment001/contact_model.dart';
// import 'package:techexperiment001/universal_variable.dart';
// import 'authcontroller.dart';
// import 'constants.dart';
// import 'custom_app_bar.dart';
// import 'custom_tile.dart';
// import 'message_model.dart';

// class ChatScreen extends StatefulWidget {
//   ChatScreen({@required this.contactUser});
//   final ContactUser contactUser;
//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   TextEditingController textEditingController = TextEditingController();
//   User sender;

//   bool isWriting = false;

//   @override
//   void initState() {
//     super.initState();

//     final authBase = Provider.of<AuthBase>(context, listen: false);
//     authBase.currentUser().then((User user) {
//       setState(() {
//         sender = User(userID: user.userID, userNumber: user.userNumber);
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: UniversalVariables.blackColor,
//       appBar: customAppBar(context),
//       body: Column(
//         children: <Widget>[
//           Flexible(child: messageList()),
//           chatControls(),
//         ],
//       ),
//     );
//   }

//   Widget messageList() {
//     return StreamBuilder(
//       stream: Firestore.instance
//           .collection(messagesDB)
//           .document(sender.userNumber)
//           .collection(widget.contactUser.contactNumber)
//           .orderBy(timeStampField, descending: true)
//           .snapshots(),
//       builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.data == null) {
//           return Center(child: CircularProgressIndicator());
//         }
//         return ListView.builder(
//           reverse: true,
//           padding: EdgeInsets.all(10),
//           itemCount: snapshot.data.documents.length,
//           itemBuilder: (context, index) {
//             return chatMessageItem(snapshot.data.documents[index]);
//           },
//         );
//       },
//     );
//   }

//   Widget chatMessageItem(DocumentSnapshot documentSnapshot) {
//     Message _message = Message.fromMap(documentSnapshot.data);
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 15),
//       child: Container(
//         alignment: _message.senderID == sender.userNumber
//             ? Alignment.centerRight
//             : Alignment.centerLeft,
//         child: _message.senderID == sender.userNumber
//             ? senderLayout(_message)
//             : receiverLayout(_message),
//       ),
//     );
//   }

//   Widget senderLayout(Message _message) {
//     Radius messageRadius = Radius.circular(10);

//     return Padding(
//       padding: EdgeInsets.only(left: 85),
//       child: Container(
//         margin: EdgeInsets.only(top: 12),
//         constraints:
//             BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 65),
//         decoration: BoxDecoration(
//           color: UniversalVariables.senderColor,
//           borderRadius: BorderRadius.only(
//               topLeft: messageRadius,
//               topRight: messageRadius,
//               bottomLeft: messageRadius),
//         ),
//         child: Padding(
//           padding: EdgeInsets.all(10),
//           child: getMessage(_message),
//         ),
//       ),
//     );
//   }

//   getMessage(Message _message) {
//     return Text(
//       _message.message,
//       style: TextStyle(color: Colors.white, fontSize: 16),
//     );
//   }

//   Widget receiverLayout(Message _message) {
//     Radius messageRadius = Radius.circular(10);

//     return Padding(
//       padding: EdgeInsets.only(right: 85),
//       child: Container(
//         margin: EdgeInsets.only(top: 12),
//         constraints:
//             BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 65),
//         decoration: BoxDecoration(
//           color: UniversalVariables.receiverColor,
//           borderRadius: BorderRadius.only(
//               topLeft: messageRadius,
//               topRight: messageRadius,
//               bottomRight: messageRadius),
//         ),
//         child: Padding(
//           padding: EdgeInsets.all(10),
//           child: getMessage(_message),
//         ),
//       ),
//     );
//   }

//   Widget chatControls() {
//     setWritingTo(bool isWriting) {
//       setState(() {
//         this.isWriting = isWriting;
//       });
//     }

//     addMediaModal(context) {
//       showModalBottomSheet(
//           context: context,
//           builder: (context) {
//             return Column(
//               children: <Widget>[
//                 Container(
//                   padding: EdgeInsets.symmetric(vertical: 15),
//                   child: Row(
//                     children: <Widget>[
//                       FlatButton(
//                         onPressed: () => Navigator.pop(context),
//                         child: Icon(Icons.close),
//                       ),
//                       Expanded(
//                         child: Align(
//                           alignment: Alignment.centerLeft,
//                           child: Text(
//                             'Content & Tools',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//                 Flexible(
//                   child: ListView(
//                     children: <Widget>[
//                       ModalTile(
//                         title: "Media",
//                         subtitle: "Share Photos and Video",
//                         icon: Icons.image,
//                       ),
//                       ModalTile(
//                           title: "File",
//                           subtitle: "Share files",
//                           icon: Icons.tab),
//                       ModalTile(
//                           title: "Contact",
//                           subtitle: "Share contacts",
//                           icon: Icons.contacts),
//                       ModalTile(
//                           title: "Location",
//                           subtitle: "Share a location",
//                           icon: Icons.add_location),
//                       ModalTile(
//                           title: "Schedule Call",
//                           subtitle: "Arrange a skype call and get reminders",
//                           icon: Icons.schedule),
//                       ModalTile(
//                           title: "Create Poll",
//                           subtitle: "Share polls",
//                           icon: Icons.poll)
//                     ],
//                   ),
//                 )
//               ],
//             );
//           },
//           elevation: 0,
//           backgroundColor: UniversalVariables.blackColor);
//     }

//     return Container(
//       padding: EdgeInsets.all(10),
//       child: Row(
//         children: <Widget>[
//           GestureDetector(
//             onTap: () => addMediaModal(context),
//             child: Container(
//               padding: EdgeInsets.all(5),
//               decoration: BoxDecoration(
//                 gradient: UniversalVariables.fabGradient,
//                 shape: BoxShape.circle,
//               ),
//               child: Icon(Icons.add),
//             ),
//           ),
//           SizedBox(width: 5),
//           Expanded(
//             child: TextField(
//               controller: textEditingController,
//               style: TextStyle(color: Colors.white),
//               onChanged: (value) {
//                 (value.length > 0 && value.trim() != '')
//                     ? setWritingTo(true)
//                     : setWritingTo(false);
//               },
//               decoration: InputDecoration(
//                   hintText: 'Type A Message Here',
//                   hintStyle: TextStyle(color: UniversalVariables.greyColor),
//                   border: OutlineInputBorder(
//                       borderRadius: const BorderRadius.all(
//                         const Radius.circular(50),
//                       ),
//                       borderSide: BorderSide.none),
//                   contentPadding:
//                       EdgeInsets.symmetric(horizontal: 20, vertical: 5),
//                   filled: true,
//                   fillColor: UniversalVariables.separatorColor,
//                   suffixIcon:
//                       GestureDetector(onTap: () {}, child: Icon(Icons.face))),
//             ),
//           ),
//           isWriting
//               ? Container()
//               : Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 10),
//                   child: Icon(Icons.record_voice_over),
//                 ),
//           isWriting ? Container() : Icon(Icons.camera_alt),
//           isWriting
//               ? Container(
//                   margin: EdgeInsets.only(left: 10),
//                   decoration: BoxDecoration(
//                     gradient: UniversalVariables.fabGradient,
//                     shape: BoxShape.circle,
//                   ),
//                   child: IconButton(
//                     icon: Icon(
//                       Icons.send,
//                       size: 15,
//                     ),
//                     onPressed: () {
//                       sendMessage();
//                     },
//                   ),
//                 )
//               : Container(),
//         ],
//       ),
//     );
//   }

//   sendMessage() {
//     var text = textEditingController.text;
//     Message _message = Message(
//       message: text,
//       receiverID: widget.contactUser.contactNumber,
//       senderID: sender.userNumber,
//       timeStamp: Timestamp.now(),
//       type: 'Text',
//     );
//     setState(() {
//       isWriting = false;
//     });

//     final authBase = Provider.of<AuthBase>(context, listen: false);
//     // authBase.addMessageToDB(_messageA, _messageB, sender, widget.contactUser);
//   }

//   CustomAppBar customAppBar(context) {
//     return CustomAppBar(
//         title: Text(widget.contactUser.contactName),
//         actions: <Widget>[
//           IconButton(
//               icon: Icon(
//                 Icons.video_call,
//               ),
//               onPressed: null),
//           IconButton(
//               icon: Icon(
//                 Icons.call,
//               ),
//               onPressed: null),
//         ],
//         leading: IconButton(
//             icon: Icon(Icons.arrow_back),
//             onPressed: () => Navigator.pop(context)),
//         centerTitle: false);
//   }
// }

// class ModalTile extends StatelessWidget {
//   ModalTile(
//       {@required this.icon, @required this.subtitle, @required this.title});
//   final String title;
//   final String subtitle;
//   final IconData icon;
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 15),
//       child: CustomTile(
//         isMini: false,
//         leading: Container(
//           margin: EdgeInsets.only(right: 10),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(15),
//             color: UniversalVariables.receiverColor,
//           ),
//           padding: EdgeInsets.all(10),
//           child: Icon(
//             icon,
//             color: UniversalVariables.greyColor,
//             size: 38,
//           ),
//         ),
//         title: Text(
//           title,
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 18,
//             color: Colors.white,
//           ),
//         ),
//         subTitle: Text(
//           subtitle,
//           style: TextStyle(
//             fontSize: 14,
//             color: UniversalVariables.greyColor,
//           ),
//         ),
//       ),
//     );
//   }
// }
