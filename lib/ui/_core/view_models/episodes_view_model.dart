import 'package:flutter/material.dart';

import '../../../domain/models/episode.dart';
import '../../../domain/use_cases/episodes/episodes_usecases.dart';
import '../../../data/repositories/episode/episode_repository_impl.dart';

class EpisodesViewModel extends ChangeNotifier {
  late EpisodeRepositoryImpl _repository;
  late EpisodesUsecases _usecases;

  String _filter = '';
  bool _loading = false;
  List<EpisodeModel> _episodes = [], _favoriteEpisodes = [], _filteredEpisodes = [];

  List<EpisodeModel> get episodes => _filteredEpisodes.isEmpty ? _episodes : _filteredEpisodes;

  List<dynamic> get favoriteEpisodes => _favoriteEpisodes;

  bool get loading => _loading;

  String get filter => _filter;

  void init(EpisodeRepositoryImpl repo) {
    _repository = repo;
    _usecases = EpisodesUsecases(_repository);
    fetchEpisodes();
    notifyListeners();
  }

  Future<void> fetchEpisodes() async {
    _loading = true;
    notifyListeners();
    _episodes = await _usecases.getAllEpisodes();
    _loading = false;
    notifyListeners();
  }

  Future<bool> searchEpisodes(String name) async {
    _loading = true;
    notifyListeners();
    if (name.isEmpty) {
      _filter = '';
      _loading = false;
      _filteredEpisodes.clear();
      notifyListeners();
      return false;
    }

    _filteredEpisodes = await _usecases.searchEpisodes(name);
    _filter = _filteredEpisodes.isEmpty ? '' : name;

    _loading = false;
    notifyListeners();
    return _filteredEpisodes.isNotEmpty;
  }

  Future<void> toggleFavorite(int episodeId) async {
    if (_filteredEpisodes.isNotEmpty) {
      final index = _filteredEpisodes.indexWhere((episode) => int.parse(episode.id) - 1 == episodeId);
      if (index != -1) {
        _filteredEpisodes[index] = _filteredEpisodes[index].copyWith(isFavorite: true);
        notifyListeners();
      }
    }

    _episodes[episodeId] = _episodes[episodeId].copyWith(isFavorite: true);
    await _usecases.toggleFavoriteEpisode(
      episodeId,
      _episodes[episodeId].isFavorite,
      _episodes[episodeId].isWatched,
      _episodes[episodeId].imagePath,
    );
    notifyListeners();
  }

  Future<void> toggleWatched(int episodeId) async {
    if (_filteredEpisodes.isNotEmpty) {
      final index = _filteredEpisodes.indexWhere((episode) => int.parse(episode.id) - 1 == episodeId);
      if (index != -1) {
        _filteredEpisodes[index] = _filteredEpisodes[index].copyWith(isWatched: true);
        notifyListeners();
      }
    }

    _episodes[episodeId] = _episodes[episodeId].copyWith(isWatched: true);
    await _usecases.toggleWatchedEpisode(
      episodeId,
      _episodes[episodeId].isFavorite,
      _episodes[episodeId].isWatched,
      _episodes[episodeId].imagePath,
    );
    notifyListeners();
  }

  Future<void> getFavoriteEpisodes() async {
    _loading = true;
    notifyListeners();
    _favoriteEpisodes = _usecases.getFavoriteEpisodes(_episodes);
    _loading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _episodes.clear();
    _filteredEpisodes.clear();
    _favoriteEpisodes.clear();
    _filter = '';
    _loading = false;
    super.dispose();
  }
}
