import 'resident.dart';

class LocationModel {
  final String id;
  final String name;
  final String type;
  final String dimension;
  final List<dynamic> residents;

  LocationModel({
    required this.id,
    required this.name,
    required this.type,
    required this.dimension,
    required this.residents,
  });

  factory LocationModel.fromMap(Map<String, dynamic> data) {
    return LocationModel(
      id: data['id'],
      name: data['name'],
      type: data['type'],
      dimension: data['dimension'],
      residents: data['residents'].map((resident) => ResidentModel.fromMap(resident)).toList(),
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
