import 'package:flutter/material.dart';
import 'package:flutter_jd/services/SignServices.dart';
import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';
import 'package:flutter_jd/services/ScreenAdapter.dart';
import 'package:flutter_jd/model/FocusModel.dart';
import 'package:flutter_jd/model/ProductModel.dart';
import 'package:flutter_jd/config/Api.dart';
import 'dart:convert';
import 'package:dio/dio.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  List _focusData = [];
  List _hotProductData = [];
  List _bestProductData = [];

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    _getFocusData();
    _getHotProductData();
    _getBestProductData();

    SignService.getSign({});
  }

  /// 获取轮播图数据
  _getFocusData() async{
    var result = await Dio().get(Api.focus);
    var focusList = FocusModel.fromJson(result.data);

    setState(() {
      _focusData = focusList.result!.toList();
    });
  }

  ///获取猜你喜欢的数据
  _getHotProductData() async{
    var api = '${Api.plist}?is_hot=1';
    var result = await Dio().get(api);
    var productList = ProductModel.fromJson(result.data);

    setState(() {
      _hotProductData = productList.result!.toList();
    });
  }

  ///获取热门推荐的数据
  _getBestProductData() async{
    var api = '${Api.plist}?is_best=1';
    var result = await Dio().get(api);
    var productList = ProductModel.fromJson(result.data);

    setState(() {
      _bestProductData = productList.result!.toList();
    });
  }

  Widget _swiperWidget(){
    Widget _widget;

    if (_focusData.length > 0) {
      _widget = Container(
        child: AspectRatio(
          aspectRatio: 2/1,
          child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              String imagePath = _focusData[index].pic;
              String path = Api.Host + imagePath.replaceAll('\\', '/');
              return Image.network(
                '${path}',
                fit: BoxFit.fill,
              );
            },
            autoplay: true,
            itemCount: _focusData.length,
            pagination: SwiperPagination(),
          )
        ),
      );
    } else {
      _widget = Text('加载中...');
    }

    return _widget;
  }

  Widget _titleWidget(value){
    return Container(
      height: ScreenAdapter.height(34),
      margin: EdgeInsets.only(left: ScreenAdapter.width(20)),
      padding: EdgeInsets.only(left: ScreenAdapter.width(20)),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: Colors.red,
            width: ScreenAdapter.width(10),
          ),
        ),
      ),
      child: Text(value, style: TextStyle(
        color: Colors.black54,
        fontSize: ScreenAdapter.size(26),
      )),
    );
  }

  //热门商品
  Widget _hotProductListWidget(){
    Widget _widget;

    if (_hotProductData.length > 0) {
      _widget = Container(
        height: ScreenAdapter.height(234),
        padding: EdgeInsets.all(ScreenAdapter.height(20)),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index){
            String imagePath = _hotProductData[index].sPic;
            String path = Api.Host + imagePath.replaceAll('\\', '/');
            return Column(
              children: <Widget>[
                Container(
                  width: ScreenAdapter.height(140),
                  height: ScreenAdapter.height(140),
                  margin: EdgeInsets.only(right: ScreenAdapter.width(21)),
                  child: Image.network(
                    '${path}',
                    fit: BoxFit.cover
                  ),
                ),
                Container(
                  height: ScreenAdapter.height(44),
                  padding: EdgeInsets.only(top: ScreenAdapter.height(10)),
                  child: Text('￥${_hotProductData[index].price}', style: TextStyle(
                    color: Colors.red,
                  )),
                ),
              ],
            );
          },
          itemCount: _hotProductData.length,
        ),
      );
    } else {
      _widget = Text('加载中...');
    }
    return _widget;
  }

  //推荐商品
  Widget _recProductListWidget(){
    var itemWidth = (ScreenAdapter.getScreenWidth() - 30) / 2;

    return Container(
      padding: EdgeInsets.all(10),
      child: Wrap(
        spacing: 10,//元素在主轴上的间距
        runSpacing: 10,//元素在交叉轴上的间距
        children: _bestProductData.map((v){
          String imagePath = v.pic;
          String path = Api.Host + imagePath.replaceAll('\\', '/');
          return InkWell(
            onTap: (){
              Navigator.pushNamed(context, '/productContent', arguments: {
                'id': v.sId,
              });
            },
            child: Container(
              width: itemWidth,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color.fromRGBO(233, 233, 233, 0.9),
                  width: 1,
                ),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    child: AspectRatio(
                      aspectRatio: 1/1,//防止服务器图片宽高不一致
                      child: Image.network('${path}', fit: BoxFit.cover),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: ScreenAdapter.height(20)),
                    child: Text(
                      v.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,//多出部分...
                      style: TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: ScreenAdapter.height(20)),
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('￥${v.price}', style: TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                          )),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text('￥${v.oldPrice}', style: TextStyle(
                            color: Colors.black54,
                            fontSize: 14,
                            decoration: TextDecoration.lineThrough,
                          )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.center_focus_weak),
          onPressed: (){},
        ),
        title: InkWell(
          onTap: (){
            Navigator.pushNamed(context, '/search');
          },
          child: Container(
            height: ScreenAdapter.height(70),
            padding: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              color: Color.fromRGBO(233, 233, 233, 0.8),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.search),
                Text('笔记本', style: TextStyle(fontSize: ScreenAdapter.size(28))),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.message, size: 28, color: Colors.black87),
            onPressed: (){},
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          _swiperWidget(),
          
          SizedBox(height: ScreenAdapter.height(20)),
          _titleWidget('猜你喜欢'),

          SizedBox(height: ScreenAdapter.height(20)),
          _hotProductListWidget(),

          _titleWidget('热门推荐'),

          _recProductListWidget(),
        ],
      ),
    );
  }
}