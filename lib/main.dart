import 'package:flutter/material.dart';
import 'package:sqlflite_flutter/home2.dart';
import 'package:sqlflite_flutter/homeScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    debugShowCheckedModeBanner: false,
      home:  HomeScreen2(),
    );
  }
}
