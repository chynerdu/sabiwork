import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:sabiwork/common/profileImage.dart';
import 'package:sabiwork/common/ratingBar.dart';
import 'package:sabiwork/common/shimmerList.dart';
import 'package:sabiwork/common/stacked_image.dart';
import 'package:sabiwork/components/SWbutton.dart';
import 'package:sabiwork/helpers/customColors.dart';
import 'package:sabiwork/helpers/flushBar.dart';
import 'package:sabiwork/models/allJobsModel.dart';
import 'package:sabiwork/models/applicantsModel.dart';
import 'package:sabiwork/models/applyJobModel.dart';
import 'package:sabiwork/models/myJobsModel.dart';
import 'package:sabiwork/screens/client/service-provider-profile.dart';
import 'package:sabiwork/services/getStates.dart';
import 'package:sabiwork/services/job_service.dart';

class ClientJobDetails extends StatefulWidget {
  MyJobData? job;
  ClientJobDetails({this.job});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ClientJobDetailsState();
  }
}

class ClientJobDetailsState extends State<ClientJobDetails> {
  NumberFormat _format = NumberFormat('#,###,###,###.##', 'en_US');
  final JobService jobService = JobService();
  int tabIndex = 0;

  final ApplyJobModel applyJobModel = ApplyJobModel();
  final CustomFlushBar customFlushBar = CustomFlushBar();
  bool obscurePassword = true;
  Controller c = Get.put(Controller());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    getData();
  }

  getData() async {
    await jobService.fetchApplicants(widget.job!.sId);
    await jobService.fetchApprovedApplicants(widget.job!.sId);
  }

  submit(context) async {
    try {
      if (!_formKey.currentState!.validate()) {
        return;
      }
      _formKey.currentState!.save();
      final result =
          await jobService.applyForJob(applyJobModel, widget.job!.sId);
      print('result $result');
      Navigator.pop(context);
      customFlushBar.showSuccessFlushBar(
          title: 'Application sent',
          body: 'You have successfully applied for this job',
          context: context);
    } catch (e) {
      // show flushbar
      customFlushBar.showErrorFlushBar(
          title: 'Error occured', body: '$e', context: context);
    }
  }

  Future<bool> _apply(context) async {
    return (await showDialog(
          context: context,
          builder: (context) => BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
            child: new AlertDialog(
              // title: new Text(
              //   'Add a Message to your application (Optional)',
              //   style: TextStyle(color: CustomColors.PrimaryColor),
              // ),
              content: Container(
                height: 200,
                child: Form(
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          new Text(
                            'Add a Message to your application (Optional)',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: CustomColors.PrimaryColor),
                          ),
                          SizedBox(
                              child: TextFormField(
                                  maxLines: 5,
                                  onSaved: (String? value) {
                                    applyJobModel.message = value;
                                  },
                                  style: TextStyle(
                                    fontSize: 13,
                                  ),
                                  decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6),
                                        borderSide: BorderSide(
                                            width: 0.5,
                                            color: Color(0xffF5F3F3)),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6),
                                        borderSide: BorderSide(
                                            width: 0.5,
                                            color: Color(0xffF5F3F3)),
                                      ),
                                      hintText:
                                          'Write why you should be hired for this job  (e.g.: I am very good at this and very careful with items.)',
                                      hintStyle: TextStyle(
                                          fontSize: 13,
                                          color: Color(0xff888888))))),
                          SizedBox(height: 10),
                          SizedBox(
                              height: 33,
                              child: SWSuttonSmall(
                                  title: 'Send  Application',
                                  onPressed: () {
                                    submit(context);
                                  }))
                        ])),
              ),

              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(15)),
            ),
          ),
        )) ??
        false;
  }

  Widget build(BuildContext context) {
    ClientJobDetailsController clientC = Get.put(ClientJobDetailsController());
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Color(0xff888888)),
          actions: [GestureDetector(child: Icon(Icons.more_vert))],
        ),
        body: Container(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Container(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // top
                Container(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // left
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${widget.job!.jobType}',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: Color(0xff983701),
                            )),
                        SizedBox(height: 7),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Text('${widget.job!.description}',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ))),
                        SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.location_pin, size: 8),
                            SizedBox(width: 3),
                            Text(
                                '${widget.job!.user!.lga ?? 'Not specified'}, ${widget.job!.user!.state ?? ''}',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.access_time, size: 8),
                            SizedBox(width: 3),
                            Text(
                                '${Jiffy(widget.job!.createdAt).startOf(Units.DAY).fromNow()}',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ))
                          ],
                        )
                      ],
                    ),
                    // right
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('₦${_format.format(widget.job!.pricePerWorker)}',
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.w800,
                            )),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            SabiBadges(
                                title:
                                    '${widget.job!.numberOfWorkers} Person(s)',
                                color: Color(0xffe6e6e6)),
                            SabiBadges(
                                title: 'Job open', color: Color(0xFF7AD67D))
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            StackedImage(count: widget.job!.applicantCount),
                            SizedBox(width: 10),
                            Text('${widget.job!.applicantCount} applicant(s)',
                                style: TextStyle(
                                  fontSize: 8,
                                  fontWeight: FontWeight.w500,
                                )),
                          ],
                        ),
                      ],
                    )
                  ],
                )),

                SizedBox(height: 17),
                // Description
                Divider(),
                SizedBox(height: 17),
                Obx(() {
                  return Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Job Description',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                )),
                            GestureDetector(
                                onTap: () {
                                  clientC.updateState();
                                },
                                child: clientC.showDescription == true
                                    ? Icon(Icons.keyboard_arrow_down)
                                    : Icon(Icons.keyboard_arrow_up))
                          ]),
                      SizedBox(height: 11),
                      if (clientC.showDescription == true)
                        Container(
                            padding: EdgeInsets.only(bottom: 17),
                            child: Text('${widget.job!.additionalDetails}',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Color(0xff888888),
                                  fontWeight: FontWeight.w500,
                                ))),
                    ],
                  );
                }),

                // Description
                Divider(),
                SizedBox(height: 17),
                Obx(() {
                  return Expanded(
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
                                            "Applicants (${c.allApplicants.value.data != null ? c.allApplicants.value.data!.length : 0})",
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
                                            "Saved (${c.allApplicants.value.data != null ? c.allApplicants.value.data!.length : 0})",
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
                                    Tab(
                                      child: Container(
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Approved (${c.allApprovedApplicants.value.data != null ? c.allApprovedApplicants.value.data!.length : 0})",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: tabIndex == 2
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
                              children: [
                                Applicants(c),
                                Shortlisted(c),
                                ApprovedApplicants(c)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ))));
  }
}

