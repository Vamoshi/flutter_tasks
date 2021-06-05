import 'package:equatable/equatable.dart';

class Repos extends Equatable {
  final int id;
  final String name;
  final String language;
  final String url;
  final String description;

  Repos({
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
