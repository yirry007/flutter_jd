import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_jd/services/Storage.dart';

class Cart with ChangeNotifier{
  List _cartList = [];//购物车数据
  bool _isCheckedAll = false;//全选

  double _allPrice = 0;//总价

  List get cartList => _cartList;
  bool get isCheckedAll => _isCheckedAll;
  double get allPrice => _allPrice;

  Cart(){
    init();
  }

  //初始化的时候获取购物车的数据
  init() async {
    String? cartListData = await Storage.getString('cartList');

    if (cartListData != null) {
      _cartList = json.decode(cartListData);
    }

    //获取全选的状态
    _isCheckedAll = isCheckAll();

    computeAllPrice();

    notifyListeners();
  }

  updateCartList(){
    init();
  }

  itemCountChange(){
    computeAllPrice();
    Storage.setString('cartList', json.encode(_cartList));

    notifyListeners();
  }

  checkAll(value){
    for (int i=0;i<_cartList.length;i++) {
      _cartList[i]['checked'] = value;
    }

    _isCheckedAll = value;
    computeAllPrice();
    Storage.setString('cartList', json.encode(_cartList));

    notifyListeners();
  }

  //判断是否全选
  bool isCheckAll(){
    if (_cartList.length == 0) return false;

    for (int i=0;i<_cartList.length;i++) {
      if (!_cartList[i]['checked']) {
        return false;
      }
    }
    return true;
  }

  //监听每一项的选中事件
  itemChange(){
    _isCheckedAll = isCheckAll();
    computeAllPrice();
    Storage.setString('cartList', json.encode(_cartList));

    notifyListeners();
  }

  //计算总价
  computeAllPrice(){
    double tmpAllPrice = 0;
    for (int i=0;i<_cartList.length;i++) {
      if (_cartList[i]['checked']) {
        tmpAllPrice += _cartList[i]['price'] * _cartList[i]['count'];
      }
    }

    _allPrice = tmpAllPrice;
    notifyListeners();
  }

  ///删除购物车数据
  ///如果直接删除 _cartList 的执行过程中，会改变列表索引值，导致不能准确删除
  ///所以把没有被勾选的重新组合成列表，再保存起来
  removeItem(){
    List tmpList = [];

    for (int i=0;i<_cartList.length;i++) {
      if (!_cartList[i]['checked']) {
        tmpList.add(_cartList[i]);
      }
    }

    _cartList = tmpList;

    //计算总价
    computeAllPrice();

    Storage.setString('cartList', json.encode(_cartList));

    notifyListeners();
  }
}