class Applicants extends StatelessWidget {
  final _scrollController = ScrollController();
  final Controller c;

  // final List<ApplicantData> applicants;
  Applicants(this.c);
  Widget build(BuildContext context) {
    return Obx(() {
      return SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
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
          //               borderSide:
          //                   BorderSide(width: 0.5, color: Color(0xffAEAEAE)),
          //             ),
          //             enabledBorder: OutlineInputBorder(
          //               borderRadius: BorderRadius.circular(6),
          //               borderSide:
          //                   BorderSide(width: 0.5, color: Color(0xffAEAEAE)),
          //             ),
          //             prefixIcon: Icon(Icons.search),
          //             label: Text('Search')))),
          // SizedBox(height: 37),
          c.isFetchingApplicants.value
              ? ShimmerList()
              : Column(
                  children: c.allApplicants.value.data != null
                      ? c.allApplicants.value.data!
                          .map((ApplicantData e) => UserCard(applicant: e))
                          .toList()
                      : [Container()])
        ],
      ));
    });
  }
}

class Shortlisted extends StatelessWidget {
  final _scrollController = ScrollController();
  final Controller c;
  Shortlisted(this.c);
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 34,
        ),
        c.isFetchingApplicants.value
            ? ShimmerList()
            : Column(
                children: c.allApplicants.value.data != null
                    ? c.allApplicants.value.data!
                        .map((ApplicantData e) =>
                            SaveApplicantUserCard(applicant: e))
                        .toList()
                    : [Container()])
      ],
    ));
  }
}

