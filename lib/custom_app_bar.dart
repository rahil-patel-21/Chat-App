import 'package:flutter/material.dart';
import 'package:techexperiment001/universal_variable.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar(
      {@required this.title,
      @required this.actions,
      @required this.leading,
      @required this.centerTitle});

  final Widget title;
  final List<Widget> actions;
  final Widget leading;
  final bool centerTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: UniversalVariables.blackColor,
        border: Border(
          bottom: BorderSide(
              color: UniversalVariables.separatorColor,
              width: 1.4,
              style: BorderStyle.solid),
        ),
      ),
      child: AppBar(
          backgroundColor: UniversalVariables.blackColor,
          elevation: 0,
          leading: leading,
          centerTitle: centerTitle,
          actions: actions,
          title: title),
    );
  }

  final Size prefferedSize = const Size.fromHeight(kToolbarHeight + 10);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10);
}
