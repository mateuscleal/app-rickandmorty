
import '../../../data/repositories/location/location_repository.dart';
import '../../models/location.dart';

class GetAllLocations {
  final LocationRepository repository;

  GetAllLocations(this.repository);

  Future<List<LocationModel>> call() async {
    final dto = await repository.fetchAllLocations();
    return dto.map((location) => location.toDomain()).toList();

  }
}