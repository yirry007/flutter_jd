import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenAdapter{
  static height(num val){
    return ScreenUtil().setHeight(val);
  }

  static width(num val){
    return ScreenUtil().setWidth(val);
  }

  static size(num val){
    return ScreenUtil().setSp(val);
  }

  static getScreenWidth(){
    return ScreenUtil().screenWidth;
  }

  static getScreenHeight(){
    return ScreenUtil().screenHeight;
  }
}