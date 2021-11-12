import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HorizontalOrLine extends StatelessWidget {
  const HorizontalOrLine({
    required this.label,
    required this.height,
  });

  final String label;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Expanded(
        child: new Container(
            margin: const EdgeInsets.only(left: 10.0, right: 15.0),
            child: Divider(
              color: Color(0xff4D545A),
              height: height,
            )),
      ),
      Container(
        height: 32,
        width: 32,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xff3E4145), Color(0xff2C3644)])),
        child: Center(
            child: Text(label,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white))),
      ),
      Expanded(
        child: new Container(
            margin: const EdgeInsets.only(left: 15.0, right: 10.0),
            child: Divider(
              color: Color(0xff4D545A),
              height: height,
            )),
      ),
    ]);
  }
}
