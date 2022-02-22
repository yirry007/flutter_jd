import 'dart:convert';
import 'Storage.dart';

class CartServices{
  static addCart(item) async {
    Map _item = CartServices.formatCartData(item);
    
    String? cartListData = await Storage.getString('cartList');

    if (cartListData != null) {
      List cartList = json.decode(cartListData);
      bool hasData = cartList.any((val){
        return val['_id'] == _item['_id'] && val['selectedAttr'] == _item['selectedAttr'];
      });

      if (hasData) {
        for (int i=0;i<cartList.length;i++) {
          if (cartList[i]['_id'] == _item['_id'] && cartList[i]['selectedAttr'] == _item['selectedAttr']) {
            cartList[i]['count'] += _item['count'];
          }
        }
      } else {
        cartList.add(_item);
      }
      await Storage.setString('cartList', json.encode(cartList));
    } else {
      List tempList = [];
      tempList.add(_item);
      await Storage.setString('cartList', json.encode(tempList));
    }
  }

  //过滤数据
  static formatCartData(item){
    final Map data = new Map<String, dynamic>();
    data['_id'] = item.sId;
    data['title'] = item.title;
    data['price'] = item.price is int || item.price is double ? item.price : double.parse(item.price);
    data['selectedAttr'] = item.selectedAttr;
    data['count'] = item.count;
    data['pic'] = item.pic;
    data['checked'] = true;//是否选中

    return data;
  }
}