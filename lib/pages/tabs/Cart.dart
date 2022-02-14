import 'package:flutter/material.dart';
import 'package:flutter_jd/pages/Cart/CartItem.dart';
import 'package:flutter_jd/services/ScreenAdapter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_jd/provider/Counter.dart';
import 'package:flutter_jd/provider/Cart.dart';

class CartPage extends StatefulWidget {
  CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('购物车'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.launch),
            onPressed: (){},
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              CartItem(),
              CartItem(),
              CartItem(),
              CartItem(),
            ],
          ),
          Positioned(
            bottom: 0,
            width: ScreenAdapter.getScreenWidth(),
            height: ScreenAdapter.height(78),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(
                    width: 1,
                    color: Colors.black12,
                  ),
                ),
              ),
              width: ScreenAdapter.getScreenWidth(),
              height: ScreenAdapter.height(78),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        width: ScreenAdapter.width(60),
                        child: Checkbox(
                          value: true,
                          activeColor: Colors.amber,
                          onChanged: (val){},
                        ),
                      ),
                      Text('全选'),
                    ],
                  ),
                  
                  ElevatedButton(
                    child: Text('结算', style: TextStyle(
                      color: Colors.white,
                    )),
                    onPressed: (){},
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                    ),
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