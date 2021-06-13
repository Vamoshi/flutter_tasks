import 'package:flutter/material.dart';
import 'package:flutter_tasks/user_authentication_bloc/login_providers/user_authentication_provider.dart';

class RegisterSuccess extends StatefulWidget {
  RegisterSuccess({Key? key}) : super(key: key);

  @override
  _RegisterSuccessState createState() => _RegisterSuccessState();
}

class _RegisterSuccessState extends State<RegisterSuccess> {
  void toLoginScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => UserAuthenticationProvider(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final window = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: window.height / 3.1),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              bottom: 40,
              right: 10,
              left: 10,
            ),
            child: Text(
              "Congratulations!",
              style: TextStyle(fontSize: 45, shadows: [
                Shadow(
                  blurRadius: 5,
                  color: Colors.yellow,
                  offset: Offset(0, 0),
                )
              ]),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              bottom: 40,
              left: 2,
              right: 2,
            ),
            child: Text(
              "Your account has been successfully created!",
              style: TextStyle(fontSize: 30, shadows: [
                Shadow(
                  blurRadius: 5,
                  color: Colors.yellow,
                  offset: Offset(0, 0),
                )
              ]),
              textAlign: TextAlign.center,
            ),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 20),
              height: window.height / 15,
              width: window.width * 0.85,
              decoration: BoxDecoration(
                color: Colors.green[400],
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green,
                    blurRadius: 15,
                    spreadRadius: 1,
                    offset: Offset(0, 0),
                  )
                ],
              ),
              child: TextButton(
                onPressed: toLoginScreen,
                child: Text(
                  "Click here to log in!",
                  style: TextStyle(
                    fontSize: window.width / 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
