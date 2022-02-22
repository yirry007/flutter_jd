import 'package:flutter/material.dart';
import 'package:flutter_jd/pages/Search.dart';
import 'package:flutter_jd/pages/tabs/Tabs.dart';
import 'package:flutter_jd/pages/ProductList.dart';
import 'package:flutter_jd/pages/ProductContent.dart';
import 'package:flutter_jd/pages/tabs/Cart.dart';

final routes = {
  '/': (context)=>Tabs(),
  '/search': (context)=>SearchPage(),
  '/cart': (context)=>CartPage(),
  '/productList': (context, {arguments})=>ProductListPage(arguments: arguments),
  '/productContent': (context, {arguments})=>ProductContentPage(arguments: arguments),
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