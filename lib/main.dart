import 'dart:io';

import 'package:flutter/material.dart';
import 'homePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  late File image;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image to Text Converter',

      home: homePage(),
    );
  }
}

