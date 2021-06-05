import 'package:equatable/equatable.dart';

class Repos extends Equatable {
  final int id;
  final String name;
  final String language;
  final String url;
  final String description;
  final int ownerId;

  const Repos({
    required this.id,
    required this.name,
    required this.language,
    required this.url,
    required this.description,
    required this.ownerId,
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
