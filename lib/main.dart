import "package:flutter/material.dart";
// ignore: import_of_legacy_library_into_null_safe
import './random_words.dart';

void main() => runApp(MyApp());

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.pink[100]),
      home: RandomWords(),
    );
  }
}
