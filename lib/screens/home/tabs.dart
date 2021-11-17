import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sabiwork/helpers/customColors.dart';
import 'package:sabiwork/screens/serviceProvider/dashboard_serviceprod.dart';
import 'package:sabiwork/screens/serviceProvider/jobs.dart';
import 'package:sabiwork/services/getStates.dart';
import 'package:sabiwork/services/job_service.dart';

class Tabs extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TabsState();
  }
}

class TabsState extends State<Tabs> {
  JobService jobService = JobService();
  // int _selectedIndex = 0;
  // VisitService visitService = VisitService();

  void onItemTap(int index) {
    Controller c = Get.put(Controller());
    setState(() {
      // _selectedIndex = index;
      c.updateTab(index);
    });
  }

  void initState() {
    // Controller c = Get.put(Controller());
    // _selectedIndex = c.activeTab.value;
    // fetchVisitHistory();
    // fetchVisitRequests();
    jobService.fetchAllJobs();
    super.initState();
  }

  // fetchVisitRequests() async {
  //   try {
  //     await visitService.fetchVisitRequest(acceptStatus: 'PENDING');
  //   } catch (e) {}
  // }

  Future<bool> _onWillPop() async {
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
                'Exit App',
                style: TextStyle(color: CustomColors.PrimaryColor),
              ),
              content: new Text(
                'Do you want to exit SabiWork?',
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
                  onPressed: () {
                    SystemNavigator.pop();
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

  List<Widget> _widgetOptions = <Widget>[
    ServiceProviderMain(),
    JobMain(),
    Container(child: Center(child: Text('Chat Coming soon'))),
    Container(child: Center(child: Text('Notification Coming soon'))),
    Container(child: Center(child: Text('Money Coming soon'))),
    // Container(child: Center(child: Text('Community Coming soon'))),
    // ResidentServiceScreen()
  ];

  Widget build(BuildContext context) {
    Controller c = Get.put(Controller());
    return Obx(() => WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          body: AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle.dark,
              child:
                  SafeArea(child: _widgetOptions.elementAt(c.activeTab.value))),
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/icons/home.svg'),
                activeIcon: SvgPicture.asset('assets/icons/home.svg',
                    color: Color(0xff983701)),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/icons/jobs.svg'),
                activeIcon: SvgPicture.asset('assets/icons/jobs.svg',
                    color: Color(0xff983701)),
                label: 'Jobs',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/icons/chat.svg'),
                activeIcon: SvgPicture.asset('assets/icons/chat.svg',
                    color: Color(0xff983701)),
                label: 'Chat',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/icons/notifications.svg'),
                activeIcon: SvgPicture.asset('assets/icons/notifications.svg',
                    color: Color(0xff983701)),
                label: 'Notifications',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/icons/money.svg'),
                activeIcon: SvgPicture.asset('assets/icons/money.svg',
                    color: Color(0xff983701)),
                label: 'Money',
              ),
            ],
            // currentIndex: _selectedIndex,
            currentIndex: c.activeTab.value,

            backgroundColor: Colors.white,
            iconSize: 18,
            onTap: onItemTap,
            selectedFontSize: 9.0,
            unselectedFontSize: 9.0,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Color(0xFF661C66),
            unselectedItemColor: Color(0xFFADAFB2),
            unselectedLabelStyle: TextStyle(
              color: Color(0xFFADAFB2),
            ),
          ),
        )));
  }
}
