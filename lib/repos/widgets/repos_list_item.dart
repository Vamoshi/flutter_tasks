import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tasks/repos/bloc/repos_bloc.dart';
import 'package:flutter_tasks/repos/models/repos_model.dart';
import 'package:flutter_tasks/repos/view/repos_details_provider.dart';

class ReposListItem extends StatelessWidget {
  const ReposListItem({Key? key, required this.repo, required this.index})
      : super(key: key);

  final Repos repo;
  final int index;

  @override
  Widget build(BuildContext context) {
    ReposBloc reposBloc = BlocProvider.of<ReposBloc>(context);
    final textTheme = Theme.of(context).textTheme;

    return ListTile(
      leading: Text(
        '${repo.id}',
        style: textTheme.caption,
      ),
      title: Text(repo.name),
      trailing: Text((index + 1).toString()),
      isThreeLine: true,
      subtitle: Text(repo.language),
      dense: true,
      onTap: () {
        // Add event to bloc that a repo has been chosen
        reposBloc.add(ReposChosen(repo: repo));

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: reposBloc,
              child: ReposDetailsProvider(),
            ),
          ),
        );
      },
    );
  }
}
