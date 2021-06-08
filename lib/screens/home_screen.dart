import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                  print("Button pressed! Now go fetch the APIs");
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
