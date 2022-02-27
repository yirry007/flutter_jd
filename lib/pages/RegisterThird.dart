import 'package:flutter/material.dart';
import 'package:flutter_jd/services/ScreenAdapter.dart';
import 'package:flutter_jd/widget/JDText.dart';
import 'package:flutter_jd/widget/MainButton.dart';

class RegisterThirdPage extends StatefulWidget {
  RegisterThirdPage({Key? key}) : super(key: key);

  @override
  State<RegisterThirdPage> createState() => _RegisterThirdPageState();
}

class _RegisterThirdPageState extends State<RegisterThirdPage> {
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
                print(value);
              }
            ),

            SizedBox(height: 10),
            JDText(
              text: '请重新输入密码',
              password: true,
              onChange: (value){
                print(value);
              }
            ),

            SizedBox(height: 20),
            MainButton(
              text: '完成注册',
              color: Colors.amber,
              onTap: (){},
            ),
          ],
        ),
      ),
    );
  }
}