import 'package:flutter/material.dart';
import 'package:flutter_jd/pages/Cart/CartNum.dart';
import 'package:flutter_jd/services/ScreenAdapter.dart';

class CartItem extends StatefulWidget {
  CartItem({Key? key}) : super(key: key);

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
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
              value: true,
              onChanged: (val){},
              activeColor: Colors.amber,
            ),
          ),Container(
            width: ScreenAdapter.width(160),
            child: Image.network('https://www.itying.com/images/flutter/list2.jpg', fit: BoxFit.cover),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('【二手95新】Apple MacBook Air Pro 二手苹果笔记本电脑 办公 游戏 设计 剪辑 12款13.3英寸231-4G/128G', maxLines: 2,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('￥20', style: TextStyle(
                        color: Colors.red,
                      )),
                      CartNum(),
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