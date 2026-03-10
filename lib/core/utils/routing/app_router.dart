import 'package:flutter/material.dart';
import 'package:online_ezzy/Features/Onboarding/Onborading_view.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case '/splash':
      //   return MaterialPageRoute(builder: (_) => const OnBoardingPageView());
      case '/onboarding':
        return MaterialPageRoute(builder: (_) => OnboradingView());
      default:
        return MaterialPageRoute(
          builder:
              (_) => Scaffold(
                body: Center(
                  child: Text('No route defined for ${settings.name}'),
                ),
              ),
        );
    }
  }
}