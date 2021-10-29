import 'package:carbon_footprint_tracker/ui/LoginPage.dart';
import 'package:carbon_footprint_tracker/ui/RedeemPage.dart';
import 'package:carbon_footprint_tracker/ui/SignUpPage.dart';
import 'package:carbon_footprint_tracker/ui/ViewPager.dart';
import 'package:flutter/material.dart';

import 'Routes.dart';

class CustomRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.LOGIN:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case Routes.SIGNUP:
        return MaterialPageRoute(builder: (_) => SignUpPage());
      case Routes.CARBON_EMISSION_PAGE:
        return MaterialPageRoute(builder: (_) => ViewPager());
      case Routes.REEDEMING_PAGE:
        return MaterialPageRoute(builder: (_) => RedeemPage());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                  child: Text('No route defined for ${settings.name}')),
            ));
    }
  }
}