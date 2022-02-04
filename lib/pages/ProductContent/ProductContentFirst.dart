import 'package:flutter/material.dart';
import 'package:flutter_jd/config/Api.dart';
import 'package:flutter_jd/model/ProductContentModel.dart';
import 'package:flutter_jd/services/ScreenAdapter.dart';
import 'package:flutter_jd/widget/MainButton.dart';

class ProductContentFirst extends StatefulWidget {
  ProductContentItem? productContentData;
  ProductContentFirst({Key? key, this.productContentData}) : super(key: key);

  @override
  State<ProductContentFirst> createState() => _ProductContentFirstState();
}

class _ProductContentFirstState extends State<ProductContentFirst> with AutomaticKeepAliveClientMixin {
  ProductContentItem? _productCotent;
  List<Attr>? _attr = [];

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    _productCotent = widget.productContentData;
    _attr = widget.productContentData?.attr;
  }

  _attrBottomSheet(){
    showModalBottomSheet(
      context: context,
      builder: (context){
        return Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              child: ListView(
                children: _attr!.map((attrItem){
                  return Column(
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: ScreenAdapter.width(150),
                            padding: EdgeInsets.only(top: 22),
                            alignment: Alignment.center,
                            child: Text('${attrItem.cate}： ', style: TextStyle(
                              fontWeight: FontWeight.bold
                            )),
                          ),
                          Expanded(
                            flex: 1,
                            child: Wrap(
                              children: attrItem.list!.map((value){
                                return Container(
                                  margin: EdgeInsets.fromLTRB(8, 4, 8, 4),
                                  child: Chip(
                                    label: Text('${value}'),
                                    padding: EdgeInsets.all(10),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                    ],
                  );
                }).toList(),
              ),
            ),
            Positioned(
              bottom: 0,
              width: ScreenAdapter.getScreenWidth(),
              height: ScreenAdapter.height(100),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                      child: MainButton(
                        color: Color.fromRGBO(253, 1, 0, 0.9),
                        text: '加入购物车',
                        onTap: (){
                          print('加入购物车');
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                      child: MainButton(
                        color: Color.fromRGBO(253, 165, 0, 0.9),
                        text: '立即购买',
                        onTap: (){
                          print('立即购买');
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String? imagePath = _productCotent?.pic;
    String path = Api.Host + imagePath!.replaceAll('\\', '/');

    return Container(
      padding: EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 1/1,
            child: Image.network('${path}', fit: BoxFit.cover),
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Text('${_productCotent?.title}', style: TextStyle(
              color: Colors.black87,
              fontSize: ScreenAdapter.size(36),
            )),
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Text('${_productCotent?.subTitle}', style: TextStyle(
              color: Colors.black54,
              fontSize: ScreenAdapter.size(28),
            )),
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text('特价:'),
                    Text('￥${_productCotent?.price}', style: TextStyle(
                      color: Colors.red,
                      fontSize: ScreenAdapter.size(48),
                    )),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text('原价:'),
                    Text('￥${_productCotent?.oldPrice}',style: TextStyle(
                      color: Colors.black38,
                      fontSize: ScreenAdapter.size(28),
                      decoration: TextDecoration.lineThrough,
                    )),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Container(
            height: ScreenAdapter.height(80),
            child: InkWell(
              onTap: (){
                _attrBottomSheet();
              },
              child: Row(
                children: <Widget>[
                  Text('已选', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(width: 10),
                  Text('115, 黑色, XL, 1件'),
                ],
              ),
            ),
          ),
          Divider(),
          Container(
            height: ScreenAdapter.height(80),
            child: Row(
              children: <Widget>[
                Text('运费', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(width: 10),
                Text('免运费'),
              ],
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}