import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:github_thing/screen/user_details_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  void submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) =>
              UserDetailsScreen(username: _usernameController.text)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(
            left: 30,
            right: 30,
            bottom: 20,
            top: 70,
            // MediaQuery.of(context).size.height * 0.3
          ),
          child: Column(
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    const Text("This is definitely github"),
                    const SizedBox(
                      height: 50,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.pink[50],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        controller: _usernameController,
                        style: TextStyle(color: Colors.pink[300]),
                        validator: (value) {
                          if (value!.isEmpty && value.length < 5) {
                            return "Username not found";
                          }
                        },
                        onFieldSubmitted: (context) {
                          submit();
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          hintStyle: TextStyle(color: Colors.pink[200]),
                          hintText: "Enter Your Github Username",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.blue[500],
                      ),
                      child: TextButton(
                        onPressed: () {
                          submit();
                        },
                        child: const Text(
                          "Check",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
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
