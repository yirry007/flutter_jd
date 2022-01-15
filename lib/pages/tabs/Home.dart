import 'package:flutter/material.dart';
import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';
import 'package:flutter_jd/services/ScreenAdapter.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget _swiperWidget(){
    List<Map> imgList = [
      {"url": 'https://www.itying.com/images/flutter/slide01.jpg'},
      {"url": 'https://www.itying.com/images/flutter/slide02.jpg'},
      {"url": 'https://www.itying.com/images/flutter/slide03.jpg'},
    ];

    return Container(
      child: AspectRatio(
        aspectRatio: 2/1,
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return Image.network(
              imgList[index]['url'],
              fit: BoxFit.fill,
            );
          },
          autoplay: true,
          itemCount: imgList.length,
          pagination: SwiperPagination(),
        )
      ),
    );
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
    return Container(
      height: ScreenAdapter.height(234),
      padding: EdgeInsets.all(ScreenAdapter.height(20)),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index){
          return Column(
            children: <Widget>[
              Container(
                width: ScreenAdapter.height(140),
                height: ScreenAdapter.height(140),
                margin: EdgeInsets.only(right: ScreenAdapter.width(21)),
                child: Image.network('https://www.itying.com/images/flutter/hot${index+1}.jpg', fit: BoxFit.cover),
              ),
              Container(
                height: ScreenAdapter.height(44),
                padding: EdgeInsets.only(top: ScreenAdapter.height(10)),
                child: Text('第${index+1}条'),
              ),
            ],
          );
        },
        itemCount: 10,
      ),
    );
  }

  Widget _recProductItemWidget(){
    var itemWidth = (ScreenAdapter.getScreenWidth() - 30) / 2;

    return Container(
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
              child: Image.network('https://www.itying.com/images/flutter/list1.jpg', fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: ScreenAdapter.height(20)),
            child: Text(
              '2019夏季新款气质高贵洋气阔太太有女人味中长款松大码',
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
                  child: Text('￥188.0', style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  )),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text('￥198.0', style: TextStyle(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        _swiperWidget(),
        
        SizedBox(height: ScreenAdapter.height(20)),
        _titleWidget('猜你喜欢'),

        SizedBox(height: ScreenAdapter.height(20)),
        _hotProductListWidget(),

        _titleWidget('热门推荐'),

        Container(
          padding: EdgeInsets.all(10),
          child: Wrap(
            spacing: 10,//元素在主轴上的间距
            runSpacing: 10,//元素在交叉轴上的间距
            children: <Widget>[
              _recProductItemWidget(),
              _recProductItemWidget(),
              _recProductItemWidget(),
              _recProductItemWidget(),
              _recProductItemWidget(),
              _recProductItemWidget(),
              _recProductItemWidget(),
              _recProductItemWidget(),
            ],
          ),
        ),
      ],
    );
  }
}