import 'package:flutter/cupertino.dart';
import 'package:flutter_tasks/src/models/repo_list_model.dart';
import 'package:flutter_tasks/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class RepoBloc {
  // API call
  final _repository = Repository();

  // controllers
  final _repoListController = PublishSubject<RepoListModel>();
  final ScrollController _scrollController = ScrollController();

  // attributes
  int _page = 1;
  String _searchString = "";

  // constructor
  RepoBloc({
    required searchString,
  }) {
    _searchString = searchString;

    _scrollController.addListener(
      () {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          print("reached the bottom");
          searchRepos();
        }
      },
    );
    searchRepos();
  }

  searchRepos() async {
    print("Page: $_page");
    RepoListModel repoList =
        await _repository.searchRepos(_searchString, _page);
    _repoListController.sink.add(repoList);

    print("RepoController ${_repoListController.single.toString()}");

    _page++;
  }

  // gets
  Stream<RepoListModel> get allRepos => _repoListController.stream;
  int get page => _page;
  String get searchString => _searchString;
  ScrollController get scrollController => _scrollController;

  dispose() {
    _repoListController.close();
    _scrollController.dispose();
  }
}

// final repoBloc = RepoBloc();
