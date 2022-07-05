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
import 'package:sabiwork/models/userModel.dart';
import 'package:sabiwork/screens/chat/chat-room.dart';
import 'package:sabiwork/services/getStates.dart';
import 'package:sabiwork/services/job_service.dart';

class ServiceproviderProfile extends StatefulWidget {
  ApplicantData? applicants;
  ServiceproviderProfile({this.applicants});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ServiceproviderProfileState();
  }
}

class ServiceproviderProfileState extends State<ServiceproviderProfile> {
  NumberFormat _format = NumberFormat('#,###,###,###.##', 'en_US');
  final JobService jobService = JobService();
  int tabIndex = 0;

  final ApplyJobModel applyJobModel = ApplyJobModel();
  final CustomFlushBar customFlushBar = CustomFlushBar();
  bool obscurePassword = true;
  Controller c = Get.put(Controller());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  submit(context) async {
    try {
      if (!_formKey.currentState!.validate()) {
        return;
      }
      _formKey.currentState!.save();
      final result =
          await jobService.applyForJob(applyJobModel, widget.applicants!.sId);
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

  Widget build(BuildContext context) {
    ServiceproviderProfileController clientC =
        Get.put(ServiceproviderProfileController());
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
                Column(
                  children: [
                    UsersProfileImageSAvatarx2(user: widget.applicants!.user),
                    SizedBox(height: 20),
                    Text(
                        '${widget.applicants!.user!.firstName} ${widget.applicants!.user!.lastName}',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 13)),
                    SizedBox(height: 4),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      RatingBarComponent(initialRating: 3.5),
                      Text('(136 reviews)', style: TextStyle(fontSize: 7)),
                    ]),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.location_pin, size: 8),
                        SizedBox(width: 3),
                        Text(
                            '${widget.applicants!.user!.lga ?? 'Not specified'}, ${widget.applicants!.user!.state ?? ''}',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ))
                      ],
                    ),
                    SizedBox(height: 14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 34,
                          width: MediaQuery.of(context).size.width * 0.3 - 22,
                          child: SWSuttonSmall(
                            title: 'Message',
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChatRoom(
                                        user: widget.applicants as UserModel),
                                  ));
                            },
                          ),
                        ),
                        SizedBox(width: 17),
                        SizedBox(
                          height: 34,
                          width: MediaQuery.of(context).size.width * 0.3 - 22,
                          child: SWBorderedButton(
                            title: 'Review',
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 17),
                // Description
                Divider(),
                SizedBox(height: 17),
                Text('About',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    )),
                SizedBox(height: 11),
                if (clientC.showReview == true)
                  Container(
                      padding: EdgeInsets.only(bottom: 17),
                      child: Text('${widget.applicants!.user!.address}',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xff888888),
                            fontWeight: FontWeight.w500,
                          ))),

                // Description
                Divider(),
                SizedBox(height: 17),
                Expanded(child: ReviewList(c)),
              ],
            ))));
  }
}

class ReviewList extends StatelessWidget {
  final _scrollController = ScrollController();
  ServiceproviderProfileController clientC =
      Get.put(ServiceproviderProfileController());
  final Controller c;
  ReviewList(this.c);
  Widget build(BuildContext context) {
    return Obx(() {
      return SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 34,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Reviews',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                )),
            GestureDetector(
                onTap: () {
                  clientC.updateState();
                },
                child: clientC.showReview == true
                    ? Icon(Icons.keyboard_arrow_down)
                    : Icon(Icons.keyboard_arrow_up))
          ]),
          SizedBox(height: 11),
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
          if (clientC.showReview == true)
            c.isFetchingJobs.value
                ? ShimmerList()
                : Column(
                    children: c.allJobs.value.data!
                        .map((Data e) => ReviewCard(job: e))
                        .toList())
        ],
      ));
    });
  }
}

class ReviewCard extends StatelessWidget {
  NumberFormat _format = NumberFormat('#,###,###,###.##', 'en_US');
  Data job;
  ReviewCard({required this.job});
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (_) => JobDetailsState)))
          // Get.to ServiceproviderProfile(job: job));
        },
        child: Container(
            margin: EdgeInsets.only(bottom: 16),
            padding: EdgeInsets.fromLTRB(14, 0, 14, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                    contentPadding: EdgeInsets.only(left: 0),
                    leading: UsersProfileImageSAvatar(user: job.user),
                    title: Text('${job.user!.firstName} ${job.user!.lastName}',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 13)),
                    subtitle: Row(children: [
                      RatingBarComponent(initialRating: 3.5),
                      Text('(136 reviews)', style: TextStyle(fontSize: 7)),
                    ])),

                SizedBox(height: 10),
                Container(
                    color: Color(0xffFF8E08).withOpacity(0.05),
                    padding: EdgeInsets.symmetric(horizontal: 17, vertical: 6),
                    child: Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nisi lectus diam, amet, ullamcorper egestas iaculis. Id neque, morbi sit ultrices imperdiet diam malesuada nulla. Pellentesque facilisis congue ac ligula faucibus amet viverra.',
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 10,
                          color: Color(0xff272727),
                          fontWeight: FontWeight.w400,
                        ))),
                // SizedBox(height: 14),
              ],
            )));
  }
}

class ServiceproviderProfileController extends GetxController {
  RxBool showReview = true.obs;
  void updateState() => showReview.value = !showReview.value;
}
