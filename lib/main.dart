import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sabiwork/common/loader.dart';
import 'package:sabiwork/common/route_constants.dart';
import 'package:sabiwork/common/router.dart' as router;
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

class MyApp extends StatelessWidget {
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
                    primaryColor: Color(0xFF4F1699),
                    backgroundColor: Colors.transparent,
                    fontFamily: "Jost"),
                onGenerateRoute: router.generateRoute,
                initialRoute: LoginRoute,
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
