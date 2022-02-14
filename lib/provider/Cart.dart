import 'package:flutter/material.dart';

class Cart with ChangeNotifier{
  List _cartList = [];

  int get cartNum => _cartList.length;
  List get cartList => _cartList;

  addList(value){
    _cartList.add(value);
    notifyListeners();
  }

  deleteList(value){
    _cartList.remove(value);
    notifyListeners();
  }
}