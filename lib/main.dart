import 'package:flutter/material.dart';
import 'package:flutter_jd/routers/router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(JD());
}

class JD extends StatefulWidget {
  JD({Key? key}) : super(key: key);

  @override
  _JDState createState() => _JDState();
}

class _JDState extends State<JD> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(750, 1334),//配置设计稿的宽度高度
      builder: () => MaterialApp(
        initialRoute: '/',
        onGenerateRoute: onGenerateRoute,
        builder: (context, widget) {
          ScreenUtil.setContext(context);
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: widget!,
          );
        },
      ),
    );
  }
}