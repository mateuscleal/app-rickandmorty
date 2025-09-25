import '../../domain/models/episode.dart';

class EpisodeDto{

  final String id;
  final String date;
  final String title;
  final String imagePath;
  final String episodeName;
  final List<dynamic> characters;
  final bool isWatched;
  final bool isFavorite;

  EpisodeDto({
    required this.id,
    required this.date,
    required this.title,
    required this.imagePath,
    required this.episodeName,
    required this.characters,
    this.isWatched = false,
    this.isFavorite = false,
  });

  factory EpisodeDto.fromMap(Map<String, dynamic> map, Map<dynamic, dynamic> hiveData) {
    return EpisodeDto(
      id: map['id'],
      title: map['name'],
      date: map['air_date'],
      characters: map['characters'],
      episodeName: map['episode'],
      imagePath: hiveData.isNotEmpty ? hiveData['imagePath'] : map['characters'].last['image'],
      isWatched: hiveData.isNotEmpty ? hiveData['isWatched'] : false,
      isFavorite: hiveData.isNotEmpty ? hiveData['isFavorite'] : false,
    );
  }

  EpisodeModel toDomain() {
    return EpisodeModel(
      id: id,
      title: title,
      date: date,
      characters: characters,
      episodeName: episodeName,
      imagePath: imagePath,
      isWatched: isWatched,
      isFavorite: isFavorite,
    );
  }
}