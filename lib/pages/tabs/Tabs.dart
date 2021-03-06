import 'package:flutter/material.dart';
import 'package:flutter_jd/pages/tabs/Home.dart';
import 'package:flutter_jd/pages/tabs/Category.dart';
import 'package:flutter_jd/pages/tabs/Cart.dart';
import 'package:flutter_jd/pages/tabs/User.dart';
import 'package:flutter_jd/services/ScreenAdapter.dart';

class Tabs extends StatefulWidget {
  Tabs({Key? key}) : super(key: key);

  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _currentIndex = 0;
  var _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  List<Widget> _pageList = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    UserPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        /*
        body: IndexedStack(//这个组件可以保持页面的数据状态（适用于所有页面保持状态）
          index: this._currentIndex,//根据这个索引判断显示第几个页面
          children: _pageList,
        ),
        */
        body: PageView(
          controller: _pageController,
          children: _pageList,
          onPageChanged: (index){
            setState(() {
              _currentIndex = index;
            });
          },
          physics: NeverScrollableScrollPhysics(),//禁止页面触摸滑动
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          fixedColor: Colors.amber,
          currentIndex: _currentIndex,
          onTap: (index){
            setState(() {
              _currentIndex = index;
              _pageController.jumpToPage(index);
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