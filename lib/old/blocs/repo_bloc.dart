import 'package:flutter_tasks/old/models/repo_list_model.dart';
import 'package:flutter_tasks/old/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class RepoBloc {
  // API call
  final _repository = Repository();

  // controllers
  final _repoListController = PublishSubject<RepoListModel>();

  // attributes
  int _page = 1;
  String _searchString = "";
  final RepoListModel _repoList = RepoListModel();

  // constructor
  RepoBloc({
    required searchString,
  }) {
    _searchString = searchString;

    searchRepos();
  }

  searchRepos() async {
    print("Page: $_page");

    // Add to bloc's repoList
    _repoList.addRepos(await _repository.searchRepos(_searchString, _page));
    // Add to sink
    _repoListController.sink.add(_repoList);
    // Increment page
    _page++;
  }

  // gets
  Stream<RepoListModel> get allRepos => _repoListController.stream;
  int get page => _page;
  String get searchString => _searchString;

  dispose() {
    _repoListController.close();
  }
}

// final repoBloc = RepoBloc();
