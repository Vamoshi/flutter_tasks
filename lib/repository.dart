import 'package:flutter_tasks/activity_summary_bloc/models/activity_summary_model.dart';
import 'package:flutter_tasks/profile_bloc/data/profile_data.dart';
import 'package:flutter_tasks/profile_bloc/models/profile_model.dart';
import 'package:flutter_tasks/user_authentication_bloc/data/user_authentication_data.dart';
import 'package:flutter_tasks/user_authentication_bloc/models/user_authentication_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'activity_summary_bloc/data/activity_summary_data.dart';

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

class UserAuthenticationRepository {
  final _userAuthenticationData = UserAuthenticationData();

  Future<UserAuthenticationModel> getUserId(email, password) async {
    final prefs = await SharedPreferences.getInstance();
    var userId = prefs.getInt("user_id");

    final response =
        await _userAuthenticationData.getUserId(email, password, userId);

    // cache user_id
    prefs.setInt("user_id", response["user_id"]);

    return UserAuthenticationModel(
      email: email,
      message: response['message'],
      userId: response['user_id'],
    );
  }

  Future<UserAuthenticationModel> registerUser(email, password) async {
    final prefs = await SharedPreferences.getInstance();
    // remove any existing user_id
    prefs.remove("user_id");
    final response =
        await _userAuthenticationData.registerUser(email, password);

    // cache user_id
    // prefs.setInt("user_id", response["user_id"]);

    return UserAuthenticationModel(
        email: email,
        message: response['message'],
        userId: response['user_id']);
  }

  Future<UserAuthenticationModel> authorizeFitbit() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('user_id');
    final response = await _userAuthenticationData.authorizeFitbit(userId);

    return response;
  }
}

class ActivitySummaryRepository {
  final _activitySummaryData = ActivitySummaryData();

  Future<ActivitySummaryModel> getActivitySummary() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('user_id');

    final sleep = await _activitySummaryData.getSleep(userId);
    final steps = await _activitySummaryData.getSteps(userId);
    final calories = await _activitySummaryData.getCalories(userId);

    return ActivitySummaryModel(
      steps: steps['steps'],
      total_minutes_asleep: sleep["totalMinutesAsleep"],
      total_time_in_bed: sleep["totalTimeInBed"],
      bmr: calories['bmr'],
      calories_total: calories['total'],
    );
  }
}
