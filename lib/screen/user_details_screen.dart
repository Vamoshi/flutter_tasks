import 'package:flutter/material.dart';
import 'package:github_thing/providers/user_provider.dart';
import 'package:provider/provider.dart';

class UserDetailsScreen extends StatefulWidget {
  String username;
  // ignore: use_key_in_widget_constructors
  UserDetailsScreen({required this.username});
  @override
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  var _init = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_init) {
      setState(() {
        _isLoading = true;
      });

      print(widget);

      Provider.of<UserProvider>(context)
          .getUserProfile(widget.username)
          .then((_) => {setState(() => _isLoading = false)});
    }
    _init = false;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.username),
        backgroundColor: Colors.blue[400],
        centerTitle: true,
      ),
      body: _isLoading
          ? Center(
              child: const CircularProgressIndicator(),
            )
          : user.user.username == null &&
                  user.user.imageUrl == null &&
                  user.user.followers == null &&
                  user.user.followings == null &&
                  user.user.publicRepo == null &&
                  user.user.joinedDate == null
              ? Center(
                  child: Text("Nothing Found"),
                )
              : Column(
                  children: [
                    Text(user.user.username.toString()),
                    Text("Image URL" + user.user.imageUrl.toString()),
                    Text("Followers" + user.user.followers.toString()),
                    Text("Following" + user.user.followings.toString()),
                    Text("Public Repos" + user.user.publicRepo.toString()),
                    Text("Joined on" + user.user.joinedDate.toString()),
                  ],
                ),
    );
  }
}
