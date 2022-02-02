import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sabiwork/common/overlay_wrapper.dart';
import 'package:sabiwork/common/route_constants.dart';
import 'package:sabiwork/components/cButton.dart';
import 'package:sabiwork/helpers/customColors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Intro extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return IntroState();
  }
}

class IntroState extends State<Intro> {
  final controller = PageController(viewportFraction: 1);
  int _currentPage = 0;

  initState() {
    // _currentPage
  }

  swipe(page) {
    controller.animateToPage(
      page,
      duration: Duration(milliseconds: 200),
      curve: Curves.easeIn,
    );
  }

  Widget build(BuildContext context) {
    return OverLayWrapper(
        child: Scaffold(
            body: Container(
                padding: EdgeInsets.fromLTRB(47, 0, 47, 0),
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.59),
                    Expanded(
                        // color: Colors.black,
                        // height: 300,
                        child: PageView(
                      physics: ClampingScrollPhysics(),
                      controller: controller,
                      onPageChanged: (int page) {
                        print('page $page');
                        _currentPage = page;
                        print('currentpage $_currentPage');
                        // this page variable is the new page and will change before the pageController fully reaches the full, rounded int value
                        // var swipingRight = page > controller.page;
                        // print(swipingRight);
                      },
                      children: [
                        PageViewItem(
                            title: 'I want a job done',
                            body: 'Find people wey sabi do anything'),
                        PageViewItem(
                            title: 'You need a job',
                            body:
                                'Find people wey want make you help dem do work'),
                        PageViewItem(
                            title: 'Get Paid',
                            body:
                                'Make better money for wetin you sabi do wella'),
                        PageViewItem(
                            title: 'Get to work',
                            body:
                                'No time to dull for this wan, use your time better'),
                      ],
                    )),
                    SmoothPageIndicator(
                        controller: controller, // PageController
                        count: 4,
                        effect: SlideEffect(
                            spacing: 16.0,
                            radius: 5.0,
                            dotWidth: 10.0,
                            dotHeight: 10.0,
                            strokeWidth: 1.5,
                            dotColor: Colors.grey,
                            activeDotColor: CustomColors.ButtonColor),
                        onDotClicked: (index) {
                          swipe(index);
                        }),
                    SizedBox(height: 39),
                    Container(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: () =>
                                Navigator.pushNamed(context, LoginRoute),
                            child: Text('Skip',
                                style: TextStyle(
                                    fontSize: 15.5,
                                    fontWeight: FontWeight.w500,
                                    color: CustomColors.ButtonColor))),
                        InkWell(
                            onTap: () {
                              print('tapped');
                              if (_currentPage <= 2) {
                                _currentPage = _currentPage + 1;
                                swipe(_currentPage);
                              } else {
                                Navigator.pushNamed(context, LoginRoute);
                              }
                            },
                            child: SizedBox(
                                width: 100,
                                height: 40,
                                child: CButtonOneIcon(
                                    icon: Icon(Icons.arrow_forward_ios,
                                        size: 10, color: Colors.white),
                                    text: 'Next')))
                      ],
                    )),
                    SizedBox(height: 51),
                  ],
                ))));
  }
}

class PageViewItem extends StatelessWidget {
  final String title;
  final String body;

  final String? image;

  PageViewItem({required this.title, required this.body, this.image});

  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        // Container(
        //     // color: Colors.red,
        //     width: 200,
        //     height: 200),
        // SizedBox(height: 20),
        Text(title,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 17.5,
                fontWeight: FontWeight.w700,
                color: CustomColors.axterikBlackMain2)),
        SizedBox(height: 22),
        Text(
          body,
          style: TextStyle(fontSize: 15.5, color: CustomColors.light),
          textAlign: TextAlign.center,
        )
      ],
    ));
  }
}
