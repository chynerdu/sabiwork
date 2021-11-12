import 'package:flutter/material.dart';

class AppBarLeading extends StatelessWidget {
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      InkWell(
        onTap: () {},
        child: Container(
            height: 38,
            width: 38,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xff20262D), Color(0xff29323D)])),
            child: Center(
              child: Icon(Icons.notifications, size: 17),
            )),
      )
    ]);
  }
}
