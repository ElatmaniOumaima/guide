import 'package:flutter/material.dart';
import 'package:guide/myApp.dart';

void main() {
  runApp(myApp());
}

class myApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),

    );
  }
}
