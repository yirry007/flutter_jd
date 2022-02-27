import 'package:flutter/material.dart';
import 'package:flutter_jd/services/ScreenAdapter.dart';
import 'package:flutter_jd/widget/JDText.dart';
import 'package:flutter_jd/widget/MainButton.dart';
import 'package:flutter_jd/config/Api.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterFirstPage extends StatefulWidget {
  RegisterFirstPage({Key? key}) : super(key: key);

  @override
  State<RegisterFirstPage> createState() => _RegisterFirstPageState();
}

class _RegisterFirstPageState extends State<RegisterFirstPage> {
  String? tel;

  _sendCode() async{
    RegExp reg = RegExp(r'^1\d{10}$');

    if (!reg.hasMatch(tel!)) {
      Fluttertoast.showToast(
        msg: "手机号格式错误",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
      return false;
    }

    var api = Api.sendCode;
    var response = await Dio().post(api, data: {"tel": tel});

    if (!response.data['success']) {
      Fluttertoast.showToast(
        msg: "${response.data['message']}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
      return false;
    }

    print(response);

    Navigator.pushNamed(context, '/register_second', arguments: {
      'tel': tel,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('用户注册-第一步'),
      ),
      body: Container(
        padding: EdgeInsets.all(ScreenAdapter.width(20)),
        child: ListView(
          children: <Widget>[
            SizedBox(height: ScreenAdapter.height(100)),
            JDText(
              text: '请输入手机号',
              onChange: (value){
                tel = value;
              }
            ),

            SizedBox(height: 20),
            MainButton(
              text: '下一步',
              color: Colors.amber,
              onTap: _sendCode,
            ),
          ],
        ),
      ),
    );
  }
}