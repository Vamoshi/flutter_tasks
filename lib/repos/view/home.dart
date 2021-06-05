import "package:flutter/material.dart";
import 'package:flutter_tasks/repos/view/repos_provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  final TextEditingController _searchString = TextEditingController();
  final GlobalKey<FormState> _searchKey = GlobalKey();

  void submit() {
    if (!_searchKey.currentState!.validate()) {
      return;
    }

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => RepoProvider(searchString: _searchString.text),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final window = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(
            right: 20,
            left: 20,
            top: window.height * 0.1,
            bottom: 30,
          ),
          child: Column(
            children: [
              Image.asset(
                'assets/images/github.png',
                height: 280,
              ),
              SizedBox(
                height: 30,
              ),
              Form(
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
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Look for Repos",
                          hintStyle: TextStyle(color: Colors.black38),
                          contentPadding: EdgeInsets.all(10),
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
            ],
          ),
        ),
      ),
    );
  }
}
