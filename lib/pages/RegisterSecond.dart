import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jd/config/Api.dart';
import 'package:flutter_jd/services/ScreenAdapter.dart';
import 'package:flutter_jd/widget/JDText.dart';
import 'package:flutter_jd/widget/MainButton.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterSecondPage extends StatefulWidget {
  Map? arguments;
  RegisterSecondPage({Key? key, this.arguments}) : super(key: key);

  @override
  State<RegisterSecondPage> createState() => _RegisterSecondPageState();
}

class _RegisterSecondPageState extends State<RegisterSecondPage> {
  String? tel;
  String? code;
  bool sendCodeBtn = false;
  int seconds = 10;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    tel = widget.arguments!['tel'];
    _showTimer();
  }

  //倒计时
  _showTimer(){
    late Timer t;
    t = Timer.periodic(Duration(milliseconds: 1000), (timer){
      setState(() {
        seconds--;
      });
      if (seconds <= 0) {
        setState(() {
          sendCodeBtn = true;
        });
        t.cancel();
      }
    });
  }

  //重新发送验证码
  _sendCode() async{
    setState(() {
      sendCodeBtn = false;
      seconds = 10;
    });

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

    _showTimer();
  }

  //验证验证码
  validateCode() async{
    var api =  Api.validateCode;
    var response = await Dio().post(api, data: {"tel": tel, "code": code});

    if (!response.data['success']) {
      Fluttertoast.showToast(
        msg: "${response.data['message']}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
      return false;
    }

    Navigator.pushNamed(context, '/register_third');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('用户注册-第二步'),
      ),
      body: Container(
        padding: EdgeInsets.all(ScreenAdapter.width(20)),
        child: ListView(
          children: <Widget>[
            SizedBox(height: ScreenAdapter.height(100)),
            Container(
              child: Text('请输入 ${tel} 手机收到的验证码'),
            ),

            SizedBox(height: ScreenAdapter.height(40)),

            Row(
              children: <Widget>[
                Container(
                  width: ScreenAdapter.width(500),
                  child: JDText(
                    text: '请输入验证码',
                    onChange: (value){
                      code = value;
                    }
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: sendCodeBtn
                  ? MainButton(
                    text: '重新发送',
                    color: Colors.amber,
                    onTap: (){
                      _sendCode();
                    },
                  )
                  : MainButton(
                    text: '${seconds}秒后重发',
                    color: Colors.amber,
                    onTap: (){},
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            MainButton(
              text: '下一步',
              color: Colors.amber,
              onTap: validateCode,
            ),
          ],
        ),
      ),
    );
  }
}