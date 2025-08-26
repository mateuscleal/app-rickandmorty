abstract class EpisodeRepository {
  Future<List<dynamic>> fetchAllEpisodes();

  Future<List<dynamic>> searchEpisodes(String name);

  Future<void> updateEpisodeStatus(int episodeId, bool isFavorite, bool isWatched, String imagePath);
}
