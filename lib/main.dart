import 'package:flutter/material.dart';
import 'package:github_thing_2/screens/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Github Thing 2",
      theme: ThemeData(
          primarySwatch: Colors.pink,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: HomePage(),
      // Scaffold(
      //   appBar: AppBar(
      //     title: const Text("This is the appbar title "),
      //   ),
      //   body: Text("This is body Text"),
    );
  }
}
