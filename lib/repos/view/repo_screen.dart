import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tasks/repos/bloc/repos_bloc.dart';
import 'package:flutter_tasks/repos/view/repo_list.dart';
import 'package:http/http.dart' as http;

class RepoScreen extends StatelessWidget {
  const RepoScreen({Key? key, required this.searchString}) : super(key: key);

  final String searchString;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "${searchString[0].toUpperCase()}${searchString.substring(1)}"),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (_) => ReposBloc(http.Client(), searchString),
        child: const RepoList(),
      ),
    );
  }
}
