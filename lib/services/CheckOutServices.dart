import 'dart:convert';

import 'package:flutter_jd/services/Storage.dart';

class CheckOutServices{
  //计算总价
  static getAllPrice(checkoutListData){
    double tmpAllPrice = 0;
    for (int i=0;i<checkoutListData.length;i++) {
      if (checkoutListData[i]['checked']) {
        tmpAllPrice += checkoutListData[i]['price'] * checkoutListData[i]['count'];
      }
    }

    return tmpAllPrice.toStringAsFixed(1);
  }

  ///删除购物车数据
  ///如果直接删除 _cartList 的执行过程中，会改变列表索引值，导致不能准确删除
  ///所以把没有被勾选的重新组合成列表，再保存起来
  static removeSelectedCartItem() async{
    List _cartList = [];

    String? cartListData = await Storage.getString('cartList');

    if (cartListData != null) {
      _cartList = json.decode(cartListData);
    }

    List tmpList = [];

    for (int i=0;i<_cartList.length;i++) {
      if (!_cartList[i]['checked']) {
        tmpList.add(_cartList[i]);
      }
    }

    _cartList = tmpList;

    Storage.setString('cartList', json.encode(_cartList));
  }
}