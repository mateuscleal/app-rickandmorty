import '../../model/episode_dto.dart';

abstract class EpisodeRepository {

  Future<List<EpisodeDto>> fetchAllEpisodes();

  Future<List<EpisodeDto>> searchEpisodes(String name);

  Future<void> updateEpisodeStatus(int episodeId, bool isFavorite, bool isWatched, String imagePath);
}
