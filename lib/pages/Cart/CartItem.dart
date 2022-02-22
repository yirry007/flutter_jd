import 'package:flutter/material.dart';
import 'package:flutter_jd/config/Api.dart';
import 'package:flutter_jd/pages/Cart/CartNum.dart';
import 'package:flutter_jd/services/ScreenAdapter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_jd/provider/Cart.dart';

class CartItem extends StatefulWidget {
  Map? _itemData;
  CartItem(this._itemData, {Key? key}) : super(key: key);

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  Map? _itemData;

  @override
  Widget build(BuildContext context) {
    _itemData = widget._itemData;//provider本身只重新build，不能initState，因此_itemData 必须设置在build里才能获取实时数据
    
    String imagePath = _itemData!['pic'];
    String path = Api.Host + imagePath.replaceAll('\\', '/');
    var cartProvider = Provider.of<Cart>(context);
    return Container(
      height: ScreenAdapter.height(200),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Colors.black12,
          ),
        ),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: ScreenAdapter.width(60),
            child: Checkbox(
              value: _itemData!['checked'],
              onChanged: (val){
                _itemData!['checked'] = !_itemData!['checked'];
                cartProvider.itemChange();
              },
              activeColor: Colors.amber,
            ),
          ),
          Container(
            width: ScreenAdapter.width(160),
            child: Image.network('${path}', fit: BoxFit.cover),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('${_itemData!['title']}', maxLines: 2, style: TextStyle(
                    fontSize: ScreenAdapter.size(24),
                  )),
                  Text('${_itemData!['selectedAttr']}', style: TextStyle(
                    fontSize: ScreenAdapter.size(18),
                    color: Colors.black54,
                  )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('￥${_itemData!['price']}', style: TextStyle(
                        color: Colors.red,
                      )),
                      CartNum(_itemData),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}