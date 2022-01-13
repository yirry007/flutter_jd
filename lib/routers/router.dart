import 'package:flutter/material.dart';
import 'package:flutter_jd/pages/Search.dart';
import 'package:flutter_jd/pages/tabs/Tabs.dart';

final routes = {
  '/': (context)=>Tabs(),
  '/search': (context)=>SearchPage(),
};

// ignore: prefer_function_declarations_over_variables
var onGenerateRoute = (RouteSettings settings) {
  final String? name = settings.name;
  final Function pageContentBuilder = routes[name] as Function;
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
        builder: (context)=>pageContentBuilder(context, arguments: settings.arguments)
      );
      return route;
    } else {
      final Route route = MaterialPageRoute(
        builder: (context) =>pageContentBuilder(context)
      );
      return route;
    }
  }
};