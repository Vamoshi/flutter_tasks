part of 'repos_bloc.dart';

abstract class ReposEvent extends Equatable {
  const ReposEvent();

  @override
  List<Object> get props => [];
}

class ReposFetching extends ReposEvent {}

class ReposFetched extends ReposEvent {}
