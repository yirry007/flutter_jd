import 'package:flutter/material.dart';
import 'package:flutter_jd/services/ScreenAdapter.dart';
import 'package:flutter_jd/config/Api.dart';
import 'package:flutter_jd/model/CateModel.dart';
import 'package:dio/dio.dart';

class CategoryPage extends StatefulWidget {
  CategoryPage({Key? key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> with AutomaticKeepAliveClientMixin {
  int _selectIndex = 0;
  List _leftCateList = [];
  List _rightCateList = [];

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getLeftCateData();
  }

  /// 获取轮播图数据
  _getLeftCateData() async{
    var result = await Dio().get(Api.pcate);
    var cateList = CateModel.fromJson(result.data);

    setState(() {
      _leftCateList = cateList.result!.toList();
    });

    _getRightCateData(cateList.result![0].sId);
  }

  /// 获取轮播图数据
  _getRightCateData(pid) async{
    var result = await Dio().get('${Api.pcate}?pid=${pid}');
    var cateList = CateModel.fromJson(result.data);

    setState(() {
      _rightCateList = cateList.result!.toList();
    });
  }

  Widget _leftCateWidget(){
    double leftWidth = ScreenAdapter.getScreenWidth() / 4;

    Widget _widget;

    if (_leftCateList.length > 0) {
      _widget = Container(
        width: leftWidth,
        height: double.infinity,
        child: ListView.builder(
          itemCount: _leftCateList.length,
          itemBuilder: (context, index){
            return Column(
              children: <Widget>[
                InkWell(
                  onTap: (){
                    setState(() {
                      _selectIndex = index;
                    });
                    _getRightCateData(_leftCateList[index].sId);
                  },
                  child: Container(
                    width: double.infinity,
                    height: ScreenAdapter.height(84),
                    alignment: Alignment.center,
                    color: _selectIndex == index ? Color.fromRGBO(240, 246, 246, 0.9) : Colors.white,
                    child: Text(_leftCateList[index].title, textAlign: TextAlign.center),
                  ),
                ),
                Divider(height: 1),
              ],
            );
          },
        ),
      );
    } else {
      _widget = Container(
        width: leftWidth,
        height: double.infinity,
      );
    }

    return _widget;
  }

  Widget _rightCateWidget(){
    Widget _widget;

    if (_rightCateList.length > 0) {
      double sideSeparator = 10;
      double separator = 10;
      double textHeight = ScreenAdapter.height(28);
      double rightItemWidth = (ScreenAdapter.getScreenWidth() - sideSeparator * 2 - separator * 2) / 3;
      rightItemWidth = ScreenAdapter.width(rightItemWidth);
      double rightItemHeight = rightItemWidth + textHeight;

      _widget = Expanded(
        flex: 1,
        child: Container(
          padding: EdgeInsets.all(sideSeparator),
          height: double.infinity,
          color: Color.fromRGBO(240, 246, 246, 0.9),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: rightItemWidth/rightItemHeight,
              crossAxisSpacing: separator, 
              mainAxisSpacing: separator,
            ),
            itemCount: _rightCateList.length,
            itemBuilder: (context, index){
              String imagePath = _rightCateList[index].pic;
              String path = Api.Host + imagePath.replaceAll('\\', '/');

              return Container(
                child: Column(
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 1/1,
                      child: Image.network('${path}', fit: BoxFit.cover),
                    ),
                    Container(
                      height: textHeight,
                      child: Text('${_rightCateList[index].title}'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );
    } else {
      _widget = Expanded(
        flex: 1,
        child: Container(
          height: double.infinity,
          color: Color.fromRGBO(240, 246, 246, 0.9),
          child: Text('加载中...'),
        ),
      );
    }
    
    return _widget;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        _leftCateWidget(),
        _rightCateWidget(),
      ],
    );
  }
}