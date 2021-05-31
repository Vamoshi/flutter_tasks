import 'package:flutter_tasks/src/models/repo_list_model.dart';
import 'package:flutter_tasks/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class RepoBloc {
  final _repository = Repository();
  final _streamController = PublishSubject<RepoListModel>();

  Stream<RepoListModel> get allRepos => _streamController.stream;

  searchRepos(searchString, page) async {
    RepoListModel repoList = await _repository.searchRepos(searchString, page);

    print("Repos ${repoList.repos.length}");

    _streamController.sink.add(repoList);
  }

  dispose() {
    _streamController.close();
  }
}

final repoBloc = RepoBloc();
