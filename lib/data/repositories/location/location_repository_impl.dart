
import '../../graphql/graphql_queries.dart';
import '../../model/location_dto.dart';
import '../../services/graphql_service.dart';
import 'location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  final GraphQLService _graphqlService;

  LocationRepositoryImpl(this._graphqlService);

  @override
  Future<List<LocationDto>> fetchAllLocations() async {
    try {
      final result = await _graphqlService.executeQuery(queries['getLocations']);
      final data = await result.data?['locations']['results'] ?? [];
      return data.map<LocationDto>((location) => LocationDto.fromMap(location)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
