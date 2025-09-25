import '../../domain/models/resident.dart';

class ResidentDto {
  final String id;
  final String name;
  final String image;

  ResidentDto({required this.id, required this.name, required this.image});

  factory ResidentDto.fromMap(Map<String, dynamic> data) {
    return ResidentDto(id: data['id'], name: data['name'], image: data['image']);
  }

  ResidentModel toDomain() {
    return ResidentModel(id: id, name: name, image: image);
  }
}
