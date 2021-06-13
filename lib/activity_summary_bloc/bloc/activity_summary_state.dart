part of 'activity_summary_bloc.dart';

enum ActivitySummaryStatus {
  ActivitySummaryInital,
  ActivitySummaryFailure,
  ActivitySummarySuccess
}

class ActivitySummaryState extends Equatable {
  final ActivitySummaryStatus status;
  final ActivitySummaryModel activitySummary;

  const ActivitySummaryState({
    this.status = ActivitySummaryStatus.ActivitySummaryInital,
    this.activitySummary = const ActivitySummaryModel(
      steps: -1,
      total_minutes_asleep: -1,
      total_time_in_bed: -1,
      bmr: -1,
      calories_total: -1,
    ),
  });

  ActivitySummaryState copyWith({
    ActivitySummaryStatus? status,
    ActivitySummaryModel? activitySummary,
  }) {
    return ActivitySummaryState(
      status: status ?? this.status,
      activitySummary: activitySummary ?? this.activitySummary,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [status, activitySummary];
}
