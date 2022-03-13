import 'dart:convert';
import 'package:crypto/crypto.dart';

class SignService{
  static getSign(json){
    List attrKeys = json.keys.toList();
    attrKeys.sort();

    String str = '';
    for (int i=0;i<attrKeys.length;i++) {
      str += '${attrKeys[i]}${json[attrKeys[i]]}';
    }

    return md5.convert(utf8.encode(str)).toString();
  }
}