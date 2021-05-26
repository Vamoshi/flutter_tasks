import "package:flutter/material.dart";
import 'package:github_thing_2/providers/repo_provider.dart';
import 'package:provider/provider.dart';

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
  var _init = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_init) {
      setState(() {
        _isLoading = true;
      });
    }

    print("repos_page");

    Provider.of<RepoProvider>(context)
        .getRepoList(widget.searchString)
        .then((_) => {setState(() => _isLoading = false)});

    _init = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.searchString),
        centerTitle: true,
        backgroundColor: Colors.pink[500],
      ),
      body: _isLoading
          ? Center(
              child: const CircularProgressIndicator(),
            )
          : Container(
              child: Column(
                children: <Widget>[
                  Text("Field 1 goes here"),
                  Text("Field 2 goes here"),
                  Text("Field 3 goes here"),
                ],
              ),
            ),
    );
  }
}
