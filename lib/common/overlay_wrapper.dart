import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sabiwork/helpers/customColors.dart';

class OverLayWrapper extends StatelessWidget {
  Widget child;
  OverLayWrapper({required this.child});
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: CustomColors.PrimaryColor,
          statusBarBrightness: Brightness.light,
        ),
        child: child);
  }
}
