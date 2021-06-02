import 'package:flutter/material.dart';
import 'package:flutter_tasks/repos/models/repo_model.dart';

class RepoListItem extends StatelessWidget {
  const RepoListItem({Key? key, required this.repo}) : super(key: key);

  final Repo repo;

  @override
  Widget build(BuildContext context) {
    print("Repo Name ${repo.name}");

    final textTheme = Theme.of(context).textTheme;
    return ListTile(
      leading: Text(
        '${repo.id}',
        style: textTheme.caption,
      ),
      title: Text(repo.name),
      isThreeLine: true,
      subtitle: Text(repo.description),
      dense: true,
    );
  }
}
