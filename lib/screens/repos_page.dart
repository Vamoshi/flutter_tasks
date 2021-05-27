import 'package:flutter/cupertino.dart';
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
    print("adding page");
    page = page + 1;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.searchString),
        centerTitle: true,
        backgroundColor: Colors.pink[300],
      ),
      body: FutureBuilder<List<Repo>>(
        future: getRepoList(widget.searchString, page),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // List builder here
            final repos = snapshot.data;

            for (var i = 0; i < repos!.length; i++) {
              _repoList.add(repos[i]);
            }

            print("repos length: " + _repoList.length.toString());

            return ListView.builder(
              controller: _scrollController,
              itemCount: _repoList.length + 1,
              itemBuilder: (context, index) {
                if (index == _repoList.length) {
                  return CupertinoActivityIndicator();
                }

                return ListTile(
                  title: Text(_repoList[index].id.toString()),
                  trailing: Text((index + 1).toString()),
                );
              },
            );
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return const Text("An error has occured");
          }
          return Container(
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }
}
