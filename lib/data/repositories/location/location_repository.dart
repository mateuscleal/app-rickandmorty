import '../../model/location_dto.dart';

abstract class LocationRepository {
  Future<List<LocationDto>> fetchAllLocations();
}
