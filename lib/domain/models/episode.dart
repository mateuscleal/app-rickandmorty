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
