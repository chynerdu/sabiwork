import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:sabiwork/common/drawer.dart';
import 'package:sabiwork/helpers/appTourTargets.dart';
import 'package:sabiwork/helpers/customColors.dart';
import 'package:sabiwork/screens/chat/chat-list.dart';
import 'package:sabiwork/screens/chat/chat-room.dart';
import 'package:sabiwork/screens/client/add-job.dart';
import 'package:sabiwork/screens/client/client-dashboard.dart';
import 'package:sabiwork/screens/client/client-jobs.dart';

import 'package:sabiwork/screens/serviceProvider/dashboard_serviceprod.dart';
import 'package:sabiwork/screens/serviceProvider/jobs.dart';
import 'package:sabiwork/services/getStates.dart';
import 'package:sabiwork/services/job_service.dart';
import 'package:sabiwork/services/localStorage.dart';
import 'package:sabiwork/services/messages_service.dart';

class Tabs extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
        body: ZoomDrawer(
      // controller: ZoomDrawerController,
      style: DrawerStyle.DefaultStyle,
      menuScreen: SabiDrawer(),
      mainScreen: TabsMain(),
      borderRadius: 24.0,
      showShadow: true,
      angle: -12.0,
      backgroundColor: Colors.blue,
      slideWidth: MediaQuery.of(context).size.width * .45,
      openCurve: Curves.fastOutSlowIn,
      closeCurve: Curves.bounceIn,
    ));
  }
}

class TabsMain extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TabsState();
  }
}

class TabsState extends State<TabsMain> with AutomaticKeepAliveClientMixin {
  JobService jobService = JobService();
  MessageService messageService = MessageService();

  AppTourTargets appTourTargets = AppTourTargets();
  LocalStorage localStorage = LocalStorage();
  GlobalKey myJobsKey = GlobalKey();
  GlobalKey walletKey = GlobalKey();

  void onItemTap(int index) {
    Controller c = Get.put(Controller());
    setState(() {
      // _selectedIndex = index;
      c.updateTab(index);
    });
  }

  @override
  bool get wantKeepAlive => true;

  void initState() {
    Controller c = Get.put(Controller());
    // _selectedIndex = c.activeTab.value;
    // fetchVisitHistory();
    // fetchVisitRequests();
    if (c.userData.value.role == "service-provider") {
      jobService.fetchAllJobs();
      jobService.fetchAppliedJobs();
      jobService.fetchApprovedJobs();
    } else {
      jobService.fetchMyOpenJobs();
      jobService.fetchMyJobs();
      jobService.fetchActiveApplicants();
    }

    messageService.fetchRecentChats();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      appTourTargets.addTargets(
        context: context,
        myJobsKey: myJobsKey,
        // copyKeyTourKey: copyKeyTourKey,
        walletKey: walletKey,
        // shareKeyTourKey: shareKeyTourKey
      );
    });
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
    ServiceProviderDashboard(),
    JobMain(),
    ChatList(),
    // Container(child: Center(child: Text('Notification Coming soon'))),
    Container(child: Center(child: Text('Money Coming soon'))),
    // Container(child: Center(child: Text('Community Coming soon'))),
    // ResidentServiceScreen()
  ];

  List<Widget> _clientWidgetOptions = <Widget>[
    ClientDashboard(),
    ClientJobMain(),
    AddJob(),
    ChatList(),
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
              child: SafeArea(
                  child: c.userData.value.role == "service-provider"
                      ? _widgetOptions.elementAt(c.activeTab.value)
                      : _clientWidgetOptions.elementAt(c.activeTab.value))),
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/icons/home.svg'),
                activeIcon: SvgPicture.asset('assets/icons/home.svg',
                    color: Color(0xff983701)),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/jobs.svg',
                  key: myJobsKey,
                ),
                activeIcon: SvgPicture.asset('assets/icons/jobs.svg',
                    color: Color(0xff983701)),
                label: 'Jobs',
              ),
              if (c.userData.value.role != "service-provider")
                BottomNavigationBarItem(
                  icon: Container(
                      decoration: BoxDecoration(
                          color: Color(0xff8D8D8D),
                          borderRadius: BorderRadius.circular(2)),
                      child: Icon(
                        Icons.add_outlined,
                        color: Colors.white,
                      )),
                  // SvgPicture.asset('assets/icons/chat.svg'),
                  activeIcon: Container(
                      decoration: BoxDecoration(
                          color: Color(0xff983701),
                          borderRadius: BorderRadius.circular(2)),
                      child: Icon(Icons.add, color: Colors.white)),
                  //  SvgPicture.asset('assets/icons/notifications.svg',
                  //     color: Color(0xff983701)),
                  label: 'New',
                ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/icons/chat.svg'),
                activeIcon: SvgPicture.asset('assets/icons/chat.svg',
                    color: Color(0xff983701)),
                label: 'Messages',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icons/money.svg',
                  key: walletKey,
                ),
                activeIcon: SvgPicture.asset('assets/icons/money.svg',
                    color: Color(0xff983701)),
                label: c.userData.value.role != "service-provider"
                    ? 'Wallet'
                    : 'Earnings',
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
