import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jd/config/Api.dart';
import 'package:flutter_jd/model/OrderModel.dart';
import 'package:flutter_jd/services/ScreenAdapter.dart';
import 'package:flutter_jd/services/SignServices.dart';
import 'package:flutter_jd/services/UserServices.dart';

class OrderInfoPage extends StatefulWidget {
  Map? arguments;
  OrderInfoPage({Key? key, this.arguments}) : super(key: key);

  @override
  State<OrderInfoPage> createState() => _OrderInfoPageState();
}

class _OrderInfoPageState extends State<OrderInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('订单详情'),
      ),
      body: Container(//滚动页面外层加Container就好控制一些
        child: ListView(
          children: <Widget>[
            Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 10),
                  ListTile(
                    leading: Icon(Icons.add_location),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('飘谋 15944301200'),
                        SizedBox(height: 10),
                        Text('延吉市秋云雅苑16号楼1单元502'),
                      ],
                    )
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            SizedBox(height: 16),
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        width: ScreenAdapter.width(120),
                        child: Image.network('https://www.itying.com/images/flutter/list2.jpg', fit: BoxFit.cover),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('6小时学会TypeScript入门实战视频教程', maxLines: 2, style: TextStyle(
                                fontSize: ScreenAdapter.size(24),
                              )),
                              Text('白色 175', style: TextStyle(
                                fontSize: ScreenAdapter.size(18),
                                color: Colors.black54,
                              )),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('￥345.0', style: TextStyle(
                                    color: Colors.red,
                                  )),
                                  Text('x1'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width: ScreenAdapter.width(120),
                        child: Image.network('https://www.itying.com/images/flutter/list2.jpg', fit: BoxFit.cover),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('6小时学会TypeScript入门实战视频教程', maxLines: 2, style: TextStyle(
                                fontSize: ScreenAdapter.size(24),
                              )),
                              Text('白色 175', style: TextStyle(
                                fontSize: ScreenAdapter.size(18),
                                color: Colors.black54,
                              )),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('￥345.0', style: TextStyle(
                                    color: Colors.red,
                                  )),
                                  Text('x1'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width: ScreenAdapter.width(120),
                        child: Image.network('https://www.itying.com/images/flutter/list2.jpg', fit: BoxFit.cover),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('6小时学会TypeScript入门实战视频教程', maxLines: 2, style: TextStyle(
                                fontSize: ScreenAdapter.size(24),
                              )),
                              Text('白色 175', style: TextStyle(
                                fontSize: ScreenAdapter.size(18),
                                color: Colors.black54,
                              )),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('￥345.0', style: TextStyle(
                                    color: Colors.red,
                                  )),
                                  Text('x1'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Row(
                      children: <Widget>[
                        Text('订单编号: ', style: TextStyle(
                          fontWeight: FontWeight.bold
                        )),
                        Text('1234567890'),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Row(
                      children: <Widget>[
                        Text('下单日期: ', style: TextStyle(
                          fontWeight: FontWeight.bold
                        )),
                        Text('2019-12-09'),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Row(
                      children: <Widget>[
                        Text('支付方式: ', style: TextStyle(
                          fontWeight: FontWeight.bold
                        )),
                        Text('微信支付'),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Row(
                      children: <Widget>[
                        Text('配送方式: ', style: TextStyle(
                          fontWeight: FontWeight.bold
                        )),
                        Text('顺丰'),
                      ],
                    ),
                  ),
                ]
              ),
            ),
            SizedBox(height: 16),
            Container(
              color: Colors.white,
              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Row(
                      children: <Widget>[
                        Text('总金额: ', style: TextStyle(
                          fontWeight: FontWeight.bold
                        )),
                        Text('￥414', style: TextStyle(
                          color: Colors.red,
                        )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}