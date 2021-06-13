import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tasks/activity_summary_bloc/bloc/activity_summary_bloc.dart';
import 'package:flutter_tasks/activity_summary_bloc/screens/activity_summary_screen.dart';

class ActivitySummaryProvider extends StatelessWidget {
  ActivitySummaryProvider({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Activity Summary"),
      ),
      body: BlocProvider(
        create: (context) =>
            ActivitySummaryBloc()..add(ActivitySummaryFetched()),
        child: const ActivitySummaryScreen(),
      ),
    );
  }
}
