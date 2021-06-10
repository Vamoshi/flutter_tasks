import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tasks/profile_bloc/bloc/profile_bloc.dart';
import 'package:flutter_tasks/profile_bloc/screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        switch (state.status) {
          case ProfileStatus.initial:
            return Center(child: CircularProgressIndicator());
          case ProfileStatus.failure:
            return Center(
              child: Text("Something went wrong. Please try again"),
            );
          case ProfileStatus.success:
            return ProfileScreen();
        }
      },
    );
  }
}
