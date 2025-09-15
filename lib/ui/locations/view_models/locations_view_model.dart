import 'package:app/data/repositories/location/location_repository_impl.dart';
import 'package:flutter/material.dart';

import '../../../domain/models/location.dart';
import '../../../domain/use_cases/locations/locations_usecases.dart';

class LocationsViewModel extends ChangeNotifier {
  bool _loading = false;
  List<LocationModel> _locations = [];
  late LocationUseCases _usecases;
  late LocationRepositoryImpl _repository;

  bool get loading => _loading;

  List<LocationModel> get locations => _locations;

  void init(LocationRepositoryImpl repository) {
    _repository = repository;
    _usecases = LocationUseCases(_repository);
    fetchLocations();
  }

  Future<void> fetchLocations() async {
    _loading = true;
    notifyListeners();
    _locations = await _usecases.getAllLocations();
    _loading = false;
    notifyListeners();
  }
}
