import 'package:flutter/material.dart';
import 'package:flutter_jd/services/ScreenAdapter.dart';

class MainButton extends StatelessWidget {
  final Color color;
  final String text;
  final VoidCallback onTap;

  MainButton({Key? key, this.color=Colors.black, this.text='按钮', required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(4),
        height: ScreenAdapter.height(80),
        width: double.infinity,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text('${text}', style: TextStyle(
            color: Colors.white,
          )),
        ),
      ),
    );
  }
}