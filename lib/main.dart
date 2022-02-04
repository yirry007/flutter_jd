import 'package:flutter/material.dart';
import 'package:flutter_jd/routers/router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'colors.dart';

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
      designSize: Size(720, 1520),//配置设计稿的宽度高度
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        onGenerateRoute: onGenerateRoute,
        theme: ThemeData(
          //primarySwatch: primaryWhite,
          primarySwatch: Colors.amber,
        ),
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