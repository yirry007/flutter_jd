import 'package:flutter/material.dart';
import 'package:flutter_jd/services/ScreenAdapter.dart';
import 'package:flutter_jd/config/Api.dart';
import 'package:flutter_jd/model/ProductModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter_jd/widget/LoadingWidget.dart';

class ProductListPage extends StatefulWidget {
  Map? arguments;
  ProductListPage({Key? key, this.arguments}) : super(key: key);

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  //在这个子类中用 widget 来可以访问父类的属性，比如 arguments
  
  int _page = 1;
  int _pageSize = 8;
  List _productList = [];
  String _sort = '';
  bool _flag = true;//数据请求开关，解决重复请求的问题
  bool _noMore = false;//是否数据请求完毕
  //自定义按钮调用系统事件时，先配置以下内容（固定写法）
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  //用于上拉分页
  ScrollController _scrollController = ScrollController();

  List _subHeaderList = [
    {'id':1, 'title':'综合', 'fields':'all', 'sort':-1},
    {'id':2, 'title':'销量', 'fields':'salecount', 'sort':-1},
    {'id':3, 'title':'价格', 'fields':'price', 'sort':-1},
    {'id':4, 'title':'筛选'},
  ];
  int _selectedHeaderID = 1;

  @override
  void initState() {
    super.initState();
    
    _getProductListData();
    //监听滚动条滚动事件
    _scrollController.addListener(() {
      //_scrollController.position.pixels;//获取滚动条滚动的高度
      //_scrollController.position.maxScrollExtent;//获取页面的高度

      if (_scrollController.position.pixels + 20 > _scrollController.position.maxScrollExtent) {
        if (_flag) {
          _getProductListData();
        }
      }
    });
  }

  //获取商品列表的数据
  _getProductListData() async{
    setState(() {
      _flag = false;
    });

    bool hasMore = true;
    var result = await Dio().get('${Api.plist}?cid=${widget.arguments!["cid"]}&page=${_page}&pageSize=${_pageSize}&sort=${_sort}');
    var productList = ProductModel.fromJson(result.data);

    if (productList.result!.toList().length < _pageSize) {
      hasMore = false;
    }

    setState(() {
      _productList.addAll(productList.result!.toList());//拼接数据
      _page++;
      _flag = hasMore;
      _noMore = !hasMore;
    });
  }

  //商品列表
  Widget _productListWidget(){
    Widget _widget;

    if (_productList.length > 0) {
      _widget = Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(top: ScreenAdapter.height(80)),
        child: ListView.builder(
          controller: _scrollController,
          itemBuilder: (context, index){
            String imagePath = _productList[index].pic;
            String path = Api.Host + imagePath.replaceAll('\\', '/');
            Widget _bottomLoading;
            if (_noMore) {
              _bottomLoading = index == _productList.length - 1 ? Text('--我是有底线的--') : Text('');
            } else {
              _bottomLoading = index == _productList.length - 1 ? LoadingWidget() : Text('');
            }

            return Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: ScreenAdapter.width(180),
                      height: ScreenAdapter.height(180),
                      child: Image.network('${path}', fit: BoxFit.cover),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: ScreenAdapter.height(180),
                        margin: EdgeInsets.only(left: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '${_productList[index].title}',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  height: ScreenAdapter.height(36),
                                  margin: EdgeInsets.only(right: 10),
                                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    ///如果Container组件包含decoration的属性，则color必须在decoration里修饰，放到外面则报错
                                    color: Color.fromRGBO(230, 230, 230, 0.9),
                                  ),
                                  child: Text('4G'),
                                ),
                                Container(
                                  height: ScreenAdapter.height(36),
                                  margin: EdgeInsets.only(right: 10),
                                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color.fromRGBO(230, 230, 230, 0.9),
                                  ),
                                  child: Text('4G'),
                                ),
                              ],
                            ),
                            Text(
                              '￥${_productList[index].price}',
                              style: TextStyle(color: Colors.red, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(height: 20),
                _bottomLoading,
              ],
            );
          },
          itemCount: _productList.length,
        ),
      );
    } else {
      _widget = LoadingWidget();
    }

    return _widget;
  }
  
  _subHeaderChange(id){
    if (id == 4) {
      _scaffoldKey.currentState!.openEndDrawer();
    } else {
      setState(() {
        _sort = '${_subHeaderList[id-1]["fields"]}_${_subHeaderList[id-1]["sort"]}';
        _productList = [];//重置数据
        _page = 1;//重置当前页数
        _noMore = false;//重置是否数据请求完毕
        _subHeaderList[id-1]["sort"] *= -1;
      });
      _scrollController.jumpTo(0);//页面回滚到顶部

      _getProductListData();
    }

    setState(() {
      _selectedHeaderID = id;
    });
  }

  //显示 header 下拉箭头 icon
  Widget _showIcon(id){
    Widget _widget;

    if (id == 4) {
      _widget = Text('');
    } else {
      if (_subHeaderList[id-1]["sort"] == 1) {
        _widget = Icon(
          Icons.arrow_drop_down,
          color: _selectedHeaderID == id ? Colors.red : Colors.black54,
        );
      } else {
        _widget = Icon(
          Icons.arrow_drop_up,
          color: _selectedHeaderID == id ? Colors.red : Colors.black54,
        );
      }
        
    }

    return _widget;
  }

  //筛选导航
  Widget _subHeaderWidget(){
    return Positioned(
      top: 0,
      height: ScreenAdapter.height(80),
      width: ScreenAdapter.getScreenWidth(),
      child: Container(
        width: ScreenAdapter.getScreenWidth(),
        height: ScreenAdapter.height(80),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1, color: Color.fromRGBO(233, 233, 233, 0.9)),
          ),
        ),
        child: Row(
          children: _subHeaderList.map((value){
            return Expanded(
              flex: 1,
              child: InkWell(
                onTap: (){
                  _subHeaderChange(value["id"]);
                },
                child: Container(
                  height: ScreenAdapter.height(100),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '${value["title"]}',
                        style: TextStyle(
                          color: _selectedHeaderID == value["id"] ? Colors.red : Colors.black54,
                        ),
                      ),
                      _showIcon(value["id"]),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,//给当前的 Scaffold 唯一的key
      appBar: AppBar(
        title: Text('商品列表'),
        //leading: Text(''),//控制顶部左侧按钮，此行表示隐藏返回按钮
        actions: <Widget>[//控制顶部右侧的功能按钮
          Text(''),//隐藏右侧的 Drawer 组件控制按钮
        ],
      ),
      //body: Text('${widget.arguments}'),
      endDrawer: Drawer(
        child: Container(
          child: Text('实现筛选功能'),
        ),
      ),
      body: Stack(
        children: <Widget>[
          _productListWidget(),
          _subHeaderWidget(),
        ],
      ),
    );
  }
}