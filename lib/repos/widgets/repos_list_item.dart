import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tasks/repos/bloc/repos_bloc.dart';
import 'package:flutter_tasks/repos/models/repos_model.dart';
import 'package:flutter_tasks/repos/view/repos_details_provider.dart';

class ReposListItem extends StatefulWidget {
  const ReposListItem({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  _ReposListItemState createState() => _ReposListItemState();
}

class _ReposListItemState extends State<ReposListItem> {
  late ReposBloc reposBloc;

  @override
  void initState() {
    super.initState();
    reposBloc = context.read<ReposBloc>();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BlocBuilder<ReposBloc, ReposState>(
      builder: (context, state) {
        Repos repo = state.repos[widget.index];

        return ListTile(
          leading: Text(
            '${repo.id}',
            style: textTheme.caption,
          ),
          title: Text(repo.name),
          trailing: Text((widget.index + 1).toString()),
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
      },
    );
  }
}
