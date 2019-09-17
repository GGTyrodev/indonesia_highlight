import 'package:flutter/material.dart';
import 'package:indonesia_highlight/homepage.dart';

class IndonesiaHighlightApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Indonesia Highlight",
      initialRoute: '/home',
      routes: {
        "/": (context) => HomePage(),
        "/home": (context) => HomePage(),
      },
    );
  }
}
