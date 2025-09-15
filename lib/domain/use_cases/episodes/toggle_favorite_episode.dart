import '../../../data/repositories/episode/episode_repository.dart';

class ToggleFavoriteEpisode {
  final EpisodeRepository repository;
  ToggleFavoriteEpisode(this.repository);

  Future<void> call(int episodeId, bool isFavorite, bool isWatched, String imagePath) async {
    await repository.updateEpisodeStatus(episodeId, isFavorite, isWatched, imagePath);
  }
}
