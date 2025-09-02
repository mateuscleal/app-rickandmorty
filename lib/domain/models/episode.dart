class EpisodeModel {
  final String id;
  final String date;
  final String title;
  final String imagePath;
  final String episodeName;
  final List<dynamic> characters;
  final bool isWatched;
  final bool isFavorite;

  EpisodeModel({
    required this.id,
    required this.date,
    required this.title,
    required this.imagePath,
    required this.episodeName,
    required this.characters,
    this.isWatched = false,
    this.isFavorite = false,
  });

  EpisodeModel copyWith({bool? isWatched, bool? isFavorite}) {
    return EpisodeModel(
      id: id,
      date: date,
      title: title,
      imagePath: imagePath,
      episodeName: episodeName,
      characters: characters,
      isWatched: isWatched == null ? this.isWatched : !this.isWatched,
      isFavorite: isFavorite == null ? this.isFavorite : !this.isFavorite,
    );
  }

  factory EpisodeModel.fromMap(Map<String, dynamic> map, Map<dynamic, dynamic> hiveData) {
    return EpisodeModel(
      id: map['id'],
      title: map['name'],
      date: map['air_date'],
      characters: map['characters'],
      episodeName: map['episode'],
      imagePath: hiveData.isNotEmpty ? hiveData['imagePath'] : map['characters'][0]['image'],
      isWatched: hiveData.isNotEmpty ? hiveData['isWatched'] : false,
      isFavorite: hiveData.isNotEmpty ? hiveData['isFavorite'] : false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'title': title,
      'imagePath': imagePath,
      'episodeName': episodeName,
      'characters': characters,
      'isWatched': isWatched,
      'isFavorite': isFavorite,
    };
  }
}
