import "package:flutter/material.dart";
import 'package:github_thing_2/models/repo.dart';
import 'package:github_thing_2/providers/repo_provider.dart';

class ReposPage extends StatefulWidget {
  final String searchString;
  const ReposPage({
    Key? key,
    required this.searchString,
  }) : super(key: key);

  @override
  _ReposPageState createState() => _ReposPageState();
}

class _ReposPageState extends State<ReposPage> {
  final ScrollController _scrollController = ScrollController();
  var _repoList = [];
  int page = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreRepos();
      }
    });
  }

  _getMoreRepos() {
    page = page + 1;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.searchString),
        centerTitle: true,
        backgroundColor: Colors.pink[500],
      ),
      body: FutureBuilder<List<Repo>>(
        future: getRepoList(widget.searchString, page),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // List builder here
            final repos = snapshot.data;
            _repoList = [...repos!];
            return ListView.builder(
              itemCount: _repoList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_repoList[index].id.toString()),
                  trailing: Text((index + 1).toString()),
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Text("An error has occured");
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
