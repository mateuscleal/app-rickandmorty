import 'package:app/domain/models/episode.dart';

import '../../../data/repositories/episode/episode_repository.dart';

class SearchEpisodes {
  final EpisodeRepository repository;

  SearchEpisodes(this.repository);

  Future<List<EpisodeModel>> call(String name) async {
    final dto = await repository.searchEpisodes(name);
    return dto.map((episode) => episode.toDomain()).toList();
  }
}
