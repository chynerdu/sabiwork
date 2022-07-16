import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:sabiwork/common/drawer.dart';
import 'package:sabiwork/common/profileImage.dart';
import 'package:sabiwork/common/ratingBar.dart';
import 'package:sabiwork/common/shimmerList.dart';
import 'package:sabiwork/common/stacked_image.dart';
import 'package:sabiwork/components/SWbutton.dart';
import 'package:sabiwork/components/sabiBadges.dart';
import 'package:sabiwork/helpers/customColors.dart';
import 'package:sabiwork/helpers/flushBar.dart';
import 'package:sabiwork/models/allJobsModel.dart';
import 'package:sabiwork/models/myJobsModel.dart';
import 'package:sabiwork/screens/client/add-job.dart';
import 'package:sabiwork/screens/client/client-job-details.dart';

import 'package:sabiwork/services/getStates.dart';
import 'package:sabiwork/services/job_service.dart';

class ClientJobMain extends StatelessWidget {
  Widget build(BuildContext context) {
    return ZoomDrawer(
      // controller: ZoomDrawerController,
      style: DrawerStyle.DefaultStyle,
      menuScreen: SabiDrawer(),
      mainScreen: ClientJobScreen(),
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

class ClientJobScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ClientJobScreenState();
  }
}

class ClientJobScreenState extends State<ClientJobScreen> {
  int tabIndex = 0;
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  Controller c = Get.put(Controller());
  JobService jobService = JobService();

  initstate() {
    super.initState();
    jobService.fetchMyJobs();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        // floatingActionButton: FloatingActionButton.extended(
        //   backgroundColor: CustomColors.PrimaryColor,
        //   onPressed: () {
        //     Get.to(AddJob());
        //   },
        //   icon: Icon(Icons.add),
        //   label: Text('New Job'),
        // ),

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
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      // onTap: () => ZoomDrawer.of(context)!.open(),
                      child: ProfileImage(),
                    ),
                    Text('My Jobs',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Color(0xff555555),
                            fontSize: 18)),
                    GestureDetector(child: Icon(Icons.more_vert))
                  ],
                ),
                Expanded(
                  // padding: const EdgeInsets.all(20.0),
                  child: DefaultTabController(
                    length: 3,
                    child: Column(
                      children: <Widget>[
                        Container(
                          constraints: BoxConstraints(maxHeight: 150.0),
                          child: Material(
                            color: Colors.transparent,
                            child: Container(
                              // color: Colors.white,
                              child: TabBar(
                                indicatorColor: Color(0xff983701),
                                labelPadding: EdgeInsets.zero,
                                indicatorPadding: EdgeInsets.zero,
                                onTap: (int data) {
                                  setState(() {
                                    tabIndex = data;
                                  });
                                },
                                tabs: [
                                  Tab(
                                    child: Container(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "All",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: tabIndex == 0
                                                  ? Color(0xff983701)
                                                  : Color(0xff555555),
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Tab(
                                    child: Container(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Open",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: tabIndex == 1
                                                  ? Color(0xff983701)
                                                  : Color(0xff555555),
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Tab(
                                    child: Container(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Closed",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: tabIndex == 2
                                                  ? Color(0xff983701)
                                                  : Color(0xff555555),
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            physics: NeverScrollableScrollPhysics(),
                            children: [AllJobs(c), OpenJobs(c), ClosedJobs(c)],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )));
  }
}

class AllJobs extends StatelessWidget {
  final _scrollController = ScrollController();
  final Controller c;
  JobService jobService = JobService();
  AllJobs(this.c);
  Widget build(BuildContext context) {
    return RefreshIndicator(onRefresh: () async {
      print('refreshing');
      jobService.fetchMyJobs();
      jobService.fetchMyOpenJobs();
      jobService.fetchMyClosedJobs();
    }, child: Obx(() {
      // print('my jobs ${c.myJobs.value.data!.length}');
      return SingleChildScrollView(
          controller: _scrollController,
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
                          labelText: 'Search'))),
              SizedBox(height: 37),
              c.isFetchingJobs.value && c.myJobs.value.data == null
                  ? ShimmerList()
                  : Column(
                      children: c.myJobs.value.data != null
                          ? c.myJobs.value.data!
                              .map((MyJobData e) => JobCard(job: e))
                              .toList()
                          : [Container()])
            ],
          ));
    }));
  }
}

class OpenJobs extends StatelessWidget {
  final _scrollController = ScrollController();
  final Controller c;
  OpenJobs(this.c);
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
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide:
                          BorderSide(width: 0.5, color: Color(0xffAEAEAE)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide:
                          BorderSide(width: 0.5, color: Color(0xffAEAEAE)),
                    ),
                    prefixIcon: Icon(Icons.search),
                    labelText: 'Search'))),
        SizedBox(height: 37),
        c.isFetchingJobs.value && c.myOpenJobs.value.data == null
            ? ShimmerList()
            : c.myOpenJobs.value.data == null
                ? Center(child: Text('You have no open jobs'))
                : Column(
                    children: c.myOpenJobs.value.data!
                        .map((MyJobData e) => JobCard(job: e))
                        .toList())
      ],
    ));
  }
}

