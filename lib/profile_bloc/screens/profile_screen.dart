import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tasks/profile_bloc/bloc/profile_bloc.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final window = MediaQuery.of(context).size;
    final double radius = 10;

    return BlocBuilder<ProfileBloc, ProfileState>(
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
                  child: Column(children: [
                    Container(
                      height: window.height / 5.5,
                      width: window.height / 5.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(130),
                        color: Colors.grey[300],
                      ),
                      margin: EdgeInsets.only(top: window.height / 18),
                      child: Center(
                        child: ClipOval(
                          child: Image.network(state.profile.avatar150),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 22),
                      child: state.profile.displayName != ""
                          ? Text(
                              "${state.profile.displayName[0].toUpperCase()}${state.profile.displayName.substring(1)}",
                              style: TextStyle(fontSize: 25))
                          : Text("No Username"),
                    )
                  ]),
                ),
                ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(20),
                  children: [
                    CustomDivider(),
                    ListTile(
                      title: Text("Age: ${state.profile.age}"),
                    ),
                    CustomDivider(),
                    ListTile(
                      title: Text("Birthday: ${state.profile.dateOfBirth}"),
                    ),
                    CustomDivider(),
                    ListTile(
                      title: Text("Weight: ${state.profile.weight}"),
                    ),
                    CustomDivider(),
                    ListTile(
                      title: Text(
                          "Gender: ${state.profile.gender[0]}${state.profile.gender.substring(1).toLowerCase()}"),
                    ),
                    CustomDivider(),
                    ListTile(
                      title: Text(
                          "Average Daily Steps: ${state.profile.averageDailySteps}"),
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
