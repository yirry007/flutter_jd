import 'package:flutter/material.dart';
import 'package:flutter_jd/pages/Cart/CartItem.dart';
import 'package:flutter_jd/services/ScreenAdapter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_jd/provider/Cart.dart';

class CartPage extends StatefulWidget {
  CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool _isEdit = false;

  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('购物车'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.launch),
            onPressed: (){
              setState(() {
                _isEdit = !_isEdit;
              });
            },
          ),
        ],
      ),
      body: cartProvider.cartList.length > 0
      ?Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              Column(
                children: cartProvider.cartList.map((value){
                  return CartItem(value);
                }).toList(),
              ),
              SizedBox(height: ScreenAdapter.height(100)),
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
                          value: cartProvider.isCheckedAll,
                          activeColor: Colors.amber,
                          onChanged: (val){
                            cartProvider.checkAll(val);
                          },
                        ),
                      ),
                      Text('全选'),
                      SizedBox(width: 20),
                      _isEdit == false ? Text('合计： ') : Text(''),
                      _isEdit == false
                      ?Text('${cartProvider.allPrice}', style: TextStyle(
                        fontSize: 20,
                        color: Colors.red,
                      ))
                      :Text(''),
                    ],
                  ),
                  
                  !_isEdit
                  ? ElevatedButton(
                    child: Text('结算', style: TextStyle(
                      color: Colors.white,
                    )),
                    onPressed: (){},
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                    ),
                  )
                  : ElevatedButton(
                    child: Text('删除', style: TextStyle(
                      color: Colors.white,
                    )),
                    onPressed: (){
                      cartProvider.removeItem();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      )
      :Center(
        child: Text('购物车空空的...'),
      ),
    );
  }
}