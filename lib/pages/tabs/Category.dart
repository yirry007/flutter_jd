import 'package:flutter/material.dart';
import 'package:flutter_jd/services/ScreenAdapter.dart';

class CategoryPage extends StatefulWidget {
  CategoryPage({Key? key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  int _selectIndex = 0;

  @override
  Widget build(BuildContext context) {
    double leftWidth = ScreenAdapter.getScreenWidth() / 4;
    double sideSeparator = 10;
    double separator = 10;
    double textHeight = ScreenAdapter.height(28);
    double rightItemWidth = (ScreenAdapter.getScreenWidth() - sideSeparator * 2 - separator * 2) / 3;
    rightItemWidth = ScreenAdapter.width(rightItemWidth);
    double rightItemHeight = rightItemWidth + textHeight;

    return Row(
      children: <Widget>[
        Container(
          width: leftWidth,
          height: double.infinity,
          child: ListView.builder(
            itemCount: 30,
            itemBuilder: (context, index){
              return Column(
                children: <Widget>[
                  InkWell(
                    onTap: (){
                      setState(() {
                        _selectIndex = index;
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      height: ScreenAdapter.height(56),
                      color: _selectIndex == index ? Colors.red : Colors.white,
                      child: Text(
                        '第${index}项',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: _selectIndex == index ? Colors.white : Colors.black54,
                        ),
                      ),
                    ),
                  ),
                  Divider(),
                ],
              );
            },
          ),
        ),
        Expanded(
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
              itemCount: 18,
              itemBuilder: (context, index){
                return Container(
                  child: Column(
                    children: <Widget>[
                      AspectRatio(
                        aspectRatio: 1/1,
                        child: Image.network('https://www.itying.com/images/flutter/list8.jpg', fit: BoxFit.cover),
                      ),
                      Container(
                        height: textHeight,
                        child: Text('女装'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}