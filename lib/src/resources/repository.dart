import 'package:flutter_tasks/src/models/repo_list_model.dart';

import 'repo_provider.dart';

class Repository {
  final repoProvider = RepoProvider();

  Future<RepoListModel> searchRepos(searchString, page) =>
      repoProvider.fetchRepos(searchString, page);
}
