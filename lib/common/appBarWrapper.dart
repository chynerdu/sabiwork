import 'package:flutter/material.dart';

class AppBarWrapper extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xff3E4145), Color(0xff2C3644)])),
    );
  }
}
