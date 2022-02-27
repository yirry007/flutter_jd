import 'package:flutter/material.dart';
import 'package:flutter_jd/services/ScreenAdapter.dart';
import 'package:flutter_jd/widget/JDText.dart';
import 'package:flutter_jd/widget/MainButton.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                print(value);
              }
            ),

            SizedBox(height: 10),
            JDText(
              text: '请输入密码',
              password: true,
              onChange: (value){
                print(value);
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
              onTap: (){},
            ),
          ],
        ),
      ),
    );
  }
}