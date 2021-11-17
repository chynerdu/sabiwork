import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:sabiwork/common/drawer.dart';
import 'package:sabiwork/common/profileImage.dart';
import 'package:sabiwork/common/ratingBar.dart';
import 'package:sabiwork/common/shimmerList.dart';
import 'package:sabiwork/common/stacked_image.dart';
import 'package:sabiwork/components/SWbutton.dart';
import 'package:sabiwork/models/allJobsModel.dart';
import 'package:sabiwork/screens/serviceProvider/job-details.dart';
import 'package:sabiwork/services/getStates.dart';
import 'package:sabiwork/services/job_service.dart';

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
  Controller c = Get.put(Controller());
  // bool showHeader = true;
  // toggleShowHeader(status) {
  //   print('status $status');
  //   setState(() {
  //     showHeader = status;
  //   });
  // }

  Widget build(BuildContext context) {
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
                        child: ProfileImage()),
                  ],
                ),
                SizedBox(height: 10),
                Expanded(child: RecommendedJobs(c))
              ],
            )));
    // });
  }
}

class RecommendedJobs extends StatelessWidget {
  final _scrollController = ScrollController();
  final Controller c;

  RecommendedJobs(this.c);
  JobService jobService = JobService();

  Widget build(BuildContext context) {
    // _scrollController.addListener(toggleShowHeader());

    return RefreshIndicator(
        onRefresh: () => jobService.fetchAllJobs(),
        child: Obx(() {
          return
              //  NotificationListener<ScrollNotification>(
              //     onNotification: (scrollNotification) {
              //       if (scrollNotification is ScrollStartNotification) {
              //         print('scroll $scrollNotification');
              //         toggleShowHeader(false);
              //       }
              //       // else if (scrollNotification is ScrollUpdateNotification) {
              //       //   toggleShowHeader(false);
              //       //   print('scroll $scrollNotification');P
              //       // }
              //       else if (scrollNotification is ScrollEndNotification) {
              //         toggleShowHeader(true);
              //         print('scroll $scrollNotification');
              //       }
              //       return true;
              //     },
              //     child:
              SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 18),
                      c.isLoading.value
                          ? ShimmerTexts()
                          : Column(children: [
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
                            ]),
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
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: BorderSide(
                                        width: 0.5, color: Color(0xffAEAEAE)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: BorderSide(
                                        width: 0.5, color: Color(0xffAEAEAE)),
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
                      c.isLoading.value
                          ? ShimmerBox()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                WidgetCards(
                                    color1: Color(0xffB1EEFF),
                                    color2: Color(0xff29BAE2),
                                    title: 'Completed Jobs',
                                    count: '40'),
                                SizedBox(width: 11),
                                WidgetCards(
                                    color1: Color(0xffa1ffe7),
                                    color2: Color(0xff21cca1),
                                    title: 'Active Jobs',
                                    count: '1'),
                                SizedBox(width: 11),
                                WidgetCards(
                                    color1: Color(0xffebb78d),
                                    color2: Color(0xfff08024),
                                    title: 'Pending Jobs',
                                    count: '3'),
                              ],
                            ),
                      SizedBox(height: 37),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Recommended for you',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff333333),
                                    fontSize: 20)),
                            GestureDetector(
                                onTap: () => c.updateTab(1),
                                child: Text('View All',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff983701),
                                        fontSize: 14)))
                          ]),
                      SizedBox(height: 16),
                      c.isFetchingJobs.value
                          ? ShimmerList()
                          : Column(
                              children: c.allJobs.value.data!
                                  .map((Data e) => JobCard(job: e))
                                  .toList())

                      // SizedBox(height: 20),
                      // JobCard(),
                      // SizedBox(height: 20),
                      // JobCard()
                    ],
                  ));
          // );
        }));
  }
}

class JobCard extends StatelessWidget {
  NumberFormat _format = NumberFormat('#,###,###,###.##', 'en_US');
  Data job;
  JobCard({required this.job});
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (_) => JobDetailsState)))
          Get.to(JobDetails(job: job));
        },
        child: Container(
            margin: EdgeInsets.only(bottom: 16),
            padding: EdgeInsets.fromLTRB(14, 0, 14, 14),
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Color(0xffefefef), blurRadius: 10.0, spreadRadius: 3.0)
            ], borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SabiBadges(
                        title: '${job.numberOfWorkers} Person(s)',
                        color: Color(0xffe6e6e6)),
                    SabiBadges(
                        title: '${job.jobType}', color: Color(0xfff8dfdb))
                  ],
                ),
                SizedBox(height: 9),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Text('${job.description}',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                              color: Color(0xff983701),
                            ))),
                    Text('₦${_format.format(job.pricePerWorker)}',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w800,
                        )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.location_pin, size: 10),
                    Text(
                        '${job.user!.lga ?? 'Not specified'}, ${job.user!.state ?? ''}',
                        style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.w500,
                        ))
                  ],
                ),
                SizedBox(height: 10),
                Text('${job.additionalDetails}',
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
                          StackedImage(count: job.applicantCount),
                          SizedBox(width: 10),
                          Text('${job.applicantCount} applicant(s)',
                              style: TextStyle(
                                fontSize: 8,
                                fontWeight: FontWeight.w500,
                              )),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.access_time, size: 8),
                          SizedBox(width: 3),
                          Text(
                              '${Jiffy(job.createdAt).startOf(Units.DAY).fromNow()}',
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
  final Color? color1;
  final Color? color2;
  final String? title;
  WidgetCards({this.count, this.color1, this.color2, this.title});
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width / 3 - 25,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [color1 as Color, color2 as Color])),
        padding: EdgeInsets.symmetric(horizontal: 13, vertical: 8),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FittedBox(
                fit: BoxFit.cover,
                child: Text('$count',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color(0xffffffff),
                        fontSize: 24))),
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

            FittedBox(
                fit: BoxFit.cover,
                child: Text('$title',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Color(0xffffffff),
                        fontSize: 14))),
          ],
        ));
  }
}
