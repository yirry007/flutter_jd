import 'package:flutter/material.dart';
import 'package:flutter_jd/services/ScreenAdapter.dart';
import 'package:flutter_jd/services/SearchServices.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String keywords = '';
  List _historyListData = [];

  @override
  void initState() {
    super.initState();

    _getHistoryData();
  }

  _getHistoryData() async{
    var _data = await SearchServices.getHistoryList();
    setState(() {
      _historyListData = _data;
    });
  }
  
  _showAlertDialog(keywords) async{
    var result = await showDialog(
      barrierDismissible: false,//点击灰色背景时关闭对话框
      context: context,
      builder: (context){
        return AlertDialog(
          title: Text('提示信息！'),
          content: Text('确定要删除吗？'),
          actions: <Widget>[
            TextButton(
              child: Text('取消'),
              onPressed: (){
                Navigator.pop(context, 'Cancel');
              },
            ),
            TextButton(
              child: Text('确定'),
              onPressed: () async{
                await SearchServices.removeHistoryData(keywords);
                _getHistoryData();
                Navigator.pop(context, 'OK');
              },
            ),
          ],
        );
      },
    );
  }

  Widget _historyListWidget(){
    Widget _widget;

    if (_historyListData.length > 0) {
      _widget = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text('历史记录', style: TextStyle(
              fontSize: ScreenAdapter.height(36),
            )),
          ),
          Divider(),
          Column(
            children: _historyListData.map((value){
              return Column(
                children: <Widget>[
                  ListTile(
                    title: Text('${value}'),
                    onLongPress: (){
                      _showAlertDialog('${value}');
                    },
                    onTap: (){
                      Navigator.pushReplacementNamed(context, '/productList', arguments: {
                        "keywords": value,
                      });
                    },
                  ),
                  Divider(),
                ],
              );
            }).toList(),
          ),
          SizedBox(height: 100),
          InkWell(
            onTap: (){
              SearchServices.clearHistoryList();
              _getHistoryData();
            },
            child: Container(
              height: ScreenAdapter.height(64),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black45,
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.delete),
                  Text('清空历史记录'),
                ],
              ),
            ),
          ),
        ],
      );
    } else {
      _widget = Text('');
    }

    return _widget;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: ScreenAdapter.height(70),
          decoration: BoxDecoration(
            color: Color.fromRGBO(233, 233, 233, 0.8),
            borderRadius: BorderRadius.circular(30),
          ),
          child: TextField(
            autofocus: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onChanged: (value){
              setState(() {
                keywords = value;
              });
            },
          ),
        ),
        actions: <Widget>[
          InkWell(
            onTap: (){
              SearchServices.setHistoryData(keywords);//先保存搜索词
              Navigator.pushReplacementNamed(context, '/productList', arguments: {
                "keywords": keywords,
              });
            },
            child: Container(
              height: ScreenAdapter.height(70),
              width: ScreenAdapter.width(80),
              child: Row(
                children: <Widget>[
                  Text('搜索'),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
              child: Text('热搜', style: TextStyle(
                fontSize: ScreenAdapter.height(36),
              )),
            ),
            Divider(),
            Wrap(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(233, 233, 233, 0.9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text('女装'),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(233, 233, 233, 0.9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text('女装'),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(233, 233, 233, 0.9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text('女装'),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(233, 233, 233, 0.9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text('女装'),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(233, 233, 233, 0.9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text('女装'),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(233, 233, 233, 0.9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text('女装'),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(233, 233, 233, 0.9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text('女装'),
                ),
              ],
            ),
            SizedBox(height: 10),
            _historyListWidget(),//历史记录
          ],
        ),
      ),
    );
  }
}