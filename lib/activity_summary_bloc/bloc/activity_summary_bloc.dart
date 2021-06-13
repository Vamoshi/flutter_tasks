import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_tasks/activity_summary_bloc/models/activity_summary_model.dart';
import 'package:flutter_tasks/repository.dart';

part 'activity_summary_event.dart';
part 'activity_summary_state.dart';

class ActivitySummaryBloc
    extends Bloc<ActivitySummaryEvent, ActivitySummaryState> {
  ActivitySummaryBloc() : super(const ActivitySummaryState());
  final _repository = ActivitySummaryRepository();

  @override
  Stream<ActivitySummaryState> mapEventToState(
    ActivitySummaryEvent event,
  ) async* {
    if (event is ActivitySummaryFetched) {
      yield await _mapEventToState(state);
    }
  }

  Future<ActivitySummaryState> _mapEventToState(
      ActivitySummaryState state) async {
    try {
      final ActivitySummaryModel activitySummary =
          await _repository.getActivitySummary();

      return state.copyWith(
        status: ActivitySummaryStatus.ActivitySummarySuccess,
        activitySummary: activitySummary,
      );
    } on Exception {
      return state.copyWith(
          status: ActivitySummaryStatus.ActivitySummaryFailure);
    }
  }
}
