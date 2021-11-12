import 'package:flutter/material.dart';

class AppBarAction extends StatelessWidget {
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {},
        child: Container(
            padding: EdgeInsets.only(right: 10), child: Icon(Icons.menu)));
  }
}
