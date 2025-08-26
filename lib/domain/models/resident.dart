class Resident {
  final String id;
  final String name;
  final String image;

  Resident({required this.id, required this.name, required this.image});

  factory Resident.fromMap(Map<String, dynamic> data) {
    return Resident(id: data['id'], name: data['name'], image: data['image']);
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'image': image};
  }
}
