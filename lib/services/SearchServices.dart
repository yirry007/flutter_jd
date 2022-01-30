import 'dart:convert';

import 'Storage.dart';

class SearchServices {
  static setHistoryData(keywords) async {
    String? searchList = await Storage.getString('searchList');

    if (searchList != null) {
      List searchListData = json.decode(searchList);
      var hasData = searchListData.any((v) {
        //判断已存储的数据中是否包含即将要存储的数据
        return v == keywords;
      });

      if (!hasData) {
        //假如没有当前搜索词，则直接放入到数组中，并保存起来
        searchListData.add(keywords);
        await Storage.setString('searchList', json.encode(searchListData));
      }
    } else {
      //假如没有搜索记录，则新创建数组，把搜索词放入数组中，然后保存起来
      List tempList = [];
      tempList.add(keywords);
      await Storage.setString('searchList', json.encode(tempList));
    }
  }

  static getHistoryList() async{
    String? searchList = await Storage.getString('searchList');

    if (searchList != null) {
      List searchListData = json.decode(searchList);
      return searchListData;
    }
    return [];
  }

  static clearHistoryList() async{
    await Storage.remove('searchList');
  }

  static removeHistoryData(keywords) async{
    String? searchList = await Storage.getString('searchList');
    if (searchList != null) {
      List searchListData = json.decode(searchList);
      searchListData.remove(keywords);
      await Storage.setString('searchList', json.encode(searchListData));
    }
  }
}
