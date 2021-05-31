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
  final ScrollController _scrollController = ScrollController();
  int page = 1;

  @override
  void initState() {
    super.initState();
    repoBloc.searchRepos(widget.searchString, page);
    _scrollController.addListener(
      () {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          print("adding page");
          setState(() {
            page++;
            repoBloc.searchRepos(widget.searchString, page);
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    // repoBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Please work ${widget.searchString} $page'),
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
      itemCount: snapshot.data!.repos.length,
      controller: _scrollController,
      itemBuilder: (context, index) {
        Repo item = snapshot.data!.repos[index];

        if (index == snapshot.data!.repos.length) {
          print("Im in");
          return const CupertinoActivityIndicator();
        }

        return ListTile(
          title: Text("${item.name} ${item.id}"),
          trailing: Text('$index'),
        );
      },
    );
  }
}
