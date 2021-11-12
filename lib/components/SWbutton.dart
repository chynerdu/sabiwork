import 'package:flutter/material.dart';
import 'package:sabiwork/helpers/customColors.dart';

class SWbutton extends StatelessWidget {
  final Function onPressed;
  final String title;
  SWbutton({required this.onPressed, required this.title});

  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: CustomColors.PrimaryColor),
        child: MaterialButton(
            onPressed: () {
              onPressed();
            },
            child: Text('$title',
                style: TextStyle(
                    color: Color(0xffffffff),
                    fontSize: 18,
                    fontWeight: FontWeight.w500))));
  }
}

class SWSuttonSmall extends StatelessWidget {
  final Function onPressed;
  final String title;
  SWSuttonSmall({required this.onPressed, required this.title});

  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: CustomColors.PrimaryColor),
        child: MaterialButton(
            onPressed: () {
              onPressed();
            },
            child: Text('$title',
                style: TextStyle(
                    color: Color(0xffffffff),
                    fontSize: 12,
                    fontWeight: FontWeight.w500))));
  }
}

class SWBorderedButton extends StatelessWidget {
  final Color? color;
  final Function onPressed;
  final String title;
  SWBorderedButton({this.color, required this.onPressed, required this.title});

  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
        ),
        child: OutlinedButton(
            style: ButtonStyle(
                side: MaterialStateProperty.all<BorderSide>(
                    BorderSide(color: color ?? Color(0xffBD4300)))),
            onPressed: () {
              onPressed();
            },
            child: Text('$title',
                style: TextStyle(
                    color: color ?? Color(0xffBD4300),
                    fontSize: 12,
                    fontWeight: FontWeight.w500))));
  }
}
