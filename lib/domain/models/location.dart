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
