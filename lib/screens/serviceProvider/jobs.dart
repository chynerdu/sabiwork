import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:sabiwork/common/drawer.dart';
import 'package:sabiwork/common/profileImage.dart';
import 'package:sabiwork/common/ratingBar.dart';
import 'package:sabiwork/common/route_constants.dart';
import 'package:sabiwork/common/shimmerList.dart';
import 'package:sabiwork/common/stacked_image.dart';
import 'package:sabiwork/components/SWbutton.dart';
import 'package:sabiwork/models/allJobsModel.dart';
import 'package:sabiwork/screens/serviceProvider/job-details.dart';
import 'package:sabiwork/services/getStates.dart';

class JobMain extends StatelessWidget {
  Widget build(BuildContext context) {
    return ZoomDrawer(
      // controller: ZoomDrawerController,
      style: DrawerStyle.DefaultStyle,
      menuScreen: SabiDrawer(),
      mainScreen: JobScreen(),
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

class JobScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return JobScreenState();
  }
}

class JobScreenState extends State<JobScreen> {
  int tabIndex = 0;
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  Controller c = Get.put(Controller());
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
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => Navigator.pushNamed(context, MyProfileRoute),
                      child: ProfileImage(),
                      //      Container(
                      //   // radius: 50,

                      //   width: 30,
                      //   height: 30,
                      //   decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(30),
                      //       image: DecorationImage(
                      //         fit: BoxFit.cover,
                      //         image: AssetImage('assets/images/danKid.jpg'),
                      //       )),
                      // )
                    ),
                    Text('Jobs',
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
                    length: 2,
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
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Tab(
                                    child: Container(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Applied",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: tabIndex == 1
                                                  ? Color(0xff983701)
                                                  : Color(0xff555555),
                                              fontWeight: FontWeight.w400),
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
                            children: [AllJobs(c), AppliedJobs(c)],
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
  AllJobs(this.c);
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
        c.isFetchingJobs.value
            ? ShimmerList()
            : Column(
                children: c.allJobs.value.data!
                    .map((Data e) => JobCard(job: e))
                    .toList())
      ],
    ));
  }
}

class AppliedJobs extends StatelessWidget {
  final _scrollController = ScrollController();
  final Controller c;
  AppliedJobs(this.c);
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
        c.isFetchingMyJobs.value
            ? ShimmerList()
            : Column(
                children: c.myAppliedJobs.value.result!.data!
                    .map((dynamic e) => JobCard(job: e.job))
                    .toList())
      ],
    ));
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
            padding: EdgeInsets.fromLTRB(0, 0, 14, 14),
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
                  children: [
                    // image
                    if (job.jobImages!.length > 0)
                      Container(
                          margin: EdgeInsets.only(top: 7),
                          width: 40,
                          height: 40,
                          child: CachedNetworkImage(
                            imageUrl: job.jobImages!.length > 0
                                ? '${job.jobImages![0]}'
                                : 'https://via.placeholder.com/150.png?text=No+image+available',
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    height: 115,
                                    child: Center(
                                        child: SizedBox(
                                            width: 10,
                                            height: 10,
                                            child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                value: downloadProgress
                                                    .progress)))),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          )),
                    SizedBox(width: 14),
                    Expanded(
                        child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.6 -
                                          40,
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
                                  '${job.lga ?? 'Not specified'}, ${job.state ?? ''}',
                                  style: TextStyle(
                                    fontSize: 8,
                                    fontWeight: FontWeight.w500,
                                  ))
                            ],
                          ),
                          SizedBox(height: 10),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: Text('${job.additionalDetails}',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Color(0xff888888),
                                    fontWeight: FontWeight.w500,
                                  ))),
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
                      ),
                    ))
                  ],
                ),
              ],
            )));
  }
}
