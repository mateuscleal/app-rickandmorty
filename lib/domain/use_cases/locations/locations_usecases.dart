import '../../../data/repositories/location/location_repository.dart';
import 'get_all_locations.dart';

class LocationUseCases {
  final LocationRepository repository;
  late GetAllLocations getAllLocations;

  LocationUseCases(this.repository) {
    getAllLocations = GetAllLocations(repository);
  }
}
