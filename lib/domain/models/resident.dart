class ResidentModel {
  final String id;
  final String name;
  final String image;

  ResidentModel({required this.id, required this.name, required this.image});

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'image': image};
  }
}
