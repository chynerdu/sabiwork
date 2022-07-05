import 'package:flutter/material.dart';

class SabiBadges extends StatelessWidget {
  final Color color;
  final String title;
  final Color? titleColor;

  SabiBadges({required this.color, required this.title, this.titleColor});

  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
        decoration: BoxDecoration(
          color: color,
        ),
        child: Text(
          '$title',
          style: TextStyle(
              fontSize: 8,
              fontWeight: FontWeight.w500,
              color: titleColor ?? Colors.black),
        ));
  }
}
