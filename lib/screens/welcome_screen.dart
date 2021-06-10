import 'package:flutter/material.dart';
import 'package:flutter_tasks/profile_bloc/bloc_providers/profile_provider.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final window = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: window.height / 8,
          right: window.width / 10,
          left: window.width / 10,
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                bottom: 70,
              ),
              child: Text(
                "Exercise Made More Enjoyable",
                style: TextStyle(fontSize: window.width / 15, shadows: [
                  Shadow(
                    blurRadius: 5,
                    color: Colors.yellow,
                    offset: Offset(0, 0),
                  )
                ]),
              ),
            ),
            Container(
              child: ClipOval(
                child: Image.asset('assets/images/running.jpg'),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 130),
              height: window.height / 15,
              width: window.width / 2,
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfileProvider(),
                    ),
                  );
                },
                child: Text(
                  "Get Started",
                  style: TextStyle(
                    fontSize: window.width / 20,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
