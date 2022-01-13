import 'package:flutter/material.dart';
import 'package:flutter_jd/pages/tabs/Tabs.dart';
import 'package:flutter_jd/routers/router.dart';

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
    return MaterialApp(
      initialRoute: '/',
      onGenerateRoute: onGenerateRoute,
    );
  }
}