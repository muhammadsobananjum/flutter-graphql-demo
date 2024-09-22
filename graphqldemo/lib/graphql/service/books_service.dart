import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:graphqldemo/env/app_env.dart';


class GraphQLService {
  static final HttpLink httpLink = HttpLink(AppEnv().graphQLApiUrl);

  static final GraphQLClient client = GraphQLClient(
    cache: GraphQLCache(),
    link: httpLink,
  );

  Future<QueryResult> runQuery(String query, {Map<String, dynamic>? variables}) async {
    final options = QueryOptions(
      document: gql(query),
      variables: variables ?? {},
      fetchPolicy: FetchPolicy.networkOnly,  // Always fetch from network
    );
    return await client.query(options);
  }

  Future<QueryResult> runMutation(String mutation, {Map<String, dynamic>? variables}) async {
    final options = MutationOptions(
      document: gql(mutation),
      variables: variables ?? {},
      fetchPolicy: FetchPolicy.noCache,  // Do not cache the mutation
    );
    return await client.mutate(options);
  }
}
