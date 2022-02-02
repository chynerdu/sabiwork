import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:sabiwork/common/profileImage.dart';
import 'package:sabiwork/components/inputText.dart';
import 'package:sabiwork/services/getStates.dart';

class MyProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyProfileState();
  }
}

class MyProfileState extends State<MyProfile> {
  bool isEnabled = false;
  Widget build(BuildContext context) {
    Controller c = Get.put(Controller());
    return Obx(() {
      return Scaffold(
          body: Container(
              child: SingleChildScrollView(
                  child: Stack(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(height: MediaQuery.of(context).size.height),
          Container(
              height: 256,
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/profilebg.png'),
                      fit: BoxFit.cover)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(Icons.arrow_back_ios, color: Colors.white)),
                  Text('My Profile',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white)),
                  GestureDetector(
                      child: Text('Edit',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white))),
                ],
              )),
          Positioned(
              top: 97,
              child: Stack(children: [
                Container(
                    // height: 400,
                    padding: EdgeInsets.only(left: 28, right: 28),
                    width: MediaQuery.of(context).size.width,
                    color: Colors.transparent,
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.centerRight,
                            child: SvgPicture.asset(
                                'assets/icons/camera-icon.svg',
                                color: Colors.white)),
                        Container(
                          margin: EdgeInsets.only(
                            top: 65,
                          ),
                          padding: EdgeInsets.only(top: 52),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0xffefefef),
                                  blurRadius: 3.0,
                                  spreadRadius: 1.0)
                            ],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Text(
                                  '${c.userData.value.firstName} ${c.userData.value.lastName}',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  )),
                              SizedBox(height: 5),
                              Text(
                                  '${c.userData.value.lga ?? ''}, ${c.userData.value.state ?? ''}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  )),
                              SizedBox(height: 12),
                              Row(
                                children: [
                                  WidgetCards2(
                                    count: 2,
                                    title: 'Applied',
                                  ),
                                  WidgetCards2(
                                    count: 3,
                                    title: 'Completed',
                                  ),
                                  WidgetCards2(
                                    isLast: true,
                                    count: 0,
                                    title: 'Pending',
                                  )
                                ],
                              ),
                              SizedBox(height: 16)
                            ],
                          ),
                        )
                      ],
                    )),
                Positioned(
                  left: MediaQuery.of(context).size.width * 0.5 - 52.5,
                  child: ProfileImageBig(),
                )
              ])),
          Positioned(
              top: 256,
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).size.height * 0.28,
              width: MediaQuery.of(context).size.width,
              child: Container(
                  padding: EdgeInsets.only(top: 119),
                  color: Colors.transparent,
                  child: Container(
                      child: ListView(
                    children: [
                      UnderlinedInput(
                        enabled: isEnabled,
                        readOnly: !isEnabled,
                        init: '${c.userData.value.firstName}',
                        labelText: 'First Name',
                        validator: (String? value) {
                          if (value == '') return 'First Name cannot be empty';
                        },
                        onSaved: (String? value) {
                          // signinModel.email = value;
                        },
                      ),
                      SizedBox(height: 10),
                      UnderlinedInput(
                        enabled: isEnabled,
                        readOnly: !isEnabled,
                        init: '${c.userData.value.lastName}',
                        labelText: 'Last Name',
                        validator: (String? value) {
                          if (value == '') return 'Last Name cannot be empty';
                        },
                        onSaved: (String? value) {
                          // signinModel.email = value;
                        },
                      ),
                      SizedBox(height: 10),
                      UnderlinedInput(
                        enabled: isEnabled,
                        readOnly: !isEnabled,
                        init: '${c.userData.value.email}',
                        labelText: 'Email',
                        validator: (String? value) {
                          if (value == '') return 'Email cannot be empty';
                        },
                        onSaved: (String? value) {
                          // signinModel.email = value;
                        },
                      ),
                      SizedBox(height: 10),
                      UnderlinedInput(
                        enabled: isEnabled,
                        readOnly: !isEnabled,
                        init: '${c.userData.value.phone}',
                        labelText: 'Phone',
                        validator: (String? value) {
                          if (value == '')
                            return 'Phone number cannot be empty';
                        },
                        onSaved: (String? value) {
                          // signinModel.email = value;
                        },
                      ),
                      SizedBox(height: 10),
                      UnderlinedInput(
                        enabled: isEnabled,
                        readOnly: !isEnabled,
                        init: '${c.userData.value.gender}',
                        labelText: 'Gender',
                        validator: (String? value) {
                          if (value == '') return 'Gender cannot be empty';
                        },
                        onSaved: (String? value) {
                          // signinModel.email = value;
                        },
                      ),
                      SizedBox(height: 10),
                      UnderlinedInput(
                        enabled: isEnabled,
                        readOnly: !isEnabled,
                        init: '1/10/1995',
                        labelText: 'Date of Birth',
                        validator: (String? value) {
                          if (value == '')
                            return 'Date of Birth cannot be empty';
                        },
                        onSaved: (String? value) {
                          // signinModel.email = value;
                        },
                      ),
                      SizedBox(height: 10),
                    ],
                  )))),
        ],
      ))));
    });
  }
}

class WidgetCards2 extends StatelessWidget {
  final int? count;
  bool? isLast;
  final String? title;
  WidgetCards2({this.count, this.title, this.isLast});
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            // height: MediaQuery.of(context).size.width / 4 - 20,
            width: MediaQuery.of(context).size.width / 3 - 25,
            decoration: BoxDecoration(
                border: Border(
                    right: BorderSide(
              color: isLast == true ? Colors.transparent : Color(0xFFD4D4D4),
            ))),
            padding: EdgeInsets.symmetric(horizontal: 13, vertical: 10),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                    fit: BoxFit.cover,
                    child: Text('$title',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Color(0xff979797),
                            fontSize: 14))),
                SizedBox(height: 5),
                FittedBox(
                    fit: BoxFit.cover,
                    child: Text('$count',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0xff000000),
                            fontSize: 20))),
                // Align(
                //     alignment: Alignment.centerRight,
                //     child: SvgPicture.asset('$icon', width: 30, height: 30)),
                // Align(
                //     alignment: Alignment.centerLeft,
                //     child: FittedBox(
                //         fit: BoxFit.cover,
                //         child: Text('$count',
                //             style: TextStyle(
                //                 fontWeight: FontWeight.w500,
                //                 color: Color(0xff000000),
                //                 fontSize: 24)))),
              ],
            )),
      ],
    );
  }
}
