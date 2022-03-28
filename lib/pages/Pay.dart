import 'package:flutter/material.dart';
import 'package:flutter_jd/services/ScreenAdapter.dart';
import 'package:flutter_jd/widget/MainButton.dart';

class PayPage extends StatefulWidget {
  PayPage({Key? key}) : super(key: key);

  @override
  State<PayPage> createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {
  List payList = [
    {
      "title": "支付宝支付",
      "checked": true,
      "image": "https://www.itying.com/themes/itying/images/alipay.png",
    },
    {
      "title": "微信支付",
      "checked": false,
      "image": "https://www.itying.com/themes/itying/images/weixin.png",
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('去支付'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 400,
            padding: EdgeInsets.all(20),
            child: ListView.builder(
              itemCount: payList.length,
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    ListTile(
                      leading: Image.network('${payList[index]['image']}'),
                      title: Text('${payList[index]['title']}'),
                      trailing: payList[index]['checked'] ? Icon(Icons.check) : null,
                      onTap: (){
                        setState(() {
                          for (int i=0;i<payList.length;i++) {
                            payList[i]['checked'] = false;
                          }
                          payList[index]['checked'] = true;
                        });
                      },
                    ),
                    Divider(),
                  ],
                );
              },
            ),
          ),
          MainButton(
            text: '立即支付',
            color: Colors.amber,
            onTap: (){},
          ),
        ],
      ),
    );
  }
}