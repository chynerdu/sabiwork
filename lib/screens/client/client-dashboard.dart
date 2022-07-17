import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:lottie/lottie.dart';
import 'package:photo_view/photo_view.dart';
import 'package:sabiwork/common/profileImage.dart';
import 'package:sabiwork/common/route_constants.dart';
import 'package:sabiwork/common/shimmerList.dart';
import 'package:sabiwork/common/stacked_image.dart';
import 'package:sabiwork/components/SWbutton.dart';
import 'package:sabiwork/components/sabiBadges.dart';
import 'package:sabiwork/helpers/dialogs.dart';
import 'package:sabiwork/helpers/flushBar.dart';
import 'package:sabiwork/models/allJobsModel.dart';
import 'package:sabiwork/models/myJobsModel.dart' as myJob;
import 'package:sabiwork/models/approvedJobModel.dart';
import 'package:sabiwork/models/ongoingJobsModel.dart';
import 'package:sabiwork/screens/client/client-job-details.dart';

import 'package:sabiwork/services/getStates.dart';
import 'package:sabiwork/services/job_service.dart';
import 'package:sabiwork/services/socket_service.dart';

class ClientDashboard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ClientDashboardState();
  }
}

class ClientDashboardState extends State<ClientDashboard> {
  int tabIndex = 0;
  SocketConnection socketConnection = SocketConnection();
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
                        onTap: () => socketConnection.disconnectSocket(),
                        // Navigator.pushNamed(context, MyProfileRoute),
                        child: ProfileImage()),
                  ],
                ),
                SizedBox(height: 10),
                Expanded(child: RecentJobs(c))
              ],
            )));
    // });
  }
}

class RecentJobs extends StatelessWidget {
  final _scrollController = ScrollController();
  final Controller c;

  RecentJobs(this.c);
  JobService jobService = JobService();
  completedJobCount(jobs) {
    var count = jobs != null
        ? jobs
            .where((JobData job) => job.jobApplicantStatus == "job completed")
            .toList()
            .length
        : 0;
    return count.toString();
  }

  pendingJobCount(jobs) {
    var count = jobs != null
        ? jobs!
            .where((JobData job) => job.jobApplicantStatus == "not started")
            .toList()
            .length
        : 0;
    return count.toString();
  }

  activeJobCount(jobs) {
    var count = jobs != null
        ? jobs!
            .where((JobData job) =>
                job.jobApplicantStatus == "awaiting confirmation" ||
                job.jobApplicantStatus == "job started" ||
                job.jobApplicantStatus == "job ended")
            .toList()
            .length
        : 0;
    return count.toString();
  }

