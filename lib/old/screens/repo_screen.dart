import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tasks/old/blocs/repo_bloc.dart';
import 'package:flutter_tasks/old/models/repo_list_model.dart';
import 'package:flutter_tasks/old/models/repo_model.dart';

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
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    repoBloc = RepoBloc(searchString: widget.searchString);

    _scrollController.addListener(
      () {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          repoBloc.searchRepos();
        }
      },
    );
  }

  @override
  void dispose() {
    repoBloc.dispose();
    _scrollController.dispose();
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
    return ListView.separated(
      itemCount: snapshot.data!.repos.length + 1,
      separatorBuilder: (BuildContext context, int index) => const Divider(),
      controller: _scrollController,
      itemBuilder: (context, index) {
        const double padding = 5;

        if (index == snapshot.data!.repos.length) {
          return Container(
              padding: const EdgeInsets.all(padding),
              child: const CupertinoActivityIndicator());
        }

        Repo item = snapshot.data!.repos[index];
        return ListTile(
          title: Text("${item.name} ${item.id}"),
          trailing: Text('${index + 1}'),
        );
      },
    );
  }
}
