import '../../../data/repositories/episode/episode_repository.dart';
import 'get_all_episodes.dart';
import 'get_favorite_episodes.dart';
import 'search_episodes.dart';
import 'toggle_favorite_episode.dart';
import 'toggle_watched_episode.dart';


class EpisodesUsecases {

  final EpisodeRepository episodesRepository;
  late GetAllEpisodes getAllEpisodes;
  late GetFavoriteEpisodes getFavoriteEpisodes;
  late SearchEpisodes searchEpisodes;
  late ToggleFavoriteEpisode toggleFavoriteEpisode;
  late ToggleWatchedEpisode toggleWatchedEpisode;

  EpisodesUsecases(this.episodesRepository) {
    getAllEpisodes = GetAllEpisodes(episodesRepository);
    searchEpisodes = SearchEpisodes(episodesRepository);
    toggleFavoriteEpisode = ToggleFavoriteEpisode(episodesRepository);
    toggleWatchedEpisode = ToggleWatchedEpisode(episodesRepository);
    getFavoriteEpisodes = GetFavoriteEpisodes();
  }

}