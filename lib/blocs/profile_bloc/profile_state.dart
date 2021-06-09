part of 'profile_bloc.dart';

enum ProfileStatus { initial, success, failure }

class ProfileState extends Equatable {
  final ProfileStatus status;
  final ProfileModel profile;

  const ProfileState({
    this.status = ProfileStatus.initial,
    this.profile = const ProfileModel(
      displayName: "No display name",
      age: -1,
      dateOfBirth: "No birthday",
      weight: -1,
      gender: "No gender",
      avatar150: "No avatar150",
      avatar640: "No avatar640",
      averageDailySteps: -1,
    ),
  });

  ProfileState copyWith({
    ProfileStatus? status,
    ProfileModel? profile,
  }) {
    return ProfileState(
      status: status ?? this.status,
      profile: profile ?? this.profile,
    );
  }

  @override
  String toString() {
    return '''RepoState {status: $status, profile: $profile''';
  }

  @override
  List<Object?> get props => [
        status,
        profile,
      ];
}
