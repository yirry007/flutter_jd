import 'package:flutter/material.dart';
import 'package:flutter_jd/pages/ProductContent/ProductContentFirst.dart';
import 'package:flutter_jd/pages/ProductContent/ProductContentSecond.dart';
import 'package:flutter_jd/pages/ProductContent/ProductContentThird.dart';
import 'package:flutter_jd/provider/Cart.dart';
import 'package:flutter_jd/services/CartServices.dart';
import 'package:flutter_jd/services/ScreenAdapter.dart';
import 'package:flutter_jd/widget/LoadingWidget.dart';
import 'package:flutter_jd/widget/MainButton.dart';
import 'package:flutter_jd/config/Api.dart';
import 'package:flutter_jd/model/ProductContentModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter_jd/services/EventBus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

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
    var cartProvider = Provider.of<Cart>(context);
    
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
              physics: NeverScrollableScrollPhysics(),//禁止页面触摸滑动
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
                    InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, '/cart');
                      },
                      child: Container(
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
                    ),
                    Expanded(
                      flex: 1,
                      child: MainButton(
                        color: Color.fromRGBO(253, 1, 0, 0.9),
                        text: '加入购物车',
                        onTap: () async {
                          if (_productContentData!.attr!.isNotEmpty) {
                            //有属性，则弹出属性筛选框
                            eventBus.fire(ProductContentEvent(str: '加入购物车'));
                          } else {
                            //把数据放入购物车中
                            await CartServices.addCart(_productContentData);
                            //调用Provider 更新数据
                            cartProvider.updateCartList();

                            Fluttertoast.showToast(
                              msg: "加入购物车成功",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                            );
                          }
                        },
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: MainButton(
                        color: Color.fromRGBO(253, 165, 0, 0.9),
                        text: '立即购买',
                        onTap: (){
                          if (_productContentData!.attr!.isNotEmpty) {
                            //有属性，则弹出属性筛选框
                            eventBus.fire(ProductContentEvent(str: '立即购买'));
                          } else {
                            print('立即购买操作');
                          }
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