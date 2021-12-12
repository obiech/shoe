import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shoe/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setEnabledSystemUIOverlays(overlays:)
    return MaterialApp(
      
      title: 'Flutter Shoes',
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