class ApprovedApplicants extends StatelessWidget {
  final _scrollController = ScrollController();
  final Controller c;
  ApprovedApplicants(this.c);
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 34,
        ),
        c.isFetchingApplicants.value
            ? ShimmerList()
            : Column(
                children: c.allApprovedApplicants.value.data != null
                    ? c.allApprovedApplicants.value.data!
                        .map((ApplicantData e) =>
                            ApprovedApplicantUserCard(applicant: e))
                        .toList()
                    : [Container()])
      ],
    ));
  }
}

class UserCard extends StatelessWidget {
  NumberFormat _format = NumberFormat('#,###,###,###.##', 'en_US');
  ApplicantData applicant;

  JobService jobService = JobService();
  final CustomFlushBar customFlushBar = CustomFlushBar();
  UserCard({required this.applicant});

  shortList(context) async {
    try {
      await jobService.shortlistApplicant(
          id: applicant.job, applicantId: applicant.user!.id);
      Navigator.pop(context);
      customFlushBar.showSuccessFlushBar(
          title: 'Shortlisted',
          body: 'You have successfully shortlisted this applicant',
          context: context);
      await jobService.fetchApplicants(applicant.job);
    } catch (e) {
      customFlushBar.showErrorFlushBar(
          title: 'Error occured', body: '$e', context: context);
    }
  }

  approve(context) async {
    try {
      await jobService.approveShortlistApplicant(
          id: applicant.job, applicantId: applicant.user!.id);
      Navigator.pop(context);
      customFlushBar.showSuccessFlushBar(
          title: 'Approved',
          body: 'You have successfully approved this applicant',
          context: context);
      await jobService.fetchApprovedApplicants(applicant.job);
    } catch (e) {
      customFlushBar.showErrorFlushBar(
          title: 'Error occured', body: '$e', context: context);
    }
  }

  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (_) => JobDetailsState)))
          // Get.to(ServiceproviderProfile(job: applicant));
        },
        child: Container(
            margin: EdgeInsets.only(bottom: 16),
            padding: EdgeInsets.fromLTRB(14, 0, 14, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                    onTap: () =>
                        Get.to(ServiceproviderProfile(applicants: applicant)),
                    child: ListTile(
                      contentPadding: EdgeInsets.only(left: 0),
                      leading: UsersProfileImageSAvatar(user: applicant.user),
                      title: Text(
                          '${applicant.user!.firstName} ${applicant.user!.lastName}',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 13)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('has completed 10 jobs',
                              style: TextStyle(fontSize: 10)),
                          Row(children: [
                            RatingBarComponent(initialRating: 3.5),
                            Text('(136 reviews)',
                                style: TextStyle(fontSize: 7)),
                          ])
                        ],
                      ),
                      trailing: IconButton(
                          onPressed: () => shortList(context),
                          icon: Icon(Icons.favorite_border_outlined, size: 15)),
                    )),
                SizedBox(height: 14),
                Container(
                    color: Color(0xffFF8E08).withOpacity(0.05),
                    padding: EdgeInsets.symmetric(horizontal: 17, vertical: 6),
                    child: Text('${applicant.message}',
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 10,
                          color: Color(0xff272727),
                          fontWeight: FontWeight.w400,
                        ))),
                SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 34,
                      width: MediaQuery.of(context).size.width * 0.3 - 22,
                      child: SWSuttonSmall(
                        title: 'Approve',
                        onPressed: () {
                          approve(context);
                        },
                      ),
                    ),
                    SizedBox(width: 17),
                    SizedBox(
                      height: 34,
                      width: MediaQuery.of(context).size.width * 0.3 - 22,
                      child: SWBorderedButtonWithIcon(
                        icon: Icon(Icons.reply,
                            color: Color(0xffBD4300), size: 13),
                        title: 'Reply',
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(width: 17),
                    SizedBox(
                      height: 34,
                      width: MediaQuery.of(context).size.width * 0.3 - 22,
                      child: SWBorderedButton(
                        title: 'Decline',
                        onPressed: () {},
                      ),
                    )
                  ],
                ),
              ],
            )));
  }
}

