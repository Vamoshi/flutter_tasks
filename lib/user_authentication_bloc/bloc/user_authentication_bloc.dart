import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_tasks/repository.dart';
import 'package:flutter_tasks/user_authentication_bloc/models/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'user_authentication_event.dart';
part 'user_authentication_state.dart';

class UserAuthenticationBloc
    extends Bloc<UserAuthenticationEvent, UserAuthenticationState> {
  final _repository = UserAuthenticationRepository();

  UserAuthenticationBloc() : super(const UserAuthenticationState());

  @override
  Stream<UserAuthenticationState> mapEventToState(
      UserAuthenticationEvent event) async* {
    if (event is AttemptedLogin) {
      print("ATTEMPTED LOGIN");
      yield await _mapLogin(event.email, event.password, state);
    } else if (event is AttemptedRegister) {
      print("ATTEMPTED REGISTER");
      yield await _mapRegister(event.email, event.password, state);
    } else if (event is AttemptedFitbitAuthorization) {
      print("ATTEMPTED FITBIT AUTHORIZATION");
      yield await _mapFitbitAuth();
    }
  }

  Future<UserAuthenticationState> _mapRegister(
    email,
    password,
    UserAuthenticationState state,
  ) async {
    try {
      final UserAuthenticationModel registerResult =
          await _repository.registerUser(email, password);

      return _checkStatus(email, registerResult);
    } on Exception {
      return state.copywith(status: UserAuthenticationStatus.UserAuthFailure);
    }
  }

  Future<UserAuthenticationState> _mapLogin(
    email,
    password,
    UserAuthenticationState state,
  ) async {
    try {
      // In the user_authentication_provider, an event will be added to the bloc's stream
      // That will be the initialization and it will log the user in automatically
      // if there is a cached id
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt('user_id');
      if ((email != "" && password != "") || (userId != null && userId >= 0)) {
        final UserAuthenticationModel loginResult =
            await _repository.getUserId(email, password);
        return _checkStatus(email, loginResult);
      }

      // If no cached id, show the login screen
      return state.copywith(status: UserAuthenticationStatus.UserAuthInitial);
    } on Exception {
      return state.copywith(status: UserAuthenticationStatus.UserAuthFailure);
    }
  }

  Future<UserAuthenticationState> _mapFitbitAuth() async {
    try {
      final UserAuthenticationModel fitbitAuthResult =
          await _repository.authorizeFitbit();

      return state.copywith(
        status: UserAuthenticationStatus.FitbitAuthSuccess,
        login: fitbitAuthResult,
      );
    } on Exception {
      return state.copywith(status: UserAuthenticationStatus.FitbitAuthFailure);
    }
  }

  UserAuthenticationState _checkStatus(email, result) {
    final UserAuthenticationStatus status;
    if (result.userId >= 0) {
      status = UserAuthenticationStatus.UserAuthSuccess;
    } else {
      status = UserAuthenticationStatus.UserAuthFailure;
    }
    return state.copywith(
      status: status,
      login: UserAuthenticationModel(
        email: email,
        message: result.message,
        userId: result.userId,
      ),
    );
  }
}
