import 'resident.dart';

class Location {
  final String id;
  final String name;
  final String type;
  final String dimension;
  final List<dynamic> residents;

  Location({
    required this.id,
    required this.name,
    required this.type,
    required this.dimension,
    required this.residents,
  });

  factory Location.fromMap(Map<String, dynamic> data) {
    return Location(
      id: data['id'],
      name: data['name'],
      type: data['type'],
      dimension: data['dimension'],
      residents: data['residents'].map((resident) => Resident.fromMap(resident)).toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'dimension': dimension,
      'residents': residents.map((resident) => resident.toMap()).toList(),
    };
  }
}
