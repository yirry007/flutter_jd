import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jd/config/Api.dart';
import 'package:flutter_jd/services/EventBus.dart';
import 'package:flutter_jd/services/ScreenAdapter.dart';
import 'package:flutter_jd/services/SignServices.dart';
import 'package:flutter_jd/services/UserServices.dart';
import 'package:flutter_jd/widget/JDText.dart';
import 'package:flutter_jd/widget/MainButton.dart';
import 'package:city_pickers/city_pickers.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddressAddPage extends StatefulWidget {
  AddressAddPage({Key? key}) : super(key: key);

  @override
  State<AddressAddPage> createState() => _AddressAddPageState();
}

class _AddressAddPageState extends State<AddressAddPage> {
  String area = '';
  String name = '';
  String phone = '';
  String address = '';

  //对于地址列表和订单页面的时间广播
  dispose(){
    super.dispose();
    eventBus.fire(AddressEvent(str: '添加数据成功'));
    eventBus.fire(CheckOutEvent(str: '默认地址设置成功'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('新增收货地址'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 20),
            JDText(
              text: '收货人姓名',
              onChange: (value){
                name = value;
              },
            ),
            SizedBox(height: 30),

            JDText(
              text: '收货人联系电话',
              onChange: (value){
                phone = value;
              },
            ),
            SizedBox(height: 20),

            Container(
              height: ScreenAdapter.height(100),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 1,
                    color: Colors.black12,
                  ),
                ),
              ),
              child: InkWell(
                onTap: () async{
                  Result? result = await CityPickers.showCityPicker(
                    context: context,
                    cancelWidget: Text('取消', style: TextStyle(
                      color: Colors.amber,
                    )),
                    confirmWidget: Text('确认', style: TextStyle(
                      color: Colors.amber,
                    )),
                  );
                  
                  setState(() {
                    area = '${result!.provinceName} ${result.cityName} ${result.areaName}';
                  });
                },
                child: Row(
                  children: <Widget>[
                    Icon(Icons.add_location),
                    area.length > 0
                    ?Text('${area}', style: TextStyle(
                      color: Colors.black54
                    ))
                    :Text('省/市/区', style: TextStyle(
                      color: Colors.black54
                    )),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),

            JDText(
              text: '详细地址',
              maxLine: 4,
              height: 180,
              onChange: (value){
                address = area + ' ' + value;
              },
            ),
            SizedBox(height: 50),

            MainButton(
              text: '增加',
              color: Colors.amber,
              onTap: () async{
                List userinfo = await UserServices.getUserInfo();

                Map tempJson = {
                  "uid": userinfo[0]['_id'],
                  "name": name,
                  "phone": phone,
                  "address": address,
                  "salt": userinfo[0]['salt'],
                };

                String sign = SignService.getSign(tempJson);

                String api = Api.addAddress;
                var response = await Dio().post(api, data: {
                  "uid": userinfo[0]['_id'],
                  "name": name,
                  "phone": phone,
                  "address": address,
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

                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}