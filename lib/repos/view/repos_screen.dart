// Flutter
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

// Components
import 'package:flutter_tasks/repos/widgets/bottom_loader.dart';
import 'package:flutter_tasks/repos/widgets/repos_list_item.dart';
import 'package:flutter_tasks/repos/bloc/repos_bloc.dart';

class RepoScreen extends StatefulWidget {
  const RepoScreen({Key? key}) : super(key: key);

  @override
  _RepoScreenState createState() => _RepoScreenState();
}

class _RepoScreenState extends State<RepoScreen> {
  final _scrollController = ScrollController();
  late ReposBloc _reposBloc;
  bool _fetchingFlag = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _reposBloc = context.read<ReposBloc>();
  }

  @override
  void dispose() {
    print("disposing repos_screen");
    _reposBloc.close();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReposBloc, ReposState>(
      builder: (context, state) {
        switch (state.status) {
          case ReposStatus.failure:
            return const Center(
              child: Text("Failed to fetch Repos"),
            );
          case ReposStatus.success:
            if (state.repos.isEmpty) {
              return const Center(
                child: Text("No Posts"),
              );
            }
            _fetchingFlag = true;
            return ListView.builder(
              itemBuilder: (context, index) {
                return index >= state.repos.length
                    ? const BottomLoader()
                    : ReposListItem(index: index);
              },
              itemCount: state.hasReachedMax
                  ? state.repos.length
                  : state.repos.length + 1,
              controller: _scrollController,
            );
          case ReposStatus.initial:
            // if (state.repos.isEmpty) {
            //   return const Center(
            //     child: Text("No Posts"),
            //   );
            // }
            return ListView.builder(
              itemBuilder: (context, index) {
                return index >= state.repos.length
                    ? Center(
                        child: Column(
                        children: [
                          SizedBox(height: 20),
                          BottomLoader(),
                        ],
                      ))
                    : ReposListItem(index: index);
              },
              itemCount: state.hasReachedMax
                  ? state.repos.length
                  : state.repos.length + 1,
              controller: _scrollController,
            );
        }
      },
    );
  }

  void _onScroll() {
    if (_isBottom && _fetchingFlag) {
      _fetchingFlag = false;
      _reposBloc.add(ReposFetched());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll);
  }
}
