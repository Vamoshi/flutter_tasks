import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tasks/activity_summary_bloc/bloc/activity_summary_bloc.dart';

class ActivitySummaryScreen extends StatefulWidget {
  const ActivitySummaryScreen({Key? key}) : super(key: key);
  @override
  _ActivitySummaryScreenState createState() => _ActivitySummaryScreenState();
}

class _ActivitySummaryScreenState extends State<ActivitySummaryScreen> {
  @override
  Widget build(BuildContext context) {
    final window = MediaQuery.of(context).size;
    final double radius = 10;

    return BlocBuilder<ActivitySummaryBloc, ActivitySummaryState>(
      builder: (context, state) {
        return Container(
          child: Center(
            child: Column(
              children: [
                Container(
                  height: window.height / 3,
                  width: window.width,
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(radius),
                        bottomRight: Radius.circular(radius)),
                  ),
                ),
                ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(20),
                  children: [
                    CustomDivider(),
                    ListTile(
                      title: Text("Steps: ${state.activitySummary.steps}"),
                    ),
                    CustomDivider(),
                    ListTile(
                      title: Text(
                          "Birthday: ${state.activitySummary.total_minutes_asleep}"),
                    ),
                    CustomDivider(),
                    ListTile(
                      title: Text(
                          "Weight: ${state.activitySummary.total_time_in_bed}"),
                    ),
                    CustomDivider(),
                    ListTile(
                      title: Text("BMR: ${state.activitySummary.bmr}"),
                    ),
                    CustomDivider(),
                    ListTile(
                      title: Text(
                          "Total Calories: ${state.activitySummary.calories_total}"),
                    ),
                    CustomDivider(),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget CustomDivider() {
    return Divider(
      thickness: 2,
    );
  }
}
