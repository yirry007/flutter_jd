import 'package:flutter/material.dart';
import 'package:flutter_jd/services/ScreenAdapter.dart';

class CheckOutPage extends StatefulWidget {
  CheckOutPage({Key? key}) : super(key: key);

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  Widget _checkOutItem(){
    return Row(
      
      children: <Widget>[
        Container(
          width: ScreenAdapter.width(160),
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
                Text('Flutter 仿京东商城项目实战视频教程', maxLines: 2, style: TextStyle(
                  fontSize: ScreenAdapter.size(24),
                )),
                Text('白色,175', style: TextStyle(
                  fontSize: ScreenAdapter.size(18),
                  color: Colors.black54,
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('￥111', style: TextStyle(
                      color: Colors.red,
                    )),
                    Text('x2'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('结算'),
      ),
      body: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    // ListTile(
                    //   leading: Icon(Icons.add_location),
                    //   title: Center(
                    //     child: Text('请添加收货地址'),
                    //   ),
                    //   trailing: Icon(Icons.navigate_next),
                    // ),

                    SizedBox(height: 10),
                    ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('张三 15023948023'),
                          SizedBox(height: 10),
                          Text('吉林省延吉市北山街xxxxxxxxxx'),
                        ],
                      ),
                      trailing: Icon(Icons.navigate_next),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),

              SizedBox(height: 20),
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(ScreenAdapter.width(20)),
                child: Column(
                  children: <Widget>[
                    _checkOutItem(),
                    Divider(),
                    _checkOutItem(),
                    Divider(),
                    _checkOutItem(),
                    Divider(),
                    _checkOutItem(),
                    Divider(),
                  ],
                ),
              ),

              SizedBox(height: 20),
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(ScreenAdapter.width(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('商品总金额: ￥100'),
                    Divider(),
                    Text('立减: ￥5'),
                    Divider(),
                    Text('运费: 0'),
                  ],
                )
              ),
            ],
          ),

          Positioned(
            bottom: 0,
            width: ScreenAdapter.getScreenWidth(),
            height: ScreenAdapter.height(100),
            child: Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              width: ScreenAdapter.getScreenWidth(),
              height: ScreenAdapter.height(100),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(
                    width: 1,
                    color: Colors.black12,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('总价: ￥140', style: TextStyle(
                    color: Colors.red,
                  )),
                  ElevatedButton(
                    child: Text('立即下单', style: TextStyle(
                      color: Colors.white,
                    )),
                    onPressed: (){},
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}