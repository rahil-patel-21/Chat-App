import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techexperiment001/constants.dart';
import 'package:techexperiment001/contact_model.dart';
import 'package:techexperiment001/widgets/custom_contacts_tile.dart';

import '../authcontroller.dart';
import '../chat_screen_a.dart';

class ContactScreen extends StatefulWidget {
  ContactScreen({@required this.contactUserList});
  final List<ContactUser> contactUserList;
  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  User currentUser;
  bool appBarStatus = false;
  String query = '';
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final authBase = Provider.of<AuthBase>(context, listen: false);
    authBase.currentUser().then((currentUser) {
      setState(() {
        this.currentUser = currentUser;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        setState(() {
          appBarStatus == true ? appBarStatus = false : Navigator.pop(context);
          WidgetsBinding.instance
              .addPostFrameCallback((_) => searchController.clear());
          query = ' ';
        });
        return;
      },
      child: Scaffold(
        appBar: appBarStatus != true
            ? AppBar(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Select Contact'),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                        widget.contactUserList.length > 1
                            ? '${widget.contactUserList.length} contacts'
                            : '${widget.contactUserList.length} contact',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w400)),
                  ],
                ),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.search),
                    iconSize: 30.0,
                    onPressed: () {
                      setState(() {
                        appBarStatus = true;
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.more_vert),
                    iconSize: 30.0,
                    onPressed: () {},
                  )
                ],
              )
            : AppBar(
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: themecolorB,
                  ),
                  onPressed: () {
                    setState(() {
                      appBarStatus = false;
                    });
                  },
                ),
                backgroundColor: Colors.white,
                elevation: 5,
                title: (Container(
                  margin: EdgeInsets.only(top: 18),
                  height: 30,
                  alignment: Alignment.bottomLeft,
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        query = value;
                      });
                    },
                    controller: searchController,
                    style: TextStyle(
                        color: themecolorB,
                        fontSize: 19,
                        fontWeight: FontWeight.w700),
                    maxLength: 18,
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    decoration: InputDecoration(
                      counter: SizedBox.shrink(),
                      hintMaxLines: 1,
                      hintText: 'Search Contacts Here . . .',
                      hintStyle: TextStyle(fontSize: 16.0),
                      disabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      border: InputBorder.none,
                      errorBorder: InputBorder.none,
                    ),
                    autofocus: true,
                  ),
                )),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      size: 25,
                      color: themecolorB,
                    ),
                    onPressed: () {
                      setState(() {
                        WidgetsBinding.instance.addPostFrameCallback(
                            (_) => searchController.clear());
                        query = ' ';
                      });
                    },
                  )
                ],
              ),
        body: buildSuggestions(query),
      ),
    );
  }

  buildSuggestions(String query) {
    final List<ContactUser> suggestionList = query.isEmpty
        ? []
        : widget.contactUserList.where((ContactUser contactUser) {
            String _getUserName = contactUser.contactName.toLowerCase();
            String _query = query.toLowerCase();
            String _getName = contactUser.contactNumber;
            bool matchesUsername = _getUserName.contains(_query);
            bool matchesName = _getName.contains(_query);
            return (matchesName || matchesUsername);
          }).toList();

    return searchController.text.trim().length > 0
        ? ListView.builder(
            itemCount: suggestionList.length,
            itemBuilder: (context, index) {
              ContactUser searchedUSer = ContactUser(
                photoURL: suggestionList[index].photoURL,
                contactName: suggestionList[index].contactName,
                contactNumber: suggestionList[index].contactNumber,
              );

              return CustomContactTile(
                imageURL: searchedUSer.photoURL,
                title: searchedUSer.contactName,
                subTitle: searchedUSer.contactNumber,
                onTap: () {},
              );
            },
          )
        : ListView.builder(
            itemCount: widget.contactUserList.length,
            itemBuilder: (context, index) {
              return CustomContactTile(
                imageURL: widget.contactUserList[index].photoURL,
                title: widget.contactUserList[index].contactName,
                subTitle: widget.contactUserList[index].contactNumber,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatScreen(
                      currentUser: currentUser,
                      contactUser: widget.contactUserList[index],
                    ),
                  ),
                ),
              );
            },
          );
  }
}
