import 'dart:math';

import 'package:app/domain/models/episode.dart';

import '../../graphql/graphql_queries.dart';
import '../../services/graphql_service.dart';
import '../../services/hive_service.dart';
import 'episode_repository.dart';

class EpisodeRepositoryImpl implements EpisodeRepository {
  final GraphQLService _graphqlService;
  final HiveManager _hiveManager;

  EpisodeRepositoryImpl(this._graphqlService, this._hiveManager);

  @override
  Future<List<dynamic>> fetchAllEpisodes() async {
    try {
      final List<dynamic> list = List.generate(51, (i) => i + 1);

      final result = await _graphqlService.executeQuery(queries['getEpisodesByIds'], variables: {'ids': list});
      if (result.hasException) {
        throw result.exception!;
      }
      final data = await result.data?['episodesByIds'] ?? [];

      String imagePath;
      bool isFavorite, isWatched;
      final allEpisodes = data.map((episode) {
        final index = int.parse(episode['id']) - 1;
        final hiveData = _hiveManager.getValue(index);
        final randomIndex = Random().nextInt(episode['characters'].length);

        isFavorite = hiveData.isNotEmpty ? hiveData['isFavorite'] : false;
        isWatched = hiveData.isNotEmpty ? hiveData['isWatched'] : false;
        imagePath = episode['characters'][randomIndex]['image'];

        updateEpisodeStatus(index, isFavorite, isWatched, imagePath);

        return EpisodeModel(
          id: episode['id'],
          title: episode['name'],
          date: episode['air_date'],
          characters: episode['characters'],
          episodeName: episode['episode'],
          imagePath: imagePath,
          isFavorite: isFavorite,
          isWatched: isWatched,
        );
      }).toList();

      return allEpisodes;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<dynamic>> searchEpisodes(String name) async {
    final result = await _graphqlService.executeQuery(queries['getFilteredEpisodes'], variables: {'name': name});
    final data = result.data?['episodes']['results'] ?? [];
    return List<EpisodeModel>.from(
      data.map((episode) {
        final index = int.parse(episode['id']) - 1;
        final hiveData = _hiveManager.getValue(index);
        return EpisodeModel.fromMap(episode, hiveData);
      }),
    );
  }

  @override
  Future<void> updateEpisodeStatus(int episodeId, bool isFavorite, bool isWatched, String imagePath) async {
    await HiveManager.setValue(episodeId, {'isFavorite': isFavorite, 'isWatched': isWatched, 'imagePath': imagePath});
  }
}
