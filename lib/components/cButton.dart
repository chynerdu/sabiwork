import 'package:flutter/material.dart';

class CBlueButtonWithIcon extends StatelessWidget {
  final Widget icon;

  final Widget title;
  final Function onpressed;

  CBlueButtonWithIcon({
    required this.icon,
    required this.title,
    required this.onpressed,
  });
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xff2077C8), Color(0xff0096C7)])),
        child: MaterialButton(
            padding: EdgeInsets.symmetric(horizontal: 4),
            onPressed: onpressed(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [icon, SizedBox(width: 10), title],
            )));
  }
}

class CWhiteButtonWithIcon extends StatelessWidget {
  final Widget icon;

  final Widget title;
  final Function onpressed;

  CWhiteButtonWithIcon({
    required this.icon,
    required this.title,
    required this.onpressed,
  });
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Color(0xff4D545A).withOpacity(0.3),
        ),
        child: MaterialButton(
            padding: EdgeInsets.symmetric(horizontal: 4),
            onPressed: onpressed(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [icon, SizedBox(width: 10), title],
            )));
  }
}
