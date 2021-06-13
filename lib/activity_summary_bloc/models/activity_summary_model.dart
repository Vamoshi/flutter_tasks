import 'package:equatable/equatable.dart';

class ActivitySummaryModel extends Equatable {
  final int steps;
  final int total_minutes_asleep;
  final int total_time_in_bed;
  final int bmr;
  final int calories_total;

  const ActivitySummaryModel({
    required this.steps,
    required this.total_minutes_asleep,
    required this.total_time_in_bed,
    required this.bmr,
    required this.calories_total,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        steps,
        total_minutes_asleep,
        total_time_in_bed,
        bmr,
        calories_total,
      ];
}
