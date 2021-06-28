import 'dart:async';
import 'package:flutter/material.dart';
import 'package:match_the_picture/home_page.dart';

import 'data/data.dart';
import 'models/TileModel.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
  }
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Match The Picture',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}






