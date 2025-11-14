import '../../../data/repositories/episode/episode_repository.dart';
import '../../models/episode.dart';

class GetAllEpisodes {
  final EpisodeRepository repository;
  GetAllEpisodes(this.repository);

  Future<List<EpisodeModel>> call() async {
    final dto = await repository.fetchAllEpisodes();
    return dto.map((episode) => episode.toDomain()).toList();
  }
}
