import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jd/config/Api.dart';
import 'package:flutter_jd/model/OrderModel.dart';
import 'package:flutter_jd/services/ScreenAdapter.dart';
import 'package:flutter_jd/services/SignServices.dart';
import 'package:flutter_jd/services/UserServices.dart';

class OrderPage extends StatefulWidget {
  OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  List<Result>? _orderList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getOrderData();
  }

  _getOrderData() async{
    List userinfo = await UserServices.getUserInfo();

    Map tempJson = {
      "uid": userinfo[0]['_id'],
      "salt": userinfo[0]['salt'],
    };

    String sign = SignService.getSign(tempJson);
    String api = '${Api.orderList}?uid=${userinfo[0]['_id']}&sign=${sign}';
    var response = await Dio().get(api);

    setState(() {
      OrderModel _orderModel = OrderModel.fromJson(response.data);
      _orderList = _orderModel.result;
    });
  }

  //自定义商品列表组件
  List<Widget> orderItemWidget(orderItems){
    List<Widget> tmpList = [];

    for (int i=0;i<orderItems.length;i++) {
      tmpList.add(
        Column(
          children: <Widget>[
            ListTile(//对于图片的大小有要求的布局不应该用ListTile组件，因为这个无法修改leading中的图片高度
              leading: Container(
                width: ScreenAdapter.width(80),
                height: ScreenAdapter.height(80),
                child: Image.network('${orderItems[i].productImg}', fit: BoxFit.cover),
              ),
              title: Text('${orderItems[i].productTitle}'),
              trailing: Text('x ${orderItems[i].productCount}'),
            ),
            SizedBox(height: 10),
          ],
        )
      );
    }

    return tmpList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的订单'),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: ScreenAdapter.height(80)),
            padding: EdgeInsets.all(ScreenAdapter.width(16)),
            child: ListView(
              children: _orderList!.map((value){
                return Card(
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: InkWell(
                          onTap: (){
                            Navigator.pushNamed(context, '/order_info', arguments: {
                              "sId": value.sId,
                            });
                          },
                          child: Text('订单编号: ${value.sId}', style: TextStyle(
                            color: Colors.black54,
                          )),
                        ),
                      ),
                      Divider(),
                      Column(
                        children: orderItemWidget(value.orderItem),
                      ),
                      ListTile(
                        leading: Text('合计: ￥${value.allPrice}'),//leading无法修改图片大小
                        trailing: TextButton(
                          child: Text('申请售后'),
                          onPressed: (){},
                          style: TextButton.styleFrom(
                            primary: Colors.black38,
                            textStyle: TextStyle(
                              color: Colors.black38,
                            ),
                            backgroundColor: Colors.black12,
                          )
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          Positioned(
            top: 0,
            width: ScreenAdapter.getScreenWidth(),
            height: ScreenAdapter.height(76),
            child: Container(
              width: ScreenAdapter.getScreenWidth(),
              height: ScreenAdapter.height(76),
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text('全部', textAlign: TextAlign.center),
                  ),
                  Expanded(
                    child: Text('待付款', textAlign: TextAlign.center),
                  ),
                  Expanded(
                    child: Text('待收款', textAlign: TextAlign.center),
                  ),
                  Expanded(
                    child: Text('已完成', textAlign: TextAlign.center),
                  ),
                  Expanded(
                    child: Text('已取消', textAlign: TextAlign.center),
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