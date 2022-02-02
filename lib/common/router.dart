import 'package:flutter/material.dart';
import 'package:sabiwork/common/route_constants.dart';
import 'package:sabiwork/screens/auth/complete-registration.dart';
import 'package:sabiwork/screens/auth/forgot-password.dart';
import 'package:sabiwork/screens/auth/intro.dart';
import 'package:sabiwork/screens/auth/login.dart';
import 'package:sabiwork/screens/auth/my-profile.dart';
import 'package:sabiwork/screens/auth/register.dart';
import 'package:sabiwork/screens/auth/splash.dart';
import 'package:sabiwork/screens/auth/user-types.dart';
import 'package:sabiwork/screens/home/tabs.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  // final arguments = settings.arguments as Map;
  Map arguments = (settings.arguments ?? {}) as Map;

  switch (settings.name) {
    case IntroRoute:
      return MaterialPageRoute(builder: (context) => Intro());
    case LoginRoute:
      return MaterialPageRoute(builder: (context) => Login());
    case RegisterRoute:
      return MaterialPageRoute(
          builder: (context) => Register(userType: arguments['userType']));

    case CompleteRegistrationRoute:
      return MaterialPageRoute(builder: (context) => CompleteRegistration());

    case ForgotPasswordRoute:
      return MaterialPageRoute(builder: (context) => ForgotPassword());

    case TabsRoute:
      return MaterialPageRoute(builder: (context) => Tabs());

    case SplashRoute:
      return MaterialPageRoute(builder: (context) => Splash());

    case UserTypesRoute:
      return MaterialPageRoute(builder: (context) => UserTypes());

    case MyProfileRoute:
      return MaterialPageRoute(builder: (context) => MyProfile());

    default:
      return MaterialPageRoute(builder: (context) => Login());
  }
}
