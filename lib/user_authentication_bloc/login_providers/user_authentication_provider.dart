import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tasks/user_authentication_bloc/bloc/user_authentication_bloc.dart';
import 'package:flutter_tasks/user_authentication_bloc/screens/login_screen.dart';

class UserAuthenticationProvider extends StatelessWidget {
  const UserAuthenticationProvider({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => UserAuthenticationBloc()
          ..add(
            AttemptedLogin(email: "", password: ""),
          ),
        child: const LoginScreen(),
      ),
    );
  }
}
