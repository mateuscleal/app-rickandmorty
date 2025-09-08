import 'package:app/data/repositories/location/location_repository_impl.dart';
import 'package:flutter/material.dart';

class LocationsViewModel extends ChangeNotifier {
  bool _loading = false;
  List<dynamic> _locations = [];
  late LocationRepositoryImpl _repository;

  bool get loading => _loading;

  List<dynamic> get locations => _locations;

  void init(LocationRepositoryImpl repository) {
    _repository = repository;
    fetchLocations();
    notifyListeners();
  }

  Future<void> fetchLocations() async {
    _loading = true;
    notifyListeners();
    _locations = await _repository.fetchAllEpisodes();
    _loading = false;
    notifyListeners();
  }
}
