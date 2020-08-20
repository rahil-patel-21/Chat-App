import 'package:flutter/material.dart';

class HamburgerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        HamBurgerElement(
          right: 15.0,
          left: 10.0,
          bottom: 3.5,
        ),
        HamBurgerElement(
          right: 22.0,
          left: 10.0,
          bottom: 3.5,
        ),
        HamBurgerElement(
          right: 15.0,
          left: 10.0,
          bottom: 3.5,
        ),
      ],
    );
  }
}

class HamBurgerElement extends StatelessWidget {
  final double right, left, bottom;
  HamBurgerElement({this.right, this.left, this.bottom});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: right,
        left: left,
        bottom: bottom,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: SizedBox(
          height: 3.9,
        ),
      ),
    );
  }
}
