import 'package:flutter/material.dart';
// import 'package:gradient_app_bar/gradient_app_bar.dart';

// import 'package:techexperiment001/contact_model.dart';
// import 'package:techexperiment001/universal_variable.dart';

// import 'authcontroller.dart';
// import 'chat_screen_a.dart';
// import 'custom_tile.dart';

// class SearchScreen extends StatefulWidget {
//   SearchScreen({@required this.contactUserList, @required this.currentUser})
//       : assert(contactUserList != null);
//   final List<ContactUser> contactUserList;
//   final User currentUser;
//   @override
//   _SearchScreenState createState() => _SearchScreenState();
// }

// class _SearchScreenState extends State<SearchScreen> {
//   String query = '';
//   TextEditingController searchController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//   }

//   searchAppBar(BuildContext context) {
//     return GradientAppBar(
//       backgroundColorStart: UniversalVariables.gradientColorStart,
//       backgroundColorEnd: UniversalVariables.gradientColorEnd,
//       leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () => Navigator.pop(context)),
//       elevation: 0,
//       bottom: PreferredSize(
//           child: Padding(
//             padding: EdgeInsets.only(left: 20),
//             child: TextField(
//               controller: searchController,
//               onChanged: (value) {
//                 setState(() {
//                   query = value;
//                 });
//               },
//               cursorColor: UniversalVariables.blackColor,
//               autofocus: true,
//               style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                   fontSize: 35),
//               decoration: InputDecoration(
//                 suffixIcon: IconButton(
//                   icon: Icon(
//                     Icons.close,
//                     color: Colors.white,
//                   ),
//                   onPressed: () => WidgetsBinding.instance
//                       .addPostFrameCallback((_) => searchController.clear()),
//                 ),
//                 border: InputBorder.none,
//                 hintText: 'Search',
//                 hintStyle: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 35,
//                   color: Color(0x88ffffff),
//                 ),
//               ),
//             ),
//           ),
//           preferredSize: const Size.fromHeight(kToolbarHeight + 20)),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: UniversalVariables.blackColor,
//       appBar: searchAppBar(context),
//       body: Container(
//         padding: EdgeInsets.symmetric(horizontal: 20),
//         child: buildSuggestions(query),
//       ),
//     );
//   }

//   buildSuggestions(String query) {
//     final List<ContactUser> suggestionList = query.isEmpty
//         ? []
//         : widget.contactUserList.where((ContactUser contactUser) {
//             String _getUserName = contactUser.contactName.toLowerCase();
//             String _query = query.toLowerCase();
//             String _getName = contactUser.contactNumber;
//             bool matchesUsername = _getUserName.contains(_query);
//             bool matchesName = _getName.contains(_query);
//             return (matchesName || matchesUsername);
//           }).toList();

//     return searchController.text.trim().length > 0
//         ? ListView.builder(
//             itemCount: suggestionList.length,
//             itemBuilder: (context, index) {
//               ContactUser searchedUSer = ContactUser(
//                 photoURL: suggestionList[index].photoURL,
//                 contactName: suggestionList[index].contactName,
//                 contactNumber: suggestionList[index].contactNumber,
//               );

//               return CustomTile(
//                 isMini: false,
//                 leading: CircleAvatar(
//                   backgroundImage: NetworkImage(searchedUSer.photoURL),
//                   backgroundColor: Colors.grey,
//                 ),
//                 title: Text(searchedUSer.contactName,
//                     style: TextStyle(
//                         color: Colors.white, fontWeight: FontWeight.bold)),
//                 subTitle: Text(searchedUSer.contactNumber),
//                 onTap: () => Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => ChatScreen(
//                               currentUser: widget.currentUser,
//                               contactUser: searchedUSer,
//                             ))),
//                 onDoubleTap: null,
//               );
//             },
//           )
//         : ListView.builder(
//             itemCount: widget.contactUserList.length,
//             itemBuilder: (context, index) {
//               return CustomTile(
//                 onTap: () => Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => ChatScreen(
//                               currentUser: widget.currentUser,
//                               contactUser: widget.contactUserList[index],
//                             ))),
//                 leading: CircleAvatar(
//                   backgroundImage: NetworkImage(
//                       'https://lh3.googleusercontent.com/a-/AOh14GgQ8Ms7Swiu5dou-_mUUFxS_GsA_7qjPq4vQdCTvA=s96-c'),
//                   backgroundColor: Colors.grey,
//                 ),
//                 title: Text(widget.contactUserList[index].contactName),
//                 subTitle: Text(widget.contactUserList[index].contactNumber),
//               );
//             },
//           );
//   }
// }