  Widget build(BuildContext context) {
    // _scrollController.addListener(toggleShowHeader());

    return RefreshIndicator(onRefresh: () async {
      jobService.fetchMyOpenJobs();
      jobService.fetchApprovedJobs();
      jobService.fetchActiveApplicants();
    }, child: Obx(() {
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
                  c.isFetchingJobs.value
                      ? ShimmerTexts()
                      : Column(children: [
                          Text('Hi ${c.userData.value.firstName} ',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff000000),
                                  fontSize: 20)),
                          Text(
                              'You have ${c.activeApplicants.value.result?.data?.length ?? 0} active job',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff8D8D8D),
                                  fontSize: 14)),
                        ]),
                  SizedBox(
                    height: 34,
                  ),
                  // SizedBox(
                  //     height: 40,
                  //     width: MediaQuery.of(context).size.width * 0.75,
                  //     child: TextFormField(
                  //         decoration: InputDecoration(
                  //             filled: true,
                  //             fillColor: Colors.white,
                  //             focusedBorder: OutlineInputBorder(
                  //               borderRadius: BorderRadius.circular(6),
                  //               borderSide: BorderSide(
                  //                   width: 0.5, color: Color(0xffAEAEAE)),
                  //             ),
                  //             enabledBorder: OutlineInputBorder(
                  //               borderRadius: BorderRadius.circular(6),
                  //               borderSide: BorderSide(
                  //                   width: 0.5, color: Color(0xffAEAEAE)),
                  //             ),
                  //             prefixIcon: Icon(Icons.search),
                  //             labelText: 'Search'))),
                  // SizedBox(height: 20),
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
                  c.isFetchingJobs.value
                      ? ShimmerBox()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            WidgetCards(
                                color1: Color(0xffB1EEFF),
                                color2: Color(0xff29BAE2),
                                title: 'Completed Jobs',
                                count: completedJobCount(
                                    c.allApprovedJobs.value.data)),
                            SizedBox(width: 11),
                            WidgetCards(
                                color1: Color(0xffA9FFEA),
                                color2: Color(0xff00B288),
                                title: 'Active Jobs',
                                count: activeJobCount(
                                    c.allApprovedJobs.value.data)),
                            SizedBox(width: 11),
                            WidgetCards(
                                color1: Color(0xffFFB992),
                                color2: Color(0xffD75F1C),
                                title: 'Pending Jobs',
                                count: pendingJobCount(
                                    c.allApprovedJobs.value.data)),
                          ],
                        ),
                  SizedBox(height: 37),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('In Progress',
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
                  c.isFetchingJobs.value &&
                          c.activeApplicants.value.result == null
                      ? ShimmerRow()
                      : c.activeApplicants.value.result != null &&
                              c.activeApplicants.value.result!.data!.length > 0
                          ? Container(
                              height: 150,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: c.activeApplicants.value.result!
                                      .data!.length,
                                  itemBuilder: (BuildContext context, index) {
                                    return ApprovedApplicantsCard(
                                        approvedApplicant: c.activeApplicants
                                            .value.result!.data![index]);
                                    // Image.network(
                                    //     '${widget.job!.jobImages![index]}');
                                  }))
                          : Column(children: [
                              Lottie.asset(
                                'assets/images/no-job.json',
                                width: 125,
                                height: 125,
                                fit: BoxFit.fill,
                              ),
                              Text('You have no active job',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff333333),
                                      fontSize: 17)),
                              SizedBox(height: 10),
                            ]),

                  SizedBox(height: 37),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Recent',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Color(0xff333333),
                                fontSize: 20)),
                        GestureDetector(
                            // onTap: () => c.updateTab(1),
                            child: Text('View All',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff983701),
                                    fontSize: 14)))
                      ]),
                  SizedBox(height: 16),
                  c.isFetchingJobs.value && c.myOpenJobs.value.data == null
                      ? ShimmerList()
                      : c.myOpenJobs.value.data == null
                          ? Center(
                              child: Column(children: [
                                Lottie.asset('assets/images/no-message.json',
                                    fit: BoxFit.fill, width: 150, height: 150),
                                Text('You have no open job',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xff333333),
                                        fontSize: 17)),
                                SizedBox(height: 10),
                              ]),
                            )
                          : Column(
                              children: c.myOpenJobs.value.data != null
                                  ? c.myOpenJobs.value.data!
                                      .map((dynamic e) => JobCard(job: e))
                                      .toList()
                                  : [Container()])

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
  myJob.MyJobData job;
  JobCard({required this.job});
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (_) => JobDetailsState)))
          Get.to(ClientJobDetails(job: job));
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
                          child:
                              // PhotoView(
                              //   tightMode: false,
                              //   imageProvider: NetworkImage('${job.jobImages![0]}'),
                              // )
                              CachedNetworkImage(
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

class ApprovedApplicantsCard extends StatelessWidget {
  NumberFormat _format = NumberFormat('#,###,###,###.##', 'en_US');
  ActiveApplicantData approvedApplicant;
  ApprovedApplicantsCard({required this.approvedApplicant});
  JobService jobService = JobService();
  final CustomFlushBar customFlushBar = CustomFlushBar();
  final CustomDialogs customDialogs = CustomDialogs();

  startJob(context) async {
    try {
      await jobService.startJob(approvedJobId: approvedApplicant.job!.sId);

      customDialogs.successDialog(
          context: context,
          title: 'You have started this job,',
          animation: 'assets/images/wait.json',
          content:
              'Not so fast yet! We advice you ensure the job owner confirms this job has started before getting to work to avoid stories that touches the heart.🙃',
          actionText: 'Okay! Noted',
          action: () {
            Navigator.pop(context);
          });
    } catch (e) {
      customFlushBar.showErrorFlushBar(
          title: 'Error occured', body: '$e', context: context);
    }
  }

  endJob(context) async {
    try {
      await jobService.endJob(approvedJobId: approvedApplicant.job!.sId);

      customDialogs.successDialog(
          context: context,
          title: 'You have ended this job,',
          animation: 'assets/images/wait.json',
          content:
              'Not so fast yet! We advice you ensure the job owner confirms this job has ended. Funds will be transferred to your wallet when the owner confirms this job has ended',
          actionText: 'Okay! Noted',
          action: () {
            Navigator.pop(context);
          });
    } catch (e) {
      customFlushBar.showErrorFlushBar(
          title: 'Error occured', body: '$e', context: context);
    }
  }

  Widget build(BuildContext context) {
    return approvedApplicant.user == null
        ? SizedBox.shrink()
        : Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: EdgeInsets.only(right: 10),
            child: Container(
                child: Container(
                    margin: EdgeInsets.only(bottom: 16),
                    padding: EdgeInsets.fromLTRB(14, 0, 14, 14),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Color(0xffefefef),
                              blurRadius: 10.0,
                              spreadRadius: 3.0)
                        ],
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SabiBadges(
                                title:
                                    '${approvedApplicant.job!.numberOfWorkers} Person(s)',
                                color: Color(0xffe6e6e6)),
                            SabiBadges(
                                title: '${approvedApplicant.job!.jobType}',
                                color: Color(0xfff8dfdb))
                          ],
                        ),
                        SizedBox(height: 9),
                        GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(builder: (_) => JobDetailsState)))
                              // Get.to(ClientJobDetails(job: job));
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    child: Text(
                                        '${approvedApplicant.user!.firstName} ${approvedApplicant.user!.lastName}',
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w800,
                                          color: Color(0xff983701),
                                        ))),
                                Container(
                                    // width: MediaQuery.of(context).size.width * 0.18,
                                    child: FittedBox(
                                  fit: BoxFit.cover,
                                  child: Container(
                                      // width: MediaQuery.of(context).size.width *
                                      //     0.2,
                                      child: Text(
                                          '₦${_format.format(approvedApplicant.job!.pricePerWorker)}',
                                          // '${approvedJob.jobApplicantStatus!.toUpperCase()}',
                                          style: TextStyle(
                                            fontSize: 14,
                                            // color: Colors.green,
                                            fontFamily: "Roboto",
                                            fontWeight: FontWeight.w800,
                                          ))),
                                ))
                              ],
                            )),
                        SizedBox(height: 5),
                        Text('${approvedApplicant.job!.description}',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            )),
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                height: 25,
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: handleButton(
                                    approvedApplicant.jobApplicantStatus,
                                    context)),

                            // SizedBox(
                            //   height: 25,
                            //   width: MediaQuery.of(context).size.width * 0.3 - 22,
                            //   child: SWBorderedButtonWithIcon(
                            //     icon: Icon(Icons.close,
                            //         color: Color(0xffBD4300), size: 13),
                            //     title: 'Cancel',
                            //     onPressed: () {},
                            //   ),
                            // ),
                          ],
                        ),
                        // Text('${job.additionalDetails}',
                        //     style: TextStyle(
                        //       fontSize: 13,
                        //       color: Color(0xff888888),
                        //       fontWeight: FontWeight.w500,
                        //     )),
                      ],
                    ))));
  }

  handleButton(jobStatus, context) {
    if (jobStatus == 'not started') {
      return SWSuttonSmall(
        title: 'Start',
        onPressed: () {
          startJob(context);
          // approve(context);
        },
      );
    } else if (jobStatus == 'awaiting confirmation')
      return SWSuttonSmallDisbaled(
        title: 'Awaiting Confirmation',
        onPressed: () {
          null;
          // approve(context);
        },
      );
    else if (jobStatus == 'job started')
      return SWSuttonSmall(
        title: 'End Job',
        onPressed: () {
          endJob(context);
          // approve(context);
        },
      );
    else if (jobStatus == 'job ended')
      return SWSuttonSmallDisbaled(
        title: 'Waiting End Confirmation',
        onPressed: () {
          // approve(context);
        },
      );
    else if (jobStatus == 'job completed')
      return SWSuttonGreenSmallDisbaled(
        title: 'Job Completed',
        onPressed: () {
          // approve(context);
        },
      );
    else
      return Container();
  }
}

class WidgetCards extends StatelessWidget {
  final String? count;
  final Color? color1;
  final Color? color2;
  final String? title;
  WidgetCards({this.count, this.color1, this.color2, this.title});
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            height: MediaQuery.of(context).size.width / 4 - 20,
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
                            fontWeight: FontWeight.w600,
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
                            fontWeight: FontWeight.w600,
                            color: Color(0xffffffff),
                            fontSize: 14))),
              ],
            )),
        Container(
          height: MediaQuery.of(context).size.width / 4 - 20,
          width: MediaQuery.of(context).size.width / 3 - 25,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.black.withOpacity(0.2)),
        )
      ],
    );
  }
}
