import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tasks/repos/bloc/repos_bloc.dart';
import 'package:flutter_tasks/repos/models/repos_model.dart';
import 'package:flutter_tasks/user/bloc/user_bloc.dart';

class ReposDetailsScreen extends StatefulWidget {
  ReposDetailsScreen({Key? key}) : super(key: key);
  @override
  _ReposDetailsScreenState createState() => _ReposDetailsScreenState();
}

class _ReposDetailsScreenState extends State<ReposDetailsScreen> {
  late Repos repo;
  late ReposBloc reposBloc;
  late UserBloc _user;

  @override
  void initState() {
    super.initState();
    reposBloc = context.read<ReposBloc>();
    repo = reposBloc.state.repo;
    _user = context.read<UserBloc>();
  }

  @override
  void dispose() {
    print("disposing repo details screen");
    // reposBloc.close();
    _user.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final window = MediaQuery.of(context).size;
    final double radius = 50;

    return Scaffold(
      appBar: AppBar(
        title: Text("${repo.name[0].toUpperCase()}${repo.name.substring(1)}"),
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          // print("----------------state is $state");
          return state.user.id > 0
              ? Container(
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
                                  child: Image.network(state.user.image),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 22),
                              child: state.user.userName != ""
                                  ? Text(
                                      "${state.user.userName[0].toUpperCase()}${state.user.userName.substring(1)}",
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
                              title:
                                  Text("Repository ID: ${repo.id.toString()}"),
                            ),
                            CustomDivider(),
                            ListTile(
                              title: Text("Name: ${repo.name.toString()}"),
                            ),
                            CustomDivider(),
                            ListTile(
                              title:
                                  Text("Language: ${repo.language.toString()}"),
                            ),
                            CustomDivider(),
                            ListTile(
                              title: Text(
                                  '''Description: \n${repo.description.toString()}'''),
                            ),
                            CustomDivider(),
                            ListTile(
                              title:
                                  Text('''Visit at:\n${repo.url.toString()}'''),
                            ),
                            CustomDivider(),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }

  Widget CustomDivider() {
    return Divider(
      thickness: 2,
    );
  }
}
