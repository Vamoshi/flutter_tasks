import "package:flutter/material.dart";
import 'package:github_thing_2/screens/repos_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchStringController = TextEditingController();
  final GlobalKey<FormState> _searchKey = GlobalKey();

  void submit() {
    if (!_searchKey.currentState!.validate()) {
      return;
    }

    print("It's valid!");

    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) =>
              ReposPage(searchString: _searchStringController.text)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Github Repos"),
        centerTitle: true,
        backgroundColor: Colors.pink[300],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(
            right: 20,
            left: 20,
            top: (height / 2.9) - 20,
            bottom: 30,
          ),
          child: Form(
            key: _searchKey,
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue[50],
                  ),
                  child: TextFormField(
                    controller: _searchStringController,
                    style: TextStyle(
                      color: Colors.blue[500],
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
                      hintStyle: TextStyle(color: Colors.blue[300]),
                      contentPadding: const EdgeInsets.all(10),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.pink[300],
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
