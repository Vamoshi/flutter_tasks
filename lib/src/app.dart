import 'package:flutter/material.dart';
import 'package:flutter_tasks/src/ui/home.dart';
import 'package:flutter_tasks/src/ui/repo_list.dart';

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
