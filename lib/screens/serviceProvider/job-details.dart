import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:sabiwork/common/profileImage.dart';
import 'package:sabiwork/common/ratingBar.dart';
import 'package:sabiwork/common/stacked_image.dart';
import 'package:sabiwork/components/SWbutton.dart';
import 'package:sabiwork/helpers/customColors.dart';
import 'package:sabiwork/helpers/flushBar.dart';
import 'package:sabiwork/models/allJobsModel.dart';
import 'package:sabiwork/models/applyJobModel.dart';
import 'package:sabiwork/services/job_service.dart';

class JobDetails extends StatefulWidget {
  Data? job;
  JobDetails({this.job});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return JobDetailsState();
  }
}

class JobDetailsState extends State<JobDetails> {
  NumberFormat _format = NumberFormat('#,###,###,###.##', 'en_US');
  final JobService jobService = JobService();
  final ApplyJobModel applyJobModel = ApplyJobModel();
  final CustomFlushBar customFlushBar = CustomFlushBar();
  bool obscurePassword = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Color(0xff888888)),
          actions: [GestureDetector(child: Icon(Icons.more_vert))],
        ),
        body: Container(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: SingleChildScrollView(
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
                                title: 'Females only', color: Color(0xfff8dfdb))
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            StackedImage(count: 2),
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
                // action
                SizedBox(height: 44),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 34,
                      width: MediaQuery.of(context).size.width * 0.28,
                      child: SWSuttonSmall(
                        title: 'Apply',
                        onPressed: () {
                          _apply(context);
                        },
                      ),
                    ),
                    SizedBox(width: 17),
                    SizedBox(
                      height: 34,
                      width: MediaQuery.of(context).size.width * 0.28,
                      child: SWBorderedButton(
                        title: 'Save',
                        onPressed: () {},
                      ),
                    )
                  ],
                ),
                SizedBox(height: 17),
                // Description
                Divider(),
                SizedBox(height: 17),
                Text('Job Description',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    )),
                SizedBox(height: 11),
                Text('${widget.job!.additionalDetails}',
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xff888888),
                      fontWeight: FontWeight.w500,
                    )),
                SizedBox(height: 17),
                // Description
                Divider(),
                SizedBox(height: 17),
                Text('Images',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    )),
                SizedBox(height: 11),
                Container(
                    height: 115,
                    child: widget.job!.jobImages!.length > 0
                        ? ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.job!.jobImages!.length,
                            itemBuilder: (BuildContext context, index) {
                              return CachedNetworkImage(
                                imageUrl: '${widget.job!.jobImages![index]}',
                                progressIndicatorBuilder: (context, url,
                                        downloadProgress) =>
                                    Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        height: 115,
                                        child: Center(
                                            child: SizedBox(
                                                width: 10,
                                                height: 10,
                                                child:
                                                    CircularProgressIndicator(
                                                        strokeWidth: 2,
                                                        value: downloadProgress
                                                            .progress)))),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              );
                              // Image.network(
                              //     '${widget.job!.jobImages![index]}');
                            })
                        : Image.network(
                            'https://via.placeholder.com/150.png?text=No+image+available')),
                SizedBox(height: 17),
                // Description
                Divider(),
                SizedBox(height: 17),
                Text('About Hirer',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    )),
                SizedBox(height: 11),
                ListTile(
                  contentPadding: EdgeInsets.only(left: 0),
                  leading: UsersProfileImageSAvatar(user: widget.job!.user),
                  title: Text(
                      '${widget.job!.user!.firstName} ${widget.job!.user!.lastName}',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 13)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('23 hires', style: TextStyle(fontSize: 10)),
                      Row(children: [
                        RatingBarComponent(initialRating: 3.5),
                        Text('(136 reviews)', style: TextStyle(fontSize: 7)),
                      ])
                    ],
                  ),
                ),
                SizedBox(height: 17),
                Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nisi lectus diam, amet, ullamcorper egestas iaculis. Id neque, morbi sit ultrices imperdiet diam malesuada nulla. Pellentesque facilisis congue ac ligula faucibus amet viverra. Vel lectus pharetra erat metus quis amet rhoncus eget. Egestas id semper massa porttitor ac, at pretium. Commodo, tincidunt cras pretium augue proin sollicitudin tellus aliquam. Erat mi id dolor nisl nec sed facilisi.',
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xff888888),
                      fontWeight: FontWeight.w500,
                    ))
              ],
            ))));
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
