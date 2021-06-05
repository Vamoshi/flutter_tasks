import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_tasks/repository.dart';
import 'package:flutter_tasks/user/models/user_model.dart';
import 'package:http/http.dart' as http;

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final http.Client httpClient;
  final int _userId;
  final UserRepository _userRepository = UserRepository();

  UserBloc(this.httpClient, this._userId) : super(const UserState());

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is UserFetched) {
      yield await _mapEventToState(state);
    }
  }

  Future<UserState> _mapEventToState(UserState state) async {
    try {
      final user = await _userRepository.fetchUser(_userId);

      return state.copywith(
        status: UserStatus.success,
        user: user,
      );
    } on Exception {
      return state.copywith(status: UserStatus.failure);
    }
  }
}
