import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLService {
  final String _apiUrl = "https://rickandmortyapi.com/graphql";
  late GraphQLClient client;

  GraphQLService() {
    final HttpLink httpLink = HttpLink(_apiUrl);

    client = GraphQLClient(link: httpLink, cache: GraphQLCache());
  }

  Future<QueryResult> executeQuery(String query, {Map<String, dynamic>? variables}) async {
    final options = QueryOptions(document: gql(query), variables: variables ?? {});
    return await client.query(options);
  }
}
