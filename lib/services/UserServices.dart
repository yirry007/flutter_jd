import 'dart:convert';

import 'package:flutter_jd/services/Storage.dart';

class UserServices{
  static getUserInfo() async{
    List userInfo = [];
    String? userInfoData = await Storage.getString('userInfo');

    if (userInfoData != null) {
      userInfo = json.decode(userInfoData);
    }

    return userInfo;
  }

  static getUserState() async{
    bool auth = false;
    List userInfo = await UserServices.getUserInfo();

    if (userInfo.length > 0 && userInfo[0]['username'] != '') {
      auth = true;
    }

    return auth;
  }

  static logout(){
    Storage.remove('userInfo');
  }
}