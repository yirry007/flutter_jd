import 'package:flutter/material.dart';
import 'package:flutter_jd/services/ScreenAdapter.dart';

class JDText extends StatelessWidget {
  String text;
  bool password;
  void Function(String)? onChange;
  JDText({Key? key, this.text='输入内容', this.password=false, required, this.onChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenAdapter.height(70),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Colors.black12,
          ),
        ),
      ),
      child: TextField(
        obscureText: password,
        decoration: InputDecoration(
          hintText: '${text}',
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onChanged: onChange,
      ),
    );
  }
}