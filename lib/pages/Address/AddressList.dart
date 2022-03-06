import 'package:flutter/material.dart';
import 'package:flutter_jd/services/ScreenAdapter.dart';

class AddressListPage extends StatefulWidget {
  AddressListPage({Key? key}) : super(key: key);

  @override
  State<AddressListPage> createState() => _AddressListPageState();
}

class _AddressListPageState extends State<AddressListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('收货地址列表'),
      ),
      body: Container(
        child: Stack(
          children: <Widget>[ 
            ListView(
              children: <Widget>[
                SizedBox(height: 20),
                ListTile(
                  leading: Icon(Icons.check, color: Colors.amber),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('张三 15023948023'),
                      SizedBox(height: 10),
                      Text('吉林省延吉市北山街xxxxxxxxxx'),
                    ],
                  ),
                  trailing: Icon(Icons.edit, color: Colors.blue),
                ),
                Divider(height: 20),
                ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('张三 15023948023'),
                      SizedBox(height: 10),
                      Text('吉林省延吉市北山街xxxxxxxxxx'),
                    ],
                  ),
                  trailing: Icon(Icons.edit, color: Colors.blue),
                ),
                Divider(height: 20),
                ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('张三 15023948023'),
                      SizedBox(height: 10),
                      Text('吉林省延吉市北山街xxxxxxxxxx'),
                    ],
                  ),
                  trailing: Icon(Icons.edit, color: Colors.blue),
                ),
                Divider(height: 20),
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
                color: Colors.amber,
                child: InkWell(
                  onTap:(){
                    Navigator.pushNamed(context, '/address_add');
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.add),
                      Text('新增收货地址'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}