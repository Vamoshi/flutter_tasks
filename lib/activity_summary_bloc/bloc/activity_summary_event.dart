part of 'activity_summary_bloc.dart';

abstract class ActivitySummaryEvent extends Equatable {
  const ActivitySummaryEvent();

  @override
  List<Object> get props => [];
}

class ActivitySummaryFetched extends ActivitySummaryEvent {}
