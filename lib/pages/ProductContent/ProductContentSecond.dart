import 'package:flutter/material.dart';
import 'package:flutter_jd/model/ProductContentModel.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_jd/widget/LoadingWidget.dart';

class ProductContentSecond extends StatefulWidget {
  ProductContentItem? productContentData;
  ProductContentSecond({Key? key, this.productContentData}) : super(key: key);

  @override
  State<ProductContentSecond> createState() => _ProductContentSecondState();
}

class _ProductContentSecondState extends State<ProductContentSecond> with AutomaticKeepAliveClientMixin {
  bool _flag = true;
  String? _id;

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    _id = widget.productContentData?.sId;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _flag ? LoadingWidget() : Text(''),
          Expanded(
            child: InAppWebView(
              initialUrlRequest: URLRequest(
                url: Uri.parse('https://jdmall.itying.com/pcontent?id=${_id}'),
              ),
              onProgressChanged: (InAppWebViewController controller, int progress){
                print(progress / 100);
                if (progress / 100 > 0.9999) {
                  setState(() {
                    _flag = false;
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}