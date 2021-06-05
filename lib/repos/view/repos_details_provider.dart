import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tasks/repos/bloc/repos_bloc.dart';
import 'package:flutter_tasks/repos/view/repos_details_screen.dart';
import 'package:flutter_tasks/user/bloc/user_bloc.dart';
import 'package:http/http.dart' as http;

class ReposDetailsProvider extends StatefulWidget {
  ReposDetailsProvider({Key? key}) : super(key: key);

  @override
  _ReposDetailsProviderState createState() => _ReposDetailsProviderState();
}

class _ReposDetailsProviderState extends State<ReposDetailsProvider> {
  @override
  Widget build(BuildContext context) {
    ReposBloc reposBloc = BlocProvider.of<ReposBloc>(context);

    return Scaffold(
      body: BlocProvider(
        create: (context) =>
            UserBloc(http.Client(), reposBloc.state.repo.ownerId)
              ..add(
                UserFetched(),
              ),
        child: ReposDetailsScreen(),
      ),
    );
  }
}
