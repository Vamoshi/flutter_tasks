import 'package:flutter_tasks/profile_bloc/data/profile_data.dart';
import 'package:flutter_tasks/profile_bloc/models/profile_model.dart';

class ProfileRepository {
  final _profileProvider = ProfileData();

  Future<ProfileModel> fetchProfile() async {
    final _items = await _profileProvider.fetchProfile();

    try {
      return ProfileModel(
        displayName: _items['displayName'],
        age: _items['age'],
        dateOfBirth: _items['dateOfBirth'],
        weight: _items['weight'],
        gender: _items['gender'],
        avatar150: _items['avatar150'],
        avatar640: _items['avatar640'],
        averageDailySteps: _items['averageDailySteps'],
      );
    } catch (e) {
      return const ProfileModel(
        displayName: "No display name",
        age: -1,
        dateOfBirth: "No birthday",
        weight: -1,
        gender: "No gender",
        avatar150: "No avatar150",
        avatar640: "No avatar640",
        averageDailySteps: -1,
      );
    }
  }
}
