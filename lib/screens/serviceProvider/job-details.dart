import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sabiwork/common/ratingBar.dart';
import 'package:sabiwork/common/stacked_image.dart';
import 'package:sabiwork/components/SWbutton.dart';
import 'package:sabiwork/helpers/customColors.dart';

class JobDetails extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return JobDetailsState();
  }
}

class JobDetailsState extends State<JobDetails> {
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
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      new Text(
                        'Add a Message to your application (Optional)',
                        style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: CustomColors.PrimaryColor),
                      ),
                      SizedBox(
                          child: TextFormField(
                              maxLines: 4,
                              style: TextStyle(
                                fontSize: 10,
                              ),
                              decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: BorderSide(
                                        width: 0.5, color: Color(0xffF5F3F3)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: BorderSide(
                                        width: 0.5, color: Color(0xffF5F3F3)),
                                  ),
                                  hintText:
                                      'Write why you should be hired for this job  (e.g.: I am very good at this and very careful with items.)',
                                  hintStyle: TextStyle(
                                      fontSize: 10,
                                      color: Color(0xff888888))))),
                      SizedBox(height: 10),
                      SizedBox(
                          height: 33,
                          child: SWSuttonSmall(
                              title: 'Send  Application',
                              onPressed: () {
                                Navigator.pop(context);
                              }))
                    ]),
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
                        Text('Indoor',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: Color(0xff983701),
                            )),
                        SizedBox(height: 7),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Text(
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Non varius.',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ))),
                        SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.location_pin, size: 10),
                            Text('Mushin',
                                style: TextStyle(
                                  fontSize: 8,
                                  fontWeight: FontWeight.w500,
                                ))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.lock_clock, size: 10),
                            Text(' 4 days  ago',
                                style: TextStyle(
                                  fontSize: 8,
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
                        Text('N5,000',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                            )),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            SabiBadges(
                                title: '3 Person', color: Color(0xffe6e6e6)),
                            SabiBadges(
                                title: 'Females only', color: Color(0xfff8dfdb))
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            StackedImage(),
                            SizedBox(width: 10),
                            Text('10 applicants',
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
                Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi feugiat tristique in maecenas ut sed. Vel viverra eget orci turpis sit. Mauris posuere at duis nisl nunc in sapien. Sit feugiat sit condimentum duis. Arcu lobortis rhoncus pellentesque tristique egestas nulla vestibulum dignissim. Dapibus augue pulvinar sit tempor tempor. Sed diam tincidunt vivamus turpis magnis et commodo ultricies. Cursus diam.',
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
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Image.asset('assets/images/img1.jpeg'),
                        Image.asset('assets/images/img2.jpg'),
                        Image.asset('assets/images/img3.jpeg')
                      ],
                    )),
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
                  leading: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/danKid.jpg'),
                  ),
                  title: Text('Daniel Olowu',
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
