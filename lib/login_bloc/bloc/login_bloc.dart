import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_tasks/login_bloc/models/login_model.dart';
import 'package:flutter_tasks/repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final _repository = LoginRepository();

  LoginBloc() : super(const LoginState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is AttemptedLogin) {
      yield await _mapEventToStateLogin(event.email, event.password);
    }
    // else if (event is AttemptedRegister) {
    //   yield await _mapEventToStateRegister(state);
    // }
  }

  Future<LoginState> _mapEventToStateLogin(email, password) async {
    try {
      final LoginModel login = await _repository.getUserId(email, password);

      if (login.userId < 0) {
        return state.copywith(
          status: LoginStatus.failure,
          login: LoginModel(
            email: email,
            message: login.message,
            userId: login.userId,
          ),
        );
      } else {
        return state.copywith(
          status: LoginStatus.success,
          login: LoginModel(
            email: email,
            message: login.message,
            userId: login.userId,
          ),
        );
      }
    } on Exception {
      return state.copywith(status: LoginStatus.failure);
    }
  }
}
