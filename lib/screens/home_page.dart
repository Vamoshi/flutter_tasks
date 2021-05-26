import "package:flutter/material.dart";
import 'package:github_thing_2/screens/repos_page.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  TextEditingController _searchString = TextEditingController();
  final GlobalKey<FormState> _searchKey = GlobalKey();

  void submit() {
    if (!_searchKey.currentState!.validate()) {
      return;
    }

    print("It's valid!");

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ReposPage(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Github Repos"),
        centerTitle: true,
        backgroundColor: Colors.grey[300],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(
            right: 20,
            left: 20,
            top: 80,
            bottom: 30,
          ),
          child: Form(
            key: _searchKey,
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.pink[50],
                  ),
                  child: TextFormField(
                    controller: _searchString,
                    style: TextStyle(
                      color: Colors.pink[500],
                    ),
                    onFieldSubmitted: (context) {
                      print("context");
                      submit();
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please type something.";
                      }
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Look for Repos",
                      hintStyle: TextStyle(color: Colors.pink[200]),
                      contentPadding: const EdgeInsets.all(10),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[500],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                    child: const Text("Search"),
                    onPressed: () {
                      submit();
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
