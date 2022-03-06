import 'dart:convert';
import 'package:crypto/crypto.dart';

class SignService{
  static getSign(json){
    Map addressListAttr = {
      "uid": "1",
      "age": 10,
      "salt": "xxxxxxxxxxxxxxxxxxxxxxxxx",
    };

    List attrKeys = addressListAttr.keys.toList();
    attrKeys.sort();

    String str = '';
    for (int i=0;i<attrKeys.length;i++) {
      str += '${attrKeys[i]}${addressListAttr[attrKeys[i]]}';
    }

    print(md5.convert(utf8.encode(str)));
  }
}