import 'package:flutter/material.dart';
import 'package:mvvm_demo/ui/auth/login_page.dart';

import 'route_constants.dart';

class RouteGenerator{
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case splashLaunch:
      //   return MaterialPageRoute(builder: (_) => SplashPage());
      case login:
        return MaterialPageRoute(builder: (_) => LoginPage());
      // case register:
      //   var prevContext = settings.arguments as BuildContext;
      //   return MaterialPageRoute(builder: (_) => RegisterPage());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                  child: Text('No route defined for ${settings.name}')),
            ));
    }
  }
}