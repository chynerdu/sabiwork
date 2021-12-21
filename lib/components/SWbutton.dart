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
            color: CustomColors.ButtonColor),
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
            color: CustomColors.ButtonColor),
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

class SWSuttonSmallDisbaled extends StatelessWidget {
  final Function onPressed;
  final String title;
  SWSuttonSmallDisbaled({required this.onPressed, required this.title});

  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
        ),
        child: MaterialButton(
            disabledColor: CustomColors.ButtonColor.withOpacity(0.6),
            onPressed: null,
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

class SWBorderedButtonWithIcon extends StatelessWidget {
  final Color? color;
  final Function onPressed;
  final String title;
  final Icon icon;
  SWBorderedButtonWithIcon(
      {this.color,
      required this.onPressed,
      required this.icon,
      required this.title});

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
            child: Row(children: [
              icon,
              SizedBox(width: 4),
              Text('$title',
                  style: TextStyle(
                      color: color ?? Color(0xffBD4300),
                      fontSize: 12,
                      fontWeight: FontWeight.w500))
            ])));
  }
}
