import 'package:flutter/material.dart';
import 'package:flutter_tasks/src/screens/home.dart';

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        body: HomePage(),
      ),
    );
  }
}
