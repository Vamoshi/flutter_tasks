import 'package:flutter/material.dart';
import 'package:github_thing/providers/user_provider.dart';
import 'package:github_thing/screen/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(GithubThing());
}

class GithubThing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserProvider(),
      child: MaterialApp(
        title: "Github Thang",
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
