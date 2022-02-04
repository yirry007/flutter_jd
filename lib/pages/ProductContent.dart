import 'package:flutter/material.dart';
import 'package:flutter_jd/pages/ProductContent/ProductContentFirst.dart';
import 'package:flutter_jd/pages/ProductContent/ProductContentSecond.dart';
import 'package:flutter_jd/pages/ProductContent/ProductContentThird.dart';
import 'package:flutter_jd/services/ScreenAdapter.dart';
import 'package:flutter_jd/widget/LoadingWidget.dart';
import 'package:flutter_jd/widget/MainButton.dart';
import 'package:flutter_jd/config/Api.dart';
import 'package:flutter_jd/model/ProductContentModel.dart';
import 'package:dio/dio.dart';

class ProductContentPage extends StatefulWidget {
  final Map? arguments;
  ProductContentPage({Key? key, this.arguments}) : super(key: key);

  @override
  State<ProductContentPage> createState() => _ProductContentPageState();
}

class _ProductContentPageState extends State<ProductContentPage> {
  ProductContentItem? _productContentData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getContentData();
  }

  _getContentData() async{
    var api = '${Api.pcontent}?id=${widget.arguments!['id']}';
    var result = await Dio().get(api);
    var productContent = ProductContentModel.fromJson(result.data);

    setState(() {
      _productContentData = productContent.result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: ScreenAdapter.width(400),
                child: TabBar(//这个组件必须在body里设置TabBarView组件
                  indicatorColor: Colors.white,
                  indicatorSize: TabBarIndicatorSize.label,
                  tabs: <Widget>[
                    Tab(
                      child: Text('商品'),
                    ),
                    Tab(
                      child: Text('详情'),
                    ),
                    Tab(
                      child: Text('评价'),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.more_horiz),
              onPressed: (){
                showMenu(
                  context: context,
                  position: RelativeRect.fromLTRB(ScreenAdapter.width(600), 76, 10, 0),
                  items: [
                    PopupMenuItem(
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.home),
                          Text('首页'),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.search),
                          Text('搜索'),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
        body: _productContentData != null
        ? Stack(
          children: <Widget>[
            TabBarView(//这个组件必须在appBar里有TabBar组件
              children: <Widget>[
                ProductContentFirst(productContentData: _productContentData),
                ProductContentSecond(productContentData: _productContentData),
                ProductContentThird(),
              ],
            ),
            Positioned(
              width: ScreenAdapter.getScreenWidth(),
              height: ScreenAdapter.height(100),
              bottom: 0,
              child: Container(
                padding: EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.black26,
                      width: 1,
                    ),
                  ),
                  color: Colors.white,
                ),
                child: Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: ScreenAdapter.height(10)),
                      width: 80,
                      height: ScreenAdapter.height(100),
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.shopping_cart),
                          Text('购物车'),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: MainButton(
                        color: Color.fromRGBO(253, 1, 0, 0.9),
                        text: '加入购物车',
                        onTap: (){
                          print('加入购物车');
                        },
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: MainButton(
                        color: Color.fromRGBO(253, 165, 0, 0.9),
                        text: '立即购买',
                        onTap: (){
                          print('立即购买');
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
        :LoadingWidget(),
      ),
    );
  }
}