import 'package:flutter/material.dart';
import 'package:github_thing_2/providers/repo_provider.dart';
import 'package:github_thing_2/screens/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RepoProvider(),
      child: MaterialApp(
        title: "Github Thing 2",
        theme: ThemeData(
            primarySwatch: Colors.pink,
            visualDensity: VisualDensity.adaptivePlatformDensity),
        home: const HomePage(),
        // Scaffold(
        //   appBar: AppBar(
        //     title: const Text("This is the appbar title "),
        //   ),
        //   body: Text("This is body Text"),
      ),
    );
  }
}
