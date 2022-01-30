import 'package:flutter/material.dart';

class ProductContentSecond extends StatefulWidget {
  ProductContentSecond({Key? key}) : super(key: key);

  @override
  State<ProductContentSecond> createState() => _ProductContentSecondState();
}

class _ProductContentSecondState extends State<ProductContentSecond> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('详情页面'),
    );
  }
}