class SaveApplicantUserCard extends StatelessWidget {
  NumberFormat _format = NumberFormat('#,###,###,###.##', 'en_US');
  ApplicantData applicant;
  SaveApplicantUserCard({required this.applicant});
  JobService jobService = JobService();
  final CustomFlushBar customFlushBar = CustomFlushBar();

  approve(context) async {
    try {
      await jobService.approveShortlistApplicant(
          id: applicant.job, applicantId: applicant.user!.id);
      Navigator.pop(context);
      customFlushBar.showSuccessFlushBar(
          title: 'Approved',
          body: 'You have successfully approved this applicant',
          context: context);
      await jobService.fetchApprovedApplicants(applicant.job);
    } catch (e) {
      customFlushBar.showErrorFlushBar(
          title: 'Error occured', body: '$e', context: context);
    }
  }

  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (_) => JobDetailsState)))
        },
        child: Container(
            margin: EdgeInsets.only(bottom: 16),
            padding: EdgeInsets.fromLTRB(14, 0, 14, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                    onTap: () =>
                        Get.to(ServiceproviderProfile(applicants: applicant)),
                    child: ListTile(
                      contentPadding: EdgeInsets.only(left: 0),
                      leading: UsersProfileImageSAvatar(user: applicant.user),
                      title: Text(
                          '${applicant.user!.firstName} ${applicant.user!.lastName}',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 13)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('has completed 10 jobs',
                              style: TextStyle(fontSize: 10)),
                          Row(children: [
                            RatingBarComponent(initialRating: 3.5),
                            Text('(136 reviews)',
                                style: TextStyle(fontSize: 7)),
                          ])
                        ],
                      ),
                    )),
                SizedBox(height: 14),
                Container(
                    color: Color(0xffFF8E08).withOpacity(0.05),
                    padding: EdgeInsets.symmetric(horizontal: 17, vertical: 6),
                    child: Text('${applicant.message}',
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 10,
                          color: Color(0xff272727),
                          fontWeight: FontWeight.w400,
                        ))),
                SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 34,
                      width: MediaQuery.of(context).size.width * 0.3 - 22,
                      child: SWSuttonSmall(
                        title: 'Approve',
                        onPressed: () {
                          approve(context);
                        },
                      ),
                    ),
                    SizedBox(width: 17),
                    SizedBox(
                      height: 34,
                      width: MediaQuery.of(context).size.width * 0.3 - 22,
                      child: SWBorderedButtonWithIcon(
                        icon: Icon(Icons.close,
                            color: Color(0xffBD4300), size: 13),
                        title: 'Decline',
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ],
            )));
  }
}

class ApprovedApplicantUserCard extends StatelessWidget {
  NumberFormat _format = NumberFormat('#,###,###,###.##', 'en_US');
  ApplicantData applicant;
  ApprovedApplicantUserCard({required this.applicant});
  JobService jobService = JobService();
  final CustomFlushBar customFlushBar = CustomFlushBar();

  confirmStartJob(context) async {
    try {
      await jobService.confirmStartJob(approvedJobId: applicant.sId);
      Navigator.pop(context);
      customFlushBar.showSuccessFlushBar(
          title: 'Confirmed',
          body: 'You have successfully confirmed this job has started',
          context: context);
      await jobService.fetchApprovedApplicants(applicant.job);
    } catch (e) {
      customFlushBar.showErrorFlushBar(
          title: 'Error occured', body: '$e', context: context);
    }
  }

