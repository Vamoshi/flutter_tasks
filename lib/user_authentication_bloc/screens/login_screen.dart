import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tasks/activity_summary_bloc/bloc_providers/activity_summary_provider.dart';
import 'package:flutter_tasks/screens/welcome_screen.dart';
import 'package:flutter_tasks/user_authentication_bloc/bloc/user_authentication_bloc.dart';
import 'package:flutter_tasks/user_authentication_bloc/screens/register_screen.dart';
import 'package:flutter_tasks/user_authentication_bloc/widgets/fitbit_auth.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late UserAuthenticationBloc _loginBloc;
  // late Future<int?> _userId;

  final TextEditingController _emailString = TextEditingController();
  final TextEditingController _passwordString = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _loginBloc = context.read<UserAuthenticationBloc>();
    // removeCachedUserId();
    // _userId = getUserId();
  }

  void removeCachedUserId() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('user_id');
  }

  @override
  void dispose() {
    _loginBloc.close();
    super.dispose();
  }

  Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final user_id = prefs.getInt('user_id');
    return user_id;
  }

  void submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _loginBloc.add(AttemptedLogin(
      email: _emailString.text,
      password: _passwordString.text,
    ));
  }

  void toRegisterScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: _loginBloc,
          child: RegisterScreen(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserAuthenticationBloc, UserAuthenticationState>(
      builder: (context, state) {
        switch (state.status) {
          case UserAuthenticationStatus.UserAuthInitial:
            return LoginForm("");

          case UserAuthenticationStatus.UserAuthSuccess:
            return FitbitAuth();

          // // Logout
          // TextButton(
          //     onPressed: () async {
          //       final prefs = await SharedPreferences.getInstance();
          //       prefs.remove("user_id");
          //       Navigator.of(context).push(
          //         MaterialPageRoute(
          //           builder: (context) => WelcomeScreen(),
          //         ),
          //       );
          //     },
          //     child: Text("Logout"))

          case UserAuthenticationStatus.UserAuthFailure:
            return Container(
              child: Column(
                children: [
                  LoginForm(state.login.message),
                ],
              ),
            );

          case UserAuthenticationStatus.FitbitAuthFailure:
            // TODO: Handle this case.
            return Center(
              child: Container(
                margin: EdgeInsets.only(top: 100),
                child: Text("Something went wrong"),
              ),
            );

          case UserAuthenticationStatus.FitbitAuthSuccess:
            return Container(
              child: Center(
                child: Container(
                  margin: EdgeInsets.only(top: 100),
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ActivitySummaryProvider()));
                    },
                    child: Text("Click Here!"),
                  ),
                ),
              ),
            );
          // TextButton(
          //     onPressed: () async {
          //       final prefs = await SharedPreferences.getInstance();
          //       prefs.remove("user_id");
          //       Navigator.of(context).push(
          //         MaterialPageRoute(
          //           builder: (context) => WelcomeScreen(),
          //         ),
          //       );
          //     },
          //     child: Text("Logout"))
        }
      },
    );
  }

  Widget LoginForm(String message) {
    final window = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: window.height / 2.8,
            ),
            message != ""
                ? Container(
                    padding: EdgeInsets.all(30),
                    child: Center(
                      child: Text(
                        message,
                        style: TextStyle(color: Colors.red, fontSize: 15),
                      ),
                    ),
                  )
                : Container(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                  controller: _emailString,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      hintText: 'Enter valid email id as abc@gmail.com'),
                  validator: MultiValidator([
                    RequiredValidator(errorText: "* Required"),
                    EmailValidator(errorText: "Enter valid email id"),
                  ])),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 15.0,
                right: 15.0,
                top: 15,
                bottom: 0,
              ),
              child: TextFormField(
                controller: _passwordString,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter password'),
                validator: MultiValidator([
                  RequiredValidator(errorText: "* Required"),
                  MinLengthValidator(0,
                      errorText: "Password should not be empty"),
                ]),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            // Submit Button
            Container(
              margin: EdgeInsets.only(top: 20),
              height: window.height / 15,
              width: window.width / 2,
              decoration: BoxDecoration(
                color: Colors.green[400],
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green,
                    blurRadius: 15,
                    spreadRadius: 1,
                    offset: Offset(0, 0),
                  )
                ],
              ),
              child: TextButton(
                onPressed: submit,
                child: Text(
                  "Login",
                  style: TextStyle(
                    fontSize: window.width / 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            InkWell(
              child: Text('New User? Create an Account'),
              onTap: toRegisterScreen,
            )
          ],
        ),
      ),
    );
  }
}
