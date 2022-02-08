import 'package:flutter/material.dart';

class Counter with ChangeNotifier{
  int _count = 99;//状态

  int get count => _count;//获取状态

  incCount(){//更新状态
    _count++;
    notifyListeners();//通知全局更新状态
  }
}