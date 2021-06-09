import 'package:flutter_tasks/models/profile_model.dart';

import 'data/profile_data.dart';

class ProfileRepository {
  final _profileProvider = ProfileData();

  Future<ProfileModel> fetchProfile() async {
    final _items = await _profileProvider.fetchProfile();

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
  }
}
