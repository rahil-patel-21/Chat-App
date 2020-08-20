import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({this.title, this.actions, this.leading, this.centerTitle});

  final Widget title;
  final List<Widget> actions;
  final Widget leading;
  final bool centerTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 1.4, style: BorderStyle.solid),
        ),
      ),
      child: AppBar(
          backgroundColor: Colors.white,
          elevation: 5,
          leading: leading,
          centerTitle: centerTitle,
          actions: actions,
          title: title),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 2);
}
