import 'package:flutter/material.dart';
import 'package:flutter_jd/services/ScreenAdapter.dart';

class JDText extends StatelessWidget {
  String text;
  bool password;
  int maxLine;
  double height;
  void Function(String)? onChange;
  TextEditingController? controller;
  JDText({Key? key, this.text='输入内容', this.password=false, this.maxLine=1, this.height=70, required this.onChange, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenAdapter.height(height),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Colors.black12,
          ),
        ),
      ),
      child: TextField(
        maxLines: maxLine,
        obscureText: password,
        decoration: InputDecoration(
          hintText: '${text}',
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        controller: controller,
        onChanged: onChange,
      ),
    );
  }
}