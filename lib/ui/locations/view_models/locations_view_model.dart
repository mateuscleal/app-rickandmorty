import 'package:app/data/repositories/location/location_repository_impl.dart';
import 'package:flutter/material.dart';

class LocationsViewModel extends ChangeNotifier {
  int _idReference = 0;
  bool _loading = false;
  List<dynamic> _locations = [];
  late LocationRepositoryImpl _repository;

  bool get loading => _loading;

  int get idReference => _idReference;

  List<dynamic> get locations => _locations;

  void initRepository(LocationRepositoryImpl repository) {
    _repository = repository;
    fetchLocations();
    notifyListeners();
  }

  void setReference(int id) {
    _idReference = id;
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