  confirmEndJob(context) async {
    try {
      await jobService.confirmEndJob(approvedJobId: applicant.sId);
      Navigator.pop(context);
      customFlushBar.showSuccessFlushBar(
          title: 'Confirmed',
          body: 'You have successfully confirmed this job has ended',
          context: context);
      await jobService.fetchApprovedApplicants(applicant.job);
    } catch (e) {
      customFlushBar.showErrorFlushBar(
          title: 'Error occured', body: '$e', context: context);
    }
  }

  handleButton(jobStatus, context) {
    if (jobStatus == 'not started') {
      return SWSuttonSmallDisbaled(
        title: 'Waiting to Start',
        onPressed: () {
          null;
          // approve(context);
        },
      );
    } else if (jobStatus == 'awaiting confirmation')
      return SWSuttonSmall(
        title: 'Confirm Job Has Started',
        onPressed: () {
          confirmStartJob(context);
          // approve(context);
        },
      );
    else if (jobStatus == 'job started')
      return SWSuttonSmallDisbaled(
        title: 'Job Started',
        onPressed: () {
          // approve(context);
        },
      );
    else if (jobStatus == 'job ended')
      return SWSuttonSmall(
        title: 'Confirm Job Has Ended',
        onPressed: () {
          confirmEndJob(context);
          // approve(context);
        },
      );
    else
      return Container();
  }

  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (_) => JobDetailsState)))
        },
        child: Container(
            margin: EdgeInsets.only(bottom: 16),
            padding: EdgeInsets.fromLTRB(14, 0, 14, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                    onTap: () =>
                        Get.to(ServiceproviderProfile(applicants: applicant)),
                    child: ListTile(
                      contentPadding: EdgeInsets.only(left: 0),
                      leading: UsersProfileImageSAvatar(user: applicant.user),
                      title: Text(
                          '${applicant.user!.firstName} ${applicant.user!.lastName}',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 13)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('has completed 10 jobs',
                              style: TextStyle(fontSize: 10)),
                          Row(children: [
                            RatingBarComponent(initialRating: 3.5),
                            Text('(136 reviews)',
                                style: TextStyle(fontSize: 7)),
                          ])
                        ],
                      ),
                      trailing:
                          Text('${applicant.jobApplicantStatus!.toUpperCase()}',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.green,
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.w800,
                              )),
                    )),
                SizedBox(height: 14),
                Container(
                    color: Color(0xffFF8E08).withOpacity(0.05),
                    padding: EdgeInsets.symmetric(horizontal: 17, vertical: 6),
                    child: Text('${applicant.message}',
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 10,
                          color: Color(0xff272727),
                          fontWeight: FontWeight.w400,
                        ))),
                SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: 34,
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: handleButton(
                            applicant.jobApplicantStatus, context)),
                    SizedBox(width: 17),
                    // SizedBox(
                    //   height: 34,
                    //   width: MediaQuery.of(context).size.width * 0.3 - 22,
                    //   child: SWBorderedButtonWithIcon(
                    //     icon: Icon(Icons.close,
                    //         color: Color(0xffBD4300), size: 13),
                    //     title: 'Decline',
                    //     onPressed: () {},
                    //   ),
                    // ),
                  ],
                ),
              ],
            )));
  }
}

class SabiBadges extends StatelessWidget {
  final Color color;
  final String title;

  SabiBadges({required this.color, required this.title});

  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
        decoration: BoxDecoration(
          color: color,
        ),
        child: Text(
          '$title',
          style: TextStyle(fontSize: 8),
        ));
  }
}

class ClientJobDetailsController extends GetxController {
  RxBool showDescription = true.obs;
  void updateState() => showDescription.value = !showDescription.value;
}
