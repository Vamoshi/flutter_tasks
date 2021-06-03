// Flutter
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

// Components
import 'package:flutter_tasks/repos/widgets/bottom_loader.dart';
import 'package:flutter_tasks/repos/widgets/repo_list_item.dart';
import 'package:flutter_tasks/repos/bloc/repos_bloc.dart';

class RepoList extends StatefulWidget {
  const RepoList({Key? key}) : super(key: key);

  @override
  _RepoListState createState() => _RepoListState();
}

class _RepoListState extends State<RepoList> {
  final _scrollController = ScrollController();
  late ReposBloc _reposBloc;
  bool fetchingFlag = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _reposBloc = context.read<ReposBloc>();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(fetchingFlag);

    return BlocBuilder<ReposBloc, ReposState>(
      builder: (context, state) {
        print("repos state length ${state.repos.length}");

        switch (state.status) {
          case ReposStatus.failure:
            return const Center(
              child: Text("Failed to fetch Repos"),
            );
          case ReposStatus.success:
            print("-------success");
            _reposBloc.add(ReposFetched());
            if (state.repos.isEmpty) {
              return const Center(
                child: Text("No Posts"),
              );
            }
            fetchingFlag = true;
            return ListView.builder(
              itemBuilder: (context, index) {
                return index >= state.repos.length
                    ? const BottomLoader()
                    : RepoListItem(repo: state.repos[index]);
              },
              itemCount: state.hasReachedMax
                  ? state.repos.length
                  : state.repos.length + 1,
              controller: _scrollController,
            );
          case ReposStatus.initial:
            print("--------initial");
            // if (state.repos.isEmpty) {
            //   return const Center(
            //     child: Text("No Posts"),
            //   );
            // }
            return ListView.builder(
              itemBuilder: (context, index) {
                return index >= state.repos.length
                    ? const BottomLoader()
                    : RepoListItem(repo: state.repos[index]);
              },
              itemCount: state.hasReachedMax
                  ? state.repos.length
                  : state.repos.length + 1,
              controller: _scrollController,
            );
          default:
            return const Center(
              child: CircularProgressIndicator(),
            );
        }
      },
    );
  }

  void _onScroll() {
    if (_isBottom && fetchingFlag) {
      print("SHould be fetching");
      fetchingFlag = false;
      _reposBloc.add(ReposFetching());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll);
  }
}
