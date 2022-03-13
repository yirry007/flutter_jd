import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jd/config/Api.dart';
import 'package:flutter_jd/services/EventBus.dart';
import 'package:flutter_jd/services/ScreenAdapter.dart';
import 'package:flutter_jd/services/SignServices.dart';
import 'package:flutter_jd/services/UserServices.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddressListPage extends StatefulWidget {
  AddressListPage({Key? key}) : super(key: key);

  @override
  State<AddressListPage> createState() => _AddressListPageState();
}

class _AddressListPageState extends State<AddressListPage> {
  List addressList = [];
  var actionEventBus;

  @override
  void initState() {
    super.initState();
    
    _getAddressList();

    actionEventBus = eventBus.on<AddressEvent>().listen((event) {
      _getAddressList();
    });
  }

  //监听登录页面销毁事件
  dispose(){
    super.dispose();
    eventBus.fire(CheckOutEvent(str: '默认地址设置成功'));
  }

  //获取收货地址
  _getAddressList() async{
    List userinfo = await UserServices.getUserInfo();

    Map tempJson = {
      "uid": userinfo[0]['_id'],
      "salt": userinfo[0]['salt'],
    };

    String sign = SignService.getSign(tempJson);
    String api = '${Api.addressList}?uid=${userinfo[0]['_id']}&sign=${sign}';
    var response = await Dio().get(api);

    if (response.data['success']){
      setState(() {
        addressList = response.data['result'];
      });
    }
  }

  //修改默认收货地址
  _changeDefaultAddress(id) async{
    List userinfo = await UserServices.getUserInfo();

    Map tempJson = {
      "uid": userinfo[0]['_id'],
      "id": id,
      "salt": userinfo[0]['salt'],
    };

    String sign = SignService.getSign(tempJson);
    String api = Api.changeDefaultAddress;
    var response = await Dio().post(api, data: {
      "uid": userinfo[0]['_id'],
      "id": id,
      "sign": sign,
    });

    if (!response.data['success']){
      Fluttertoast.showToast(
        msg: "${response.data['message']}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
      return;
    }

    Navigator.pop(context);
  }

  //删除收货地址
  _delAddress(id) async{
    List userinfo = await UserServices.getUserInfo();

    Map tempJson = {
      "uid": userinfo[0]['_id'],
      "id": id,
      "salt": userinfo[0]['salt'],
    };

    String sign = SignService.getSign(tempJson);

    String api = Api.deleteAddress;
    var response = await Dio().post(api, data: {
      "uid": userinfo[0]['_id'],
      "id": id,
      "sign": sign,
    });

    if (!response.data['success']) {
      Fluttertoast.showToast(
        msg: "${response.data['message']}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
      return;
    }

    _getAddressList();
  }

  _showAlertDialog(id) async{
    var result = await showDialog(
      barrierDismissible: true,//点击灰色背景时关闭对话框
      context: context,
      builder: (context){
        return AlertDialog(
          title: Text('提示信息！'),
          content: Text('确定要删除吗？'),
          actions: <Widget>[
            TextButton(
              child: Text('取消'),
              onPressed: (){
                Navigator.pop(context, 'Cancel');
              },
            ),
            TextButton(
              child: Text('确定'),
              onPressed: () async{
                _delAddress(id);
                Navigator.pop(context, 'OK');
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('收货地址列表'),
      ),
      body: Container(
        child: Stack(
          children: <Widget>[ 
            ListView.builder(
              itemCount: addressList.length,
              itemBuilder: (context, index){
                return Column(
                  children: <Widget>[
                    SizedBox(height: 20),
                    ListTile(
                      leading: addressList[index]['default_address'] == 1
                      ?Icon(Icons.check, color: Colors.amber)
                      :null,
                      title: InkWell(
                        onTap: (){
                          _changeDefaultAddress(addressList[index]['_id']);
                        },
                        onLongPress: (){
                        _showAlertDialog('${addressList[index]['id']}');
                      },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('${addressList[index]['name']} ${addressList[index]['phone']}'),
                            SizedBox(height: 10),
                            Text('${addressList[index]['address']}'),
                          ],
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: (){
                          Navigator.pushNamed(context, '/address_edit', arguments: {
                            "id": addressList[index]['_id'],
                            "name": addressList[index]['name'],
                            "phone": addressList[index]['phone'],
                            "address": addressList[index]['address'],
                          });
                        },
                        icon: Icon(Icons.edit, color: Colors.blue),
                      ),
                    ),
                    Divider(height: 20),
                  ],
                );
              },

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