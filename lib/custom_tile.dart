import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:techexperiment001/universal_variable.dart';

class CustomTile extends StatelessWidget {
  CustomTile(
      {@required this.leading,
      @required this.title,
      @required this.subTitle,
      this.trailing,
      this.icon,
      this.isMini = true,
      this.margin = const EdgeInsets.all(10),
      this.onDoubleTap,
      this.onTap});
  final Widget leading;
  final Widget icon;
  final Widget trailing;
  final Widget title;
  final Widget subTitle;
  final bool isMini;
  final EdgeInsets margin;
  final GestureTapCallback onTap;
  final GestureDoubleTapCallback onDoubleTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        onDoubleTap: onDoubleTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: isMini ? 10 : 0),
          margin: margin,
          child: Row(
            children: <Widget>[
              leading,
              Expanded(
                  child: Container(
                margin: EdgeInsets.only(left: isMini ? 10 : 15),
                padding: EdgeInsets.symmetric(vertical: isMini ? 3 : 20),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            width: 1,
                            color: UniversalVariables.separatorColor))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        title,
                        SizedBox(height: 5),
                        Row(
                          children: <Widget>[
                            icon ?? Container(),
                            subTitle,
                          ],
                        )
                      ],
                    ),
                    trailing ?? Container(),
                  ],
                ),
              ))
            ],
          ),
        ));
  }
}
