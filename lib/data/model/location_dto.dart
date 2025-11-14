import '../../domain/models/location.dart';
import 'resident_dto.dart';

class LocationDto {
  final String id;
  final String name;
  final String type;
  final String dimension;
  final List<dynamic> residents;

  LocationDto({
    required this.id,
    required this.name,
    required this.type,
    required this.dimension,
    required this.residents,
  });

  factory LocationDto.fromMap(Map<String, dynamic> data) {
    return LocationDto(
      id: data['id'],
      name: data['name'],
      type: data['type'],
      dimension: data['dimension'],
      residents: data['residents'].map((resident) => ResidentDto.fromMap(resident)).toList(),
    );
  }

  LocationModel toDomain() {
    return LocationModel(
      id: id,
      name: name,
      type: type,
      dimension: dimension,
      residents: residents.map((resident) => resident.toDomain()).toList(),
    );
  }
}