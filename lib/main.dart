import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:sabiwork/common/loader.dart';
import 'package:sabiwork/common/route_constants.dart';
import 'package:sabiwork/common/router.dart' as router;
import 'package:sabiwork/helpers/customColors.dart';
import 'package:sabiwork/services/getStates.dart';

void main() {
  runApp(MyApp());
}

Map<int, Color> color = {
  50: Color.fromRGBO(3, 26, 110, .1),
  100: Color.fromRGBO(3, 26, 110, .2),
  200: Color.fromRGBO(3, 26, 110, .3),
  300: Color.fromRGBO(3, 26, 110, .4),
  400: Color.fromRGBO(3, 26, 110, .5),
  500: Color.fromRGBO(3, 26, 110, .6),
  600: Color.fromRGBO(3, 26, 110, .7),
  700: Color.fromRGBO(3, 26, 110, .8),
  800: Color.fromRGBO(3, 26, 110, .9),
  900: Color.fromRGBO(3, 26, 110, 1),
};

MaterialColor colorCustom = MaterialColor(0xFF031A6E, color);

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void initState() {
    initFlutterLocalNotification();

    super.initState();
  }

  initFlutterLocalNotification() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('sabiwork');
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
            // onDidReceiveLocalNotification: onDidReceiveLocalNotification
            );
    final MacOSInitializationSettings initializationSettingsMacOS =
        MacOSInitializationSettings();
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            macOS: initializationSettingsMacOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_important_channel4', // id
      'High Importance Notifications4', // title

      importance: Importance.max,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

//  init local notification before listening to message
    FirebaseMessaging.onMessage.listen((RemoteMessage event) async {
      print("message recieved 2");

      callNotifification(event, channel);
      print("message recieved");
      print(event.notification!.body);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('Message clicked!');
    });
  }

  void selectNotification(String? payload) {}

//  void onDidReceiveLocalNotification(String? payload) {}

  callNotifification(message, channel) async {
    print('in here');
    try {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      // print('small icon  ${android.smallIcon}');
      // If `onMessage` is triggered with a notification, construct our own
      // local notification to show to users using the created channel.
      print('in here ${notification.body}');
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id, channel.name,
              channelDescription: 'your channel description',
              priority: Priority.high,
              color: CustomColors.PrimaryColor,
              ticker: 'ticker',
              // sound: RawResourceAndroidNotificationSound('evisit_tone'),
              playSound: true,

              icon: android.smallIcon,
              // other properties...
            ),
          ));
    } catch (e) {
      print('error calling notification $e');
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Controller c = Get.put(Controller());
    return Obx(() {
      bool _isLoading = c.isLoading.toString() == 'true' ? true : false;
      return Directionality(
          textDirection: TextDirection.ltr,
          child: LoadingOverlay(
              isLoading: _isLoading,
              child: GetMaterialApp(
                title: 'SabiWork',
                theme: ThemeData(
                    primarySwatch: colorCustom,
                    visualDensity: VisualDensity.adaptivePlatformDensity,
                    primaryColor: CustomColors.PrimaryColor,
                    backgroundColor: Colors.transparent,
                    fontFamily: "Jost"),
                onGenerateRoute: router.generateRoute,
                initialRoute: SplashRoute,
                debugShowCheckedModeBanner: false,
                // builder: (context, child) {
                //   return ScrollConfiguration(
                //     behavior: MyBehavior(),
                //     child: child,
                //   );
                // },
              )));
    });
  }
}
