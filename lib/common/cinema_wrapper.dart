import 'package:flutter/material.dart';

class CinemaWrapper extends StatelessWidget {
  final Widget child;
  CinemaWrapper({required this.child});

  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xff20262D), Color(0xff29323D)])),
        child: child);
  }
}
