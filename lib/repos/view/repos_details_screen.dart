import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tasks/repos/bloc/repos_bloc.dart';
import 'package:flutter_tasks/repos/models/repos_model.dart';

class ReposDetailsScreen extends StatefulWidget {
  ReposDetailsScreen({Key? key}) : super(key: key);
  @override
  _ReposDetailsScreenState createState() => _ReposDetailsScreenState();
}

class _ReposDetailsScreenState extends State<ReposDetailsScreen> {
  late ReposBloc reposBloc;

  @override
  Widget build(BuildContext context) {
    reposBloc = BlocProvider.of<ReposBloc>(context);
    Repos repo = reposBloc.repo;
    final window = MediaQuery.of(context).size;
    final double radius = 50;

    return Scaffold(
      appBar: AppBar(
        title: Text("${repo.name[0].toUpperCase()}${repo.name.substring(1)}"),
      ),
      body: Container(
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
                      color: Colors.grey[500],
                    ),
                    margin: EdgeInsets.only(top: window.height / 18),
                    child: Center(child: Text("User Image")),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 22),
                    child: Text(
                      "Username here",
                      style: TextStyle(fontSize: 25),
                    ),
                  )
                ]),
              ),
              ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(20),
                children: [
                  CustomDivider(),
                  ListTile(
                    title: Text("ID: ${repo.id.toString()}"),
                  ),
                  CustomDivider(),
                  ListTile(
                    title: Text("Name: ${repo.name.toString()}"),
                  ),
                  CustomDivider(),
                  ListTile(
                    title: Text("Language: ${repo.language.toString()}"),
                  ),
                  CustomDivider(),
                  ListTile(
                    title: Text(
                        '''Description: \n${repo.description.toString()}'''),
                  ),
                  CustomDivider(),
                  ListTile(
                    title: Text('''Visit at:\n${repo.url.toString()}'''),
                  ),
                  CustomDivider(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget CustomDivider() {
    return Divider(
      thickness: 2,
    );
  }
}
