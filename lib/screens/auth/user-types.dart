import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sabiwork/common/route_constants.dart';
import 'package:sabiwork/components/SWbutton.dart';

class UserTypes extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 36),
            child: Column(children: [
              SizedBox(height: 50),
              Container(
                  width: 300,
                  height: 300,
                  child: SvgPicture.asset('assets/icons/users.svg')),
              SizedBox(height: 22),
              Text('How do you want to use SabiWork?',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
              SizedBox(height: 36),
              SWBorderedButtonBig(
                  onPressed: () {
                    Navigator.pushNamed(context, RegisterRoute,
                        arguments: {'userType': 'client'});
                  },
                  title: 'I want to post jobs'),
              SizedBox(height: 43),
              SWBorderedButtonBig(
                  onPressed: () {
                    Navigator.pushNamed(context, RegisterRoute,
                        arguments: {'userType': 'service-provider'});
                  },
                  title: 'I want to look for jobs')
            ])));
  }
}
