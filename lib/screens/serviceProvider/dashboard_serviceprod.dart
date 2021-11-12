import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:sabiwork/common/drawer.dart';
import 'package:sabiwork/common/ratingBar.dart';
import 'package:sabiwork/common/stacked_image.dart';
import 'package:sabiwork/components/SWbutton.dart';
import 'package:sabiwork/screens/serviceProvider/job-details.dart';
import 'package:sabiwork/services/getStates.dart';

class ServiceProviderMain extends StatelessWidget {
  Widget build(BuildContext context) {
    return ZoomDrawer(
      // controller: ZoomDrawerController,
      style: DrawerStyle.DefaultStyle,
      menuScreen: SabiDrawer(),
      mainScreen: ServiceProviderDashboard(),
      borderRadius: 24.0,
      showShadow: true,
      angle: -12.0,
      backgroundColor: Colors.blue,
      slideWidth: MediaQuery.of(context).size.width * .45,
      openCurve: Curves.fastOutSlowIn,
      closeCurve: Curves.bounceIn,
    );
  }
}

class ServiceProviderDashboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ServiceProviderDashboardState();
  }
}

class ServiceProviderDashboardState extends State<ServiceProviderDashboard> {
  int tabIndex = 0;
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  Widget build(BuildContext context) {
    Controller c = Get.put(Controller());
    return Obx(() {
      return Scaffold(
          // appBar: AppBar(
          //   leading: Container(
          //     // radius: 50,
          //     margin: EdgeInsets.only(left: 10),
          //     width: 20,
          //     height: 20,
          //     decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(30),
          //         image: DecorationImage(
          //           fit: BoxFit.cover,
          //           image: AssetImage('assets/images/danKid.jpg'),
          //         )),
          //   ),
          //   title: Text('Jobs',
          //       style: TextStyle(color: Color(0xff555555), fontSize: 18)),
          //   backgroundColor: Colors.transparent,
          //   elevation: 0,
          //   centerTitle: true,
          //   iconTheme: IconThemeData(color: Color(0xff888888)),
          //   actions: [GestureDetector(child: Icon(Icons.more_vert))],
          // ),
          body: Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: () => ZoomDrawer.of(context)!.open(),
                          child: SvgPicture.asset('assets/icons/menu.svg')),
                      InkWell(
                          // onTap: () => ZoomDrawer.of(context)!.open(),
                          child: Container(
                        // radius: 50,

                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/images/danKid.jpg'),
                            )),
                      )),
                    ],
                  ),
                  SizedBox(height: 28),
                  Text('Hi ${c.userData.value.firstName} ',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color(0xff000000),
                          fontSize: 20)),
                  Text('You have no active job',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Color(0xff8D8D8D),
                          fontSize: 14)),
                  Expanded(child: RecommendedJobs())
                ],
              )));
    });
  }
}

class RecommendedJobs extends StatelessWidget {
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 34,
        ),
        SizedBox(
            height: 40,
            width: MediaQuery.of(context).size.width * 0.75,
            child: TextFormField(
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide:
                          BorderSide(width: 0.5, color: Color(0xffAEAEAE)),
                    ),
                    prefixIcon: Icon(Icons.search),
                    label: Text('Search')))),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Stats',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Color(0xff000000),
                    fontSize: 20)),
            Container(
                width: MediaQuery.of(context).size.width * 0.4,
                child: Row(
                  children: [
                    Text('All time',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Color(0xff000000),
                            fontSize: 10)),
                    SizedBox(width: 5),
                    Text('This month',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Color(0xffb3b3b3),
                            fontSize: 10)),
                    SizedBox(width: 5),
                    Text('Last 7 days',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Color(0xffb3b3b3),
                            fontSize: 10))
                  ],
                ))
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            WidgetCards(
                icon: 'assets/icons/completed_jobs.svg',
                title: 'Completed Jobs',
                count: '40'),
            SizedBox(width: 11),
            WidgetCards(
                icon: 'assets/icons/applied_jobs.svg',
                title: 'Active Jobs',
                count: '1'),
            SizedBox(width: 11),
            WidgetCards(
                icon: 'assets/icons/pending_jobs.svg',
                title: 'Pending Jobs',
                count: '3'),
          ],
        ),
        SizedBox(height: 10),
        JobCard(),
        SizedBox(height: 20),
        JobCard(),
        SizedBox(height: 20),
        JobCard()
      ],
    ));
  }
}

class JobCard extends StatelessWidget {
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (_) => JobDetailsState)))
          Get.to(JobDetails());
        },
        child: Container(
            padding: EdgeInsets.fromLTRB(14, 0, 14, 14),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: Column(
              children: [
                Row(
                  children: [
                    SabiBadges(title: '3 Persons', color: Color(0xffe6e6e6)),
                    SabiBadges(
                        title: 'Male and Female', color: Color(0xfff8dfdb))
                  ],
                ),
                SizedBox(height: 9),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Text('I need someone to clean the house',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                              color: Color(0xff983701),
                            ))),
                    Text('N5,000',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.location_pin, size: 10),
                    Text('Mushin, Lagos',
                        style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.w500,
                        ))
                  ],
                ),
                SizedBox(height: 10),
                Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Non varius.',
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xff888888),
                      fontWeight: FontWeight.w500,
                    )),
                SizedBox(height: 20),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //  left
                      Row(
                        children: [
                          StackedImage(),
                          SizedBox(width: 10),
                          Text(' 10 applicants',
                              style: TextStyle(
                                fontSize: 8,
                                fontWeight: FontWeight.w500,
                              )),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.timer, size: 10),
                          Text('30 mins ago',
                              style: TextStyle(
                                fontSize: 8,
                                fontWeight: FontWeight.w500,
                              ))
                        ],
                      ),
                    ])
              ],
            )));
  }
}

class WidgetCards extends StatelessWidget {
  final String? count;
  final String? icon;
  final String? title;
  WidgetCards({this.count, this.icon, this.title});
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width / 3 - 25,
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 13, vertical: 8),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
                alignment: Alignment.centerRight,
                child: SvgPicture.asset('$icon', width: 30, height: 30)),
            Align(
                alignment: Alignment.centerLeft,
                child: FittedBox(
                    fit: BoxFit.cover,
                    child: Text('$count',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Color(0xff000000),
                            fontSize: 24)))),
            SizedBox(height: 10),
            FittedBox(
                fit: BoxFit.cover,
                child: Text('$title',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Color(0xff000000),
                        fontSize: 14))),
          ],
        ));
  }
}