class ClosedJobs extends StatelessWidget {
  final _scrollController = ScrollController();
  final Controller c;
  ClosedJobs(this.c);
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
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide:
                          BorderSide(width: 0.5, color: Color(0xffAEAEAE)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide:
                          BorderSide(width: 0.5, color: Color(0xffAEAEAE)),
                    ),
                    prefixIcon: Icon(Icons.search),
                    labelText: 'Search'))),
        SizedBox(height: 37),
        c.isFetchingJobs.value && c.myClosedJobs.value.data == null
            ? ShimmerList()
            : c.myClosedJobs.value.data == null
                ? Center(child: Text('You have not closed any jobs'))
                : Column(
                    children: c.myClosedJobs.value.data!
                        .map((MyJobData e) => JobCard(job: e))
                        .toList())
      ],
    ));
  }
}

class JobCard extends StatelessWidget {
  NumberFormat _format = NumberFormat('#,###,###,###.##', 'en_US');
  final JobService jobService = JobService();
  final CustomFlushBar customFlushBar = CustomFlushBar();
  MyJobData job;
  JobCard({required this.job});

  submit(context, status) async {
    try {
      var payload = {"jobStatus": status};

      final result = await jobService.updateMyJob(job.sId, payload);
      print('result $result');

      // Navigator.pop(context);
      status == "Closed"
          ? customFlushBar.showSuccessFlushBar(
              title: 'Job has been closed',
              body: 'You have closed this job',
              context: context)
          : status == "Suspended"
              ? customFlushBar.showSuccessFlushBar(
                  title: 'Job has been suspended',
                  body: 'You have suspended this job',
                  context: context)
              : customFlushBar.showSuccessFlushBar(
                  title: 'Job has been re-opened',
                  body: 'You have re-opened this job',
                  context: context);

      // Future.delayed(
      //     const Duration(milliseconds: 500), () => Navigator.pop(context));
    } catch (e) {
      // show flushbar
      customFlushBar.showErrorFlushBar(
          title: 'Error occured', body: '$e', context: context);
    }
  }

  Widget build(BuildContext context) {
    return FocusedMenuHolder(
        menuWidth: MediaQuery.of(context).size.width * 0.50,
        blurSize: 1.0,
        menuItemExtent: 45,
        menuBoxDecoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        duration: Duration(milliseconds: 100),
        animateMenuItems: true,
        blurBackgroundColor: Colors.black54,
        openWithTap: false, // Open Focused-Menu on Tap rather than Long Press
        menuOffset:
            10.0, // Offset value to show menuItem from the selected item
        bottomOffsetHeight:
            80.0, // Offset height to consider, for showing the menu item ( for example bottom navigation bar), so that the popup menu will be shown on top of selected item.
        menuItems: <FocusedMenuItem>[
          // Add Each FocusedMenuItem  for Menu Options
          FocusedMenuItem(
              title: Text("View job"),
              trailingIcon: Icon(Icons.open_in_new),
              onPressed: () {
                Get.to(ClientJobDetails(job: job));
              }),
          // FocusedMenuItem(
          //     title: Text("Share"),
          //     trailingIcon: Icon(Icons.share),
          //     onPressed: () {}),
          FocusedMenuItem(
              title: Text(
                job.jobStatus == "Open" ? 'Close' : 'Re-open Job',
              ),
              trailingIcon: Icon(Icons.settings),
              onPressed: () {
                submit(context, job.jobStatus == "Open" ? 'Closed' : 'Open');
              }),
          if (job.jobStatus != 'Suspended')
            FocusedMenuItem(
                title: Text(
                  "Suspend Job",
                  style: TextStyle(color: Colors.redAccent),
                ),
                trailingIcon:
                    Icon(Icons.pause, color: Color.fromARGB(255, 207, 132, 11)),
                onPressed: () {
                  submit(context, 'Suspended');
                }),
        ],
        onPressed: () {
          Get.to(ClientJobDetails(job: job));
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
                        title: '${job.numberOfWorkers} Persons',
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: job.jobStatus == 'Open'
                                  ? Color(0xff209B25)
                                  : job.jobStatus == 'Suspended'
                                      ? Color.fromARGB(255, 207, 132, 11)
                                      : Color.fromARGB(255, 201, 20, 20),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text('${job.jobStatus}',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                  letterSpacing: .5,
                                  fontWeight: FontWeight.w500,
                                ))),
                        SizedBox(height: 4),
                        Text('₦${_format.format(job.pricePerWorker)}',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w800,
                            )),
                      ],
                    )
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
                          Text(' ${job.applicantCount} applicants',
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
