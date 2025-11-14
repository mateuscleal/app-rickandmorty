import 'dart:math';

import 'package:app/data/model/episode_dto.dart';

import '../../graphql/graphql_queries.dart';
import '../../services/graphql_service.dart';
import '../../services/hive_service.dart';
import 'episode_repository.dart';

class EpisodeRepositoryImpl implements EpisodeRepository {
  final GraphQLService _graphqlService;
  final HiveService _hiveManager;

  EpisodeRepositoryImpl(this._graphqlService, this._hiveManager);

  @override
  Future<List<EpisodeDto>> fetchAllEpisodes() async {
    try {
      final ids = List.generate(51, (i) => i + 1);
      final result = await _graphqlService.executeQuery(
        queries['getEpisodesByIds'],
        variables: {'ids': ids},
      );

      final data = await result.data?['episodesByIds'] ?? [];

      String imagePath;
      bool isFavorite, isWatched;
      return data.map<EpisodeDto>((episode) {
        final index = int.parse(episode['id']) - 1;
        final hiveData = _hiveManager.getValue(index);
        final randomIndex = Random().nextInt(episode['characters'].length);

        isFavorite = hiveData.isNotEmpty ? hiveData['isFavorite'] : false;
        isWatched = hiveData.isNotEmpty ? hiveData['isWatched'] : false;
        imagePath = hiveData.isNotEmpty ? hiveData['imagePath'] : episode['characters'][randomIndex]['image'];

        updateEpisodeStatus(index, isFavorite, isWatched, imagePath);

        return EpisodeDto.fromMap(episode, hiveData);
      }).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<EpisodeDto>> searchEpisodes(String name) async {
    int page = 1;
    List<EpisodeDto> allEpisodes = [];

    do {
      final result = await _graphqlService.executeQuery(
        queries['getFilteredEpisodes'],
        variables: {'name': name, 'page': page},
      );

      final episodesData = result.data?['episodes']['results'] ?? [];
      page = result.data?['episodes']['info']['next'] ?? 0;

      allEpisodes.addAll(
        episodesData.map<EpisodeDto>((episode) {
          final index = int.parse(episode['id']) - 1;
          final hiveData = _hiveManager.getValue(index);
          return EpisodeDto.fromMap(episode, hiveData);
        }),
      );
    } while (page != 0);

    return allEpisodes;
  }

  @override
  Future<void> updateEpisodeStatus(int episodeId, bool isFavorite, bool isWatched, String imagePath) async {
    await _hiveManager.setValue(episodeId, {
      'isFavorite': isFavorite,
      'isWatched': isWatched,
      'imagePath': imagePath,
    });
  }
}
