import 'package:flutter/material.dart';
import 'package:sabiwork/common/route_constants.dart';
import 'package:sabiwork/screens/auth/complete-registration.dart';
import 'package:sabiwork/screens/auth/login.dart';
import 'package:sabiwork/screens/auth/register.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginRoute:
      return MaterialPageRoute(builder: (context) => Login());
    case RegisterRoute:
      return MaterialPageRoute(builder: (context) => Register());

    case CompleteRegistrationRoute:
      return MaterialPageRoute(builder: (context) => CompleteRegistration());

    default:
      return MaterialPageRoute(builder: (context) => Login());
  }
}
