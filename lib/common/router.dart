import 'package:flutter/material.dart';
import 'package:sabiwork/common/route_constants.dart';
import 'package:sabiwork/screens/auth/complete-registration.dart';
import 'package:sabiwork/screens/auth/forgot-password.dart';
import 'package:sabiwork/screens/auth/login.dart';
import 'package:sabiwork/screens/auth/register.dart';
import 'package:sabiwork/screens/auth/splash.dart';
import 'package:sabiwork/screens/home/tabs.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginRoute:
      return MaterialPageRoute(builder: (context) => Login());
    case RegisterRoute:
      return MaterialPageRoute(builder: (context) => Register());

    case CompleteRegistrationRoute:
      return MaterialPageRoute(builder: (context) => CompleteRegistration());

    case ForgotPasswordRoute:
      return MaterialPageRoute(builder: (context) => ForgotPassword());

    case TabsRoute:
      return MaterialPageRoute(builder: (context) => Tabs());

    case SplashRoute:
      return MaterialPageRoute(builder: (context) => Splash());

    default:
      return MaterialPageRoute(builder: (context) => Login());
  }
}
