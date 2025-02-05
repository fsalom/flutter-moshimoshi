import 'package:flutter/material.dart';

class Constants {
  static GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();
  static String get baseUrl => "https://dashboard-staging.rudo.es";
  static Duration get timeOut => const Duration(seconds: 10);
}
