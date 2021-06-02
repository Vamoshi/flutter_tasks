import 'package:equatable/equatable.dart';

class Repo extends Equatable {
  int id;
  String name;
  String language;
  String url;
  String description;

  Repo({
    required this.id,
    required this.name,
    required this.language,
    required this.url,
    required this.description,
  });

  @override
  List<Object> get props => [
        id,
        name,
        language,
        url,
        description,
      ];
}
