import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'authcontroller.dart';
import 'constants.dart';

class DashBoard extends StatelessWidget {
  DashBoard({@required this.photoURL});
  final String photoURL;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 6,
                  child: Stories(
                    'https://1.bp.blogspot.com/-imHxVupb2m8/XQMofGdADzI/AAAAAAAAAIY/kYUS486BlF0FDoWX0ltDkpk0nanZj3TVgCLcBGAs/s1600/2001284889634654744.jpg',
                    'TechAddict',
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: <Widget>[
                            Icon(
                              Icons.dashboard,
                              color: Colors.white,
                              size: 20.0,
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text("Profile",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 23,
                                  fontFamily: 'Font005',
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: <Widget>[
                            Icon(
                              Icons.lock_outline,
                              color: Colors.white,
                              size: 20.0,
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text("Privacy",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 23,
                                  fontFamily: 'Font005',
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: <Widget>[
                            Icon(
                              Icons.security,
                              color: Colors.white,
                              size: 20.0,
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              "Security",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 23,
                                fontFamily: 'Font005',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: <Widget>[
                            Icon(
                              Icons.settings,
                              color: Colors.white,
                              size: 20.0,
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              "Settings",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 23,
                                fontFamily: 'Font005',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: <Widget>[
                            Icon(
                              Icons.help,
                              color: Colors.white,
                              size: 20.0,
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              "Help",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 23,
                                  fontFamily: 'Font005'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: <Widget>[
                          IconButton(
                              icon: Icon(Icons.exit_to_app),
                              onPressed: () {
                                final authBase = Provider.of<AuthBase>(context,
                                    listen: false);
                                authBase.signOut();
                              })
                          // Icon(
                          //   Icons.exit_to_app,
                          //   color: Colors.white,
                          //   size: 20.0,
                          // ),
                          // SizedBox(
                          //   width: 10.0,
                          // ),
                          // Text(
                          //   "Log Out",
                          //   style: TextStyle(
                          //       color: Colors.white,
                          //       fontSize: 23,
                          //       fontFamily: 'Font005'),
                          // ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Stories extends StatelessWidget {
  final String imgURL, name;

  Stories(this.imgURL, this.name);
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Color(0xFF102027),
      // color: Colors.red,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(10.0, 10.0, 4.0, 5.0),
            child: Container(
              child: Stack(
                children: <Widget>[
                  CircleAvatar(
                    radius: 46.5,
                    backgroundColor: Colors.grey,
                    child: CircleAvatar(
                      radius: 45.0,
                      backgroundImage: NetworkImage(imgURL),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 5.0, left: 5.0, top: 5.0),
            child: Text(
              name,
              style: TextStyle(
                  fontSize: 19.0, color: Colors.white, fontFamily: 'Font005'),
              textAlign: TextAlign.center,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.location_on,
                color: themeColorC,
                size: 18.0,
              ),
              Text(
                'Daman & Diu',
                style: TextStyle(
                    fontSize: 14.0, color: Colors.grey, fontFamily: 'Font005'),
                textAlign: TextAlign.center,
              ),
            ],
          )
        ],
      ),
    );
  }
}
