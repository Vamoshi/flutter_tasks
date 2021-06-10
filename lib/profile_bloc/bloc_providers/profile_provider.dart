import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tasks/profile_bloc/bloc/profile_bloc.dart';
import 'package:flutter_tasks/screens/home_screen.dart';

class ProfileProvider extends StatelessWidget {
  const ProfileProvider({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => ProfileBloc()..add(ProfileFetched()),
        child: const HomeScreen(),
      ),
    );
  }
}
