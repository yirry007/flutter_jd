import 'package:flutter/material.dart';
import 'package:flutter_jd/pages/tabs/Home.dart';
import 'package:flutter_jd/pages/tabs/Category.dart';
import 'package:flutter_jd/pages/tabs/Cart.dart';
import 'package:flutter_jd/pages/tabs/User.dart';

class Tabs extends StatefulWidget {
  Tabs({Key? key}) : super(key: key);

  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _currentIndex = 1;
  List _pageList = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    UserPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('JDshop')),
        body: _pageList[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          fixedColor: Colors.red,
          currentIndex: _currentIndex,
          onTap: (index){
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '首页',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: '分类',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: '购物车',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: '我的',
            ),
          ],
        ),
      );
  }
}