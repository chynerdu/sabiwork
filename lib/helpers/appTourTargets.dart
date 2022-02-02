import 'package:flutter/material.dart';
import 'package:sabiwork/helpers/customColors.dart';
import 'package:sabiwork/services/localStorage.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class AppTourTargets {
  List<TargetFocus> targets = [];
  LocalStorage localStorage = LocalStorage();

  void addTargets({
    context,
    myJobsKey,
    // copyKeyTourKey,
    // shareKeyTourKey,
    walletKey,
  }) {
    targets.add(
        TargetFocus(identify: "myJobsKey", keyTarget: myJobsKey, contents: [
      TargetContent(
          align: ContentAlign.top,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "My Jobs",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20.0),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 0.0),
                  child: Text(
                    "Tap to view all your jobs",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ))
    ]));

    targets.add(TargetFocus(identify: "Target 1", keyTarget: walletKey,
        //  color: Colors.red,
        contents: [
          TargetContent(
              align: ContentAlign.top,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: MediaQuery.of(context).size.height * 0.17),
                    Text(
                      "View earnings",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20.0),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        "View wallet and track your earnings and transaction",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ))
        ]));
    // targets.add(
    //     TargetFocus(identify: "Target 1", keyTarget: copyKeyTourKey, contents: [
    //   TargetContent(
    //       align: ContentAlign.bottom,
    //       child: Container(
    //         child: Column(
    //           mainAxisSize: MainAxisSize.min,
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: <Widget>[
    //             Text(
    //               "Copy personalized visit key",
    //               style: TextStyle(
    //                   fontWeight: FontWeight.bold,
    //                   color: Colors.white,
    //                   fontSize: 20.0),
    //             ),
    //             Padding(
    //               padding: const EdgeInsets.only(top: 10.0),
    //               child: Text(
    //                 "Tap to copy your visit key and share with prospective visitors",
    //                 style: TextStyle(color: Colors.white),
    //               ),
    //             )
    //           ],
    //         ),
    //       ))
    // ]));
    // targets.add(TargetFocus(identify: "Target 1", keyTarget: shareKeyTourKey,
    //     //  color: Colors.red,
    //     contents: [
    //       TargetContent(
    //           align: ContentAlign.bottom,
    //           child: Container(
    //             child: Column(
    //               mainAxisSize: MainAxisSize.min,
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: <Widget>[
    //                 Text(
    //                   "Share personalized visit key",
    //                   style: TextStyle(
    //                       fontWeight: FontWeight.bold,
    //                       color: Colors.white,
    //                       fontSize: 20.0),
    //                 ),
    //                 Padding(
    //                   padding: const EdgeInsets.only(top: 10.0),
    //                   child: Text(
    //                     "Tap and let us help you share your visit key through your social networks ",
    //                     style: TextStyle(color: Colors.white),
    //                   ),
    //                 )
    //               ],
    //             ),
    //           ))
    //     ]));

    //  commented for now
    showTutorial(context);
  }

  // void updateBool(targetName) async {
  //   await localStorage.setBoolData(name: "$targetName", data: true);
  // }

  void showTutorial(context) async {
    try {
      print(
          'callimg tour ${await localStorage.getBoolData(name: 'completedTour')}');
      // call appTour when user has not completed tour.
      if (await localStorage.getBoolData(name: 'completedTour') != true) {
        print(
            'callimg tour2 ${await localStorage.getBoolData(name: 'completedTour')}');
        TutorialCoachMark(
          context,
          targets: targets, // List<TargetFocus>
          colorShadow: CustomColors.PrimaryColor, // DEFAULT Colors.black

          onClickTarget: (target) {
            print(target);
            // mark specific target as read.
            // updateBool(target.identify);
          },
          onClickOverlay: (target) {
            print(target);

            // updateBool(target.identify);
          },
          onSkip: () async {
            print("skip");
            await localStorage.setBoolData(name: "completedTour", data: true);
          },
          onFinish: () async {
            print("finish");
            await localStorage.setBoolData(name: "completedTour", data: true);
          },
        )..show();
        return;
      }
    } catch (e) {
      print('error $e');
      await localStorage.setBoolData(name: "completedTour", data: true);
    }
  }
}
