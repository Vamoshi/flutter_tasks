import "package:flutter/material.dart";
import 'package:flutter_tasks/src/screens/repo_screen.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final TextEditingController _searchString = TextEditingController();
  final GlobalKey<FormState> _searchKey = GlobalKey();

  void submit() {
    if (!_searchKey.currentState!.validate()) {
      return;
    }

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => RepoList(searchString: _searchString.text),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Github Repos"),
        centerTitle: true,
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
                    color: Colors.white,
                  ),
                  child: TextFormField(
                    controller: _searchString,
                    onFieldSubmitted: (context) {
                      submit();
                    },
                    style: const TextStyle(color: Colors.black),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please type something.";
                      }
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Look for Repos",
                      hintStyle: const TextStyle(color: Colors.black38),
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
                    child: const Text(
                      "Search",
                      style: TextStyle(color: Colors.white),
                    ),
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
