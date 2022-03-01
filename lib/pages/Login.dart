import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jd/config/Api.dart';
import 'package:flutter_jd/services/ScreenAdapter.dart';
import 'package:flutter_jd/services/Storage.dart';
import 'package:flutter_jd/widget/JDText.dart';
import 'package:flutter_jd/widget/MainButton.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_jd/services/EventBus.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //监听登录页面销毁事件
  dispose(){
    super.dispose();
    eventBus.fire(UserEvent(str: '登录成功'));
  }

  String username = '';
  String password = '';

  doLogin() async{
    RegExp reg = RegExp(r'^1\d{10}$');

    if (!reg.hasMatch(username)) {
      Fluttertoast.showToast(
        msg: "手机号格式错误",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
      return false;
    }
    
    if (password.length < 6) {
      Fluttertoast.showToast(
        msg: "请输入不少于6位的密码",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
      return false;
    }

    var api = Api.doLogin;
    var response = await Dio().post(api, data: {
      "username": username,
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

    print(response);

    Storage.setString('userInfo', json.encode(response.data['userinfo']));

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Text('用户登录'),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.close),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: (){},
            child: Text('客服', style: TextStyle(
              color: Colors.black54,
              fontSize: ScreenAdapter.size(32),
            )),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(ScreenAdapter.width(20)),
        child: ListView(
          children: <Widget>[
            Center(
              child: Container(
                padding: EdgeInsets.only(top: 30),
                height: ScreenAdapter.height(160),
                width: ScreenAdapter.width(160),
                child: Image.asset('images/login.png'),
              ),
            ),

            SizedBox(height: 40),
            JDText(
              text: '请输入用户名',
              onChange: (value){
                username = value;
              }
            ),

            SizedBox(height: 10),
            JDText(
              text: '请输入密码',
              password: true,
              onChange: (value){
                password = value;
              }
            ),

            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                InkWell(
                  child: Text('忘记密码'),
                  onTap: (){},
                ),
                InkWell(
                  child: Text('新用户注册'),
                  onTap: (){
                    Navigator.pushNamed(context, '/register_first');
                  },
                ),
              ],
            ),

            SizedBox(height: 40),
            MainButton(
              text: '登录',
              color: Colors.amber,
              onTap: doLogin,
            ),
          ],
        ),
      ),
    );
  }
}