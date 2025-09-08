import 'package:flutter/material.dart';

import '../../../data/repositories/episode/episode_repository_impl.dart';

class EpisodesViewModel extends ChangeNotifier {
  String _filter = '';
  bool _loading = false;
  List<dynamic> _episodes = [], _favoriteEpisodes = [], _filteredEpisodes = [];
  late EpisodeRepositoryImpl _repository;

  List<dynamic> get episodes => _filteredEpisodes.isEmpty ? _episodes : _filteredEpisodes;

  List<dynamic> get favoriteEpisodes => _favoriteEpisodes;

  bool get loading => _loading;

  String get filter => _filter;

  void init(EpisodeRepositoryImpl repo) {
    _repository = repo;
    fetchEpisodes();
    notifyListeners();
  }

  Future<void> fetchEpisodes() async {
    _loading = true;
    notifyListeners();
    _episodes = await _repository.fetchAllEpisodes();
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

    _filteredEpisodes = await _repository.searchEpisodes(name);
    if (_filteredEpisodes.isEmpty) {
      _filter = '';
      _loading = false;
      notifyListeners();
      return false;
    }

    _filter = name;
    _loading = false;
    notifyListeners();
    return true;
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
    await _repository.updateEpisodeStatus(
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
    await _repository.updateEpisodeStatus(
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
    _favoriteEpisodes = _episodes.where((episode) => episode.isFavorite).toList();
    _loading = false;
    notifyListeners();
  }
}
