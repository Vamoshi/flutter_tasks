import 'package:flutter_tasks/repos/models/repo_model.dart';
import 'package:flutter_tasks/repos/data/repo_provider.dart';

class Repository {
  final repoProvider = RepoProvider();

  Future<List<Repo>> fetchRepos(searchString, page) =>
      repoProvider.fetchRepos(searchString, page);
}
