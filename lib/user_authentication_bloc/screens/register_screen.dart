import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tasks/user_authentication_bloc/bloc/user_authentication_bloc.dart';
import 'package:flutter_tasks/user_authentication_bloc/login_providers/user_authentication_provider.dart';
import 'package:flutter_tasks/user_authentication_bloc/widgets/register_success.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late UserAuthenticationBloc _bloc;
  late Future<int?> _userId;

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _passwordCopy = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _bloc = context.read<UserAuthenticationBloc>();
    // removeCachedUserId();
    _userId = getUserId();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final user_id = prefs.getInt('user_id');
    return user_id;
  }

  void removeCachedUserId() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('user_id');
    print("USER ID IS NOW ==== ${prefs.getInt('user_id')}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserAuthenticationBloc, UserAuthenticationState>(
        builder: (context, state) {
          switch (state.status) {
            case UserAuthenticationStatus.UserAuthInitial:
              return FutureBuilder(
                future: _userId,
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  return Column(
                    children: [RegisterForm("")],
                  );
                },
              );
            case UserAuthenticationStatus.UserAuthSuccess:
              return RegisterSuccess();
            case UserAuthenticationStatus.UserAuthFailure:
              return Container(
                child: Column(
                  children: [
                    RegisterForm(state.login.message),
                  ],
                ),
              );

            case UserAuthenticationStatus.FitbitAuthFailure:
              return Container();

            case UserAuthenticationStatus.FitbitAuthSuccess:
              return Container();
          }
        },
      ),
    );
  }

  void submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _bloc.add(AttemptedRegister(
      email: _email.text,
      password: _password.text,
    ));
  }

  void toLoginScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => UserAuthenticationProvider(),
      ),
    );
  }

  Widget RegisterForm(String message) {
    final window = MediaQuery.of(context).size;

    print("PASSWORD AND PASSWORDCOPY ${_password.text} ${_passwordCopy.text}");

    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: window.height / 3,
            ),
            Container(
              child: Center(
                child: Text(message),
              ),
            ),
            // Enter email
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                controller: _email,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'abc@example.com'),
                validator: MultiValidator([
                  RequiredValidator(errorText: "* Required"),
                  EmailValidator(errorText: "Enter valid email address"),
                ]),
              ),
            ),
            // Enter password
            Padding(
              padding: const EdgeInsets.only(
                left: 15.0,
                right: 15.0,
                top: 15,
                bottom: 0,
              ),
              child: TextFormField(
                controller: _password,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter password'),
                validator: MultiValidator([
                  RequiredValidator(errorText: 'Password is required'),
                  MinLengthValidator(3,
                      errorText: 'Password must be at least 3 digits long'),
                  // PatternValidator(r'(?=.*?[#?!@$%^&*-])',
                  //     errorText:
                  //         'passwords must have at least one special character')
                ]),
              ),
            ),
            // Confirm password
            Padding(
              padding: const EdgeInsets.only(
                left: 15.0,
                right: 15.0,
                top: 15,
                bottom: 0,
              ),
              child: TextFormField(
                  controller: _passwordCopy,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Confirm password',
                      hintText: 'Enter password again'),
                  validator: (_) =>
                      MatchValidator(errorText: "Passwords do not match")
                          .validateMatch(_password.text, _passwordCopy.text)),
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
                  "Register",
                  style: TextStyle(
                    fontSize: window.width / 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 100,
            ),
            // Redirect to login
            InkWell(
              child: Text(
                'Already have an account? Login',
                style: TextStyle(color: Colors.blue[300]),
              ),
              onTap: toLoginScreen,
            )
          ],
        ),
      ),
    );
  }
}
