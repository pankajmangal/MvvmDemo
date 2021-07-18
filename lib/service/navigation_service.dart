import 'package:flutter/material.dart';

class NavigationService{
  static final NavigationService _instance = NavigationService._internal();

  factory NavigationService() {
    return _instance;
  }

  NavigationService._internal();

  GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateToReplacement(String _rn){
    return navigationKey.currentState!.pushReplacementNamed(_rn);
  }

  Future<dynamic> navigateToRoute(String _rn){
    return navigationKey.currentState!.pushNamed(_rn);
  }

  Future<dynamic> navigateToRouteRemoveUntil(String _rn){
    return navigationKey.currentState!.pushNamedAndRemoveUntil(_rn, (route) => false);
  }

  Future<dynamic> navigateToRouteWithPop(String _rn){
    return navigationKey.currentState!.popAndPushNamed(_rn);
  }

  goBack(){
    return navigationKey.currentState!.pop();
  }
}