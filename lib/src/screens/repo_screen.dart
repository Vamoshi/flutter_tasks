import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tasks/src/blocs/repo_bloc.dart';
import 'package:flutter_tasks/src/models/repo_list_model.dart';
import 'package:flutter_tasks/src/models/repo_model.dart';

class RepoList extends StatefulWidget {
  final String searchString;
  const RepoList({
    Key? key,
    required this.searchString,
  }) : super(key: key);

  @override
  _RepoListState createState() => _RepoListState();
}

class _RepoListState extends State<RepoList> {
  late RepoBloc repoBloc;

  @override
  void initState() {
    super.initState();
    repoBloc = RepoBloc(searchString: widget.searchString);
  }

  @override
  void dispose() {
    repoBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "${repoBloc.searchString[0].toUpperCase()}${repoBloc.searchString.substring(1)}"),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: repoBloc.allRepos,
        builder: (context, AsyncSnapshot<RepoListModel> snapshot) {
          if (snapshot.hasData) {
            return _buildList(snapshot);
          } else if (snapshot.hasError) {
            return const Text("Something went wrong");
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget _buildList(AsyncSnapshot<RepoListModel> snapshot) {
    return ListView.builder(
      itemCount: snapshot.data!.repos.length + 1,
      controller: repoBloc.scrollController,
      itemBuilder: (context, index) {
        Repo item = snapshot.data!.repos[index];

        print(index == snapshot.data!.repos.length);

        if (index == snapshot.data!.repos.length) {
          print("Im in");
          return const CupertinoActivityIndicator();
        }

        return ListTile(
          title: Text("${item.name} ${item.id}"),
          trailing: Text('${index + 1}'),
        );
      },
    );
  }
}
