import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_tasks/models/profile_model.dart';
import 'package:flutter_tasks/repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final _repository = ProfileRepository();

  ProfileBloc() : super(const ProfileState());

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is ProfileFetched) {
      print("fetchin profile");
      yield await _mapEventToState(state);
    }
  }

  Future<ProfileState> _mapEventToState(ProfileState state) async {
    try {
      final ProfileModel profile = await _repository.fetchProfile();

      return state.copyWith(
        status: ProfileStatus.success,
        profile: profile,
      );
    } on Exception {
      return state.copyWith(
        status: ProfileStatus.failure,
      );
    }
  }
}
