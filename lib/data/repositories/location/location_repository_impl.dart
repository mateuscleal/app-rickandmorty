import '../../graphql/graphql_queries.dart';
import '../../services/graphql_service.dart';
import 'location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  final GraphQLService _graphqlService;

  LocationRepositoryImpl(this._graphqlService);

  @override
  Future<List<dynamic>> fetchAllEpisodes() async {
    try {
      final result = await _graphqlService.executeQuery(queries['getLocations']);
      if (result.hasException) {
        throw result.exception!;
      }
      return result.data?['locations']['results'] ?? [];
    } catch (e) {
      rethrow;
    }
  }
}
