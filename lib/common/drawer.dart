import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:sabiwork/common/profileImage.dart';
import 'package:sabiwork/common/route_constants.dart';
import 'package:sabiwork/components/SWbutton.dart';
import 'package:sabiwork/helpers/customColors.dart';
import 'package:sabiwork/services/getStates.dart';
import 'package:sabiwork/services/http_instance.dart';

class SabiDrawer extends StatelessWidget {
  Widget build(BuildContext context) {
    Future<bool> _onWillPop(c) async {
      // if (_selectedIndex != 0) {
      //   setState(() {
      //     _selectedIndex = 0;
      //   });
      //   return false;
      // }
      return (await showDialog(
            context: context,
            builder: (context) => BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
              child: new AlertDialog(
                title: new Text(
                  'Logout',
                  style: TextStyle(color: CustomColors.PrimaryColor),
                ),
                content: new Text(
                  'Do you want to logout?',
                  style: TextStyle(color: CustomColors.AshText),
                ),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(15)),
                actions: <Widget>[
                  FlatButton(
                    child: new Text(
                      'Yes',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () async {
                      Get.put(Controller());
                      await localStorage.clearAll();
                      // Get.reset();
                      c.resetUserData();
                      Navigator.pushNamedAndRemoveUntil(
                          context, LoginRoute, (route) => false);
                    },
                  ),
                  FlatButton(
                    child: new Text(
                      'No',
                      style: TextStyle(color: CustomColors.PrimaryColor),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                ],
              ),
            ),
          )) ??
          false;
    }

    Controller c = Get.put(Controller());
    return Obx(() {
      return Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          decoration: BoxDecoration(color: Color(0xffBD4300)),
          child: Column(
            children: [
              ListTile(
                contentPadding: EdgeInsets.only(left: 0),
                leading: ProfileImageSAvatar(),
                title: Text(
                    '${c.userData.value.firstName} ${c.userData.value.lastName}',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 13)),
                // subtitle: Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     Text('23 hires',
                //         style: TextStyle(color: Colors.white, fontSize: 10)),
                //   ],
                // ),
              ),
              Divider(),
              SingleChildScrollView(
                  child: Stack(
                      // mainAxisSize: MainAxisSize.max,
                      // mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                    Container(
                        padding: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width * 0.4),
                        height: MediaQuery.of(context).size.height * 0.6,
                        child:
                            Column(mainAxisSize: MainAxisSize.max, children: [
                          SizedBox(height: 20),
                          ListTile(
                              leading: Icon(Icons.person, color: Colors.white),
                              title: Text('Profile',
                                  style: TextStyle(color: Colors.white))),
                          GestureDetector(
                              onTap: () {
                                Controller c = Get.put(Controller());
                                c.updateTab(1);
                              },
                              child: ListTile(
                                  leading: SvgPicture.asset(
                                      'assets/icons/jobs.svg',
                                      color: Colors.white),
                                  title: Text('My Jobs',
                                      style: TextStyle(color: Colors.white)))),
                          Divider(color: Colors.white),
                          ListTile(
                              leading: SvgPicture.asset(
                                  'assets/icons/settings.svg',
                                  color: Colors.white),
                              title: Text('Settings',
                                  style: TextStyle(color: Colors.white))),
                          Divider(color: Colors.white),
                          ListTile(
                              leading: SvgPicture.asset('assets/icons/help.svg',
                                  color: Colors.white),
                              title: Text('Help',
                                  style: TextStyle(color: Colors.white))),
                          ListTile(
                              leading: SvgPicture.asset(
                                  'assets/icons/support.svg',
                                  color: Colors.white),
                              title: Text('Support',
                                  style: TextStyle(color: Colors.white))),
                        ])),
                    Positioned(
                        bottom: 10,
                        left: MediaQuery.of(context).size.width * 0.1,
                        child: Align(
                            alignment: Alignment.center,
                            child: SizedBox(
                              height: 34,
                              width: MediaQuery.of(context).size.width * 0.28,
                              child: SWBorderedButton(
                                color: Colors.white,
                                title: 'Logout',
                                onPressed: () {
                                  _onWillPop(c);
                                },
                              ),
                            )))
                  ]))
            ],
          ));
    });
  }
}
