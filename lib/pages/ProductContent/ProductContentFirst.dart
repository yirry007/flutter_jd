import 'package:flutter/material.dart';
import 'package:flutter_jd/services/ScreenAdapter.dart';

class ProductContentFirst extends StatefulWidget {
  ProductContentFirst({Key? key}) : super(key: key);

  @override
  State<ProductContentFirst> createState() => _ProductContentFirstState();
}

class _ProductContentFirstState extends State<ProductContentFirst> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 16/9,
            child: Image.network('https://www.itying.com/images/flutter/p1.jpg', fit: BoxFit.cover),
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Text('茵曼2017冬装新款棒球罗纹领落肩袖丝绒保暖棉衣外套', style: TextStyle(
              color: Colors.black87,
              fontSize: ScreenAdapter.size(36),
            )),
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Text('茵曼2017冬装新款棒球罗纹领落肩袖丝绒保暖棉衣外套', style: TextStyle(
              color: Colors.black54,
              fontSize: ScreenAdapter.size(28),
            )),
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text('特价:'),
                    Text('￥28', style: TextStyle(
                      color: Colors.red,
                      fontSize: ScreenAdapter.size(48),
                    )),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text('原价:'),
                    Text('￥28',style: TextStyle(
                      color: Colors.black38,
                      fontSize: ScreenAdapter.size(28),
                      decoration: TextDecoration.lineThrough,
                    )),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Container(
            height: ScreenAdapter.height(80),
            child: Row(
              children: <Widget>[
                Text('已选', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(width: 10),
                Text('115, 黑色, XL, 1件'),
              ],
            ),
          ),
          Divider(),
          Container(
            height: ScreenAdapter.height(80),
            child: Row(
              children: <Widget>[
                Text('运费', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(width: 10),
                Text('免运费'),
              ],
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}