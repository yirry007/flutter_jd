import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_jd/services/Storage.dart';

class CheckOut with ChangeNotifier{
  List _checkOutListData = [];
  List get checkOutList => _checkOutListData;

  changeCheckOutListData(data){
    _checkOutListData = data;
    notifyListeners();
  }
}