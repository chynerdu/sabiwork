import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sabiwork/components/SWbutton.dart';

class CustomDialogs {
  successDialog({
    required title,
    required context,
    required content,
    required animation,
    required Function action,
    required actionText,
  }) {
    Get.dialog(
      // title: "",
      // titleStyle: TextStyle(height: 0, fontSize: 1),
      BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
          child: new AlertDialog(

              // title: new Text(
              //   'Add a Message to your application (Optional)',
              //   style: TextStyle(color: CustomColors.PrimaryColor),
              // ),
              content: Container(
                  height: 400,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  // height: 500,
                  child: Column(children: [
                    Container(
                        child: Column(
                      children: [
                        SizedBox(height: 10),
                        Lottie.asset(
                          '$animation',
                          width: 125,
                          height: 125,
                          fit: BoxFit.fill,
                        ),
                        SizedBox(height: 20),
                        Text('$title',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Color(0xff333333),
                                fontSize: 20)),
                        SizedBox(height: 10),
                        Text('$content',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Color(0xff888888),
                                fontSize: 18)),
                        SizedBox(height: 20),
                      ],
                    )),
                    SizedBox(
                      height: 35,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: SWbutton(
                        title: '$actionText',
                        onPressed: () {
                          action();
                          // approve(context);
                        },
                      ),
                    )
                  ])))),
      barrierDismissible: false,
    );
  }
}
