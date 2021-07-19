import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mvvm_demo/route/route_constants.dart';
import 'package:mvvm_demo/route/route_generator.dart';
import 'package:mvvm_demo/service/navigation_service.dart';
import 'package:mvvm_demo/utils/color_helper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: kPrimaryColor, //set Status bar color in Android devices.
      statusBarIconBrightness: Brightness.light, //set Status bar icons color in Android devices.
      statusBarBrightness: Brightness.dark) //set Status bar icon color in iOS.
  );
  await Firebase.initializeApp();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError; //Inititalize Firebase Crashlytics here
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mvvm Demo',
      initialRoute: login,//After loading splash screen first screen is Login screen
      onGenerateRoute: RouteGenerator.generateRoute, //Managing routes navigation in RouteGenerator file
      navigatorKey: NavigationService().navigationKey,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
