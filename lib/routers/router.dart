import 'package:flutter/material.dart';
import 'package:flutter_jd/pages/Address/AddressAdd.dart';
import 'package:flutter_jd/pages/Address/AddressEdit.dart';
import 'package:flutter_jd/pages/Address/AddressList.dart';
import 'package:flutter_jd/pages/CheckOut.dart';
import 'package:flutter_jd/pages/Login.dart';
import 'package:flutter_jd/pages/RegisterFirst.dart';
import 'package:flutter_jd/pages/RegisterSecond.dart';
import 'package:flutter_jd/pages/RegisterThird.dart';
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
  '/login': (context)=>LoginPage(),
  '/register_first': (context)=>RegisterFirstPage(),
  '/register_second': (context, {arguments})=>RegisterSecondPage(arguments: arguments),
  '/register_third': (context, {arguments})=>RegisterThirdPage(arguments: arguments),
  '/checkout': (context)=>CheckOutPage(),
  '/address_list': (context)=>AddressListPage(),
  '/address_add': (context)=>AddressAddPage(),
  '/address_edit': (context, {arguments})=>AddressEditPage(arguments: arguments),
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