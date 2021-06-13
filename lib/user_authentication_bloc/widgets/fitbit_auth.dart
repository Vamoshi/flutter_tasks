import 'package:flutter/material.dart';
import 'package:flutter_tasks/user_authentication_bloc/bloc/user_authentication_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FitbitAuth extends StatefulWidget {
  FitbitAuth({Key? key}) : super(key: key);

  @override
  _FitbitAuthState createState() => _FitbitAuthState();
}

class _FitbitAuthState extends State<FitbitAuth> {
  late UserAuthenticationBloc _authBloc;

  @override
  void initState() {
    super.initState();
    _authBloc = context.read<UserAuthenticationBloc>();
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
              "You're almost there!",
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
                onPressed: () {
                  _authBloc.add(AttemptedFitbitAuthorization());
                },
                child: Text(
                  "Log in to Fitbit",
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
