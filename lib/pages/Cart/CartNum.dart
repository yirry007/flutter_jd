import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_jd/provider/Cart.dart';
import 'package:flutter_jd/services/ScreenAdapter.dart';

class CartNum extends StatefulWidget {
  Map? _itemData;
  CartNum(this._itemData, {Key? key}) : super(key: key);

  @override
  State<CartNum> createState() => _CartNumState();
}

class _CartNumState extends State<CartNum> {
  Map? _itemData;
  var cartProvider;

  @override
  Widget build(BuildContext context) {
    _itemData = widget._itemData;//provider本身只重新build，不能initState，因此_itemData 必须设置在build里才能获取实时数据
    cartProvider = Provider.of<Cart>(context);

    return Container(
      width: ScreenAdapter.width(164),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.black12,
        ),
      ),
      child: Row(
        children: <Widget>[
          _leftBtn(),
          _centerArea(),
          _rightBtn(),
        ],
      ),
    );
  }

  //左侧按钮
  Widget _leftBtn(){
    return InkWell(
      onTap: (){
        if (_itemData!['count'] > 1) {
          _itemData!['count']--;
          cartProvider.itemCountChange();
        }
      },
      child: Container(
        alignment: Alignment.center,
        width: ScreenAdapter.width(45),
        height: ScreenAdapter.height(45),
        child: Text('-'),
      ),
    );
  }

  //右侧按钮
  Widget _rightBtn(){
    return InkWell(
      onTap: (){
        _itemData!['count']++;
        cartProvider.itemCountChange();
      },
      child: Container(
        alignment: Alignment.center,
        width: ScreenAdapter.width(45),
        height: ScreenAdapter.height(45),
        child: Text('+'),
      ),
    );
  }

  //中间input框
  //右侧按钮
  Widget _centerArea(){
    return Container(
      alignment: Alignment.center,
      width: ScreenAdapter.width(70),
      height: ScreenAdapter.height(45),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            width: 1,
            color: Colors.black12,
          ),
          right: BorderSide(
            width: 1,
            color: Colors.black12,
          ),
        ),
      ),
      child: Text('${widget._itemData!['count']}'),
    );
  }
}