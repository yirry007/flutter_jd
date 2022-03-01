import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jd/config/Api.dart';
import 'package:flutter_jd/pages/tabs/Tabs.dart';
import 'package:flutter_jd/services/ScreenAdapter.dart';
import 'package:flutter_jd/services/Storage.dart';
import 'package:flutter_jd/widget/JDText.dart';
import 'package:flutter_jd/widget/MainButton.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterThirdPage extends StatefulWidget {
  Map? arguments;
  RegisterThirdPage({Key? key, this.arguments}) : super(key: key);

  @override
  State<RegisterThirdPage> createState() => _RegisterThirdPageState();
}

class _RegisterThirdPageState extends State<RegisterThirdPage> {
  String tel = '';
  String code = '';
  String password = '';
  String rpassword = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    tel = widget.arguments!['tel'];
    code = widget.arguments!['code'];
  }

  //注册
  doRegister() async{
    if (password.length < 6) {
      Fluttertoast.showToast(
        msg: "请输入6位以上的密码",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
      return false;
    }

    if (password != rpassword) {
      Fluttertoast.showToast(
        msg: "两次密码输入不一致",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
      return false;
    }

    var api = Api.register;
    var response = await Dio().post(api, data: {
      "tel": tel,
      "code": code,
      "password": password,
    });

    if (!response.data['success']) {
      Fluttertoast.showToast(
        msg: "${response.data['message']}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
      return false;
    }

    //保存用户信息，并返回到首页
    Storage.setString('userInfo', json.encode(response.data['userinfo']));
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context)=>Tabs()),
      (route) => route == null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('用户注册-第三步'),
      ),
      body: Container(
        padding: EdgeInsets.all(ScreenAdapter.width(20)),
        child: ListView(
          children: <Widget>[
            SizedBox(height: ScreenAdapter.height(100)),

            JDText(
              text: '请输入密码',
              password: true,
              onChange: (value){
                password = value;
              }
            ),

            SizedBox(height: 10),
            JDText(
              text: '请重新输入密码',
              password: true,
              onChange: (value){
                rpassword = value;
              }
            ),

            SizedBox(height: 20),
            MainButton(
              text: '完成注册',
              color: Colors.amber,
              onTap: doRegister,
            ),
          ],
        ),
      ),
    );
  }
}