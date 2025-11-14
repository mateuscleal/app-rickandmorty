import 'package:app/domain/models/episode.dart';

class GetFavoriteEpisodes {
  List<EpisodeModel> call(List<EpisodeModel> episodes) {
    return episodes.where((episode) => episode.isFavorite).toList();
  }
}
