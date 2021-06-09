import 'package:equatable/equatable.dart';

class ProfileModel extends Equatable {
  final String displayName;
  final int age;
  final String dateOfBirth;
  final int weight;
  final String gender;
  final String avatar150;
  final String avatar640;
  final int averageDailySteps;

  const ProfileModel({
    required this.displayName,
    required this.age,
    required this.dateOfBirth,
    required this.weight,
    required this.gender,
    required this.avatar150,
    required this.avatar640,
    required this.averageDailySteps,
  });

  @override
  List<Object> get props => [
        displayName,
        age,
        dateOfBirth,
        weight,
        gender,
        avatar150,
        avatar150,
        averageDailySteps
      ];
}
