import 'package:envied/envied.dart';

import 'app_env.dart';
import 'app_env_fields.dart';

part 'release_env.g.dart';

@Envied(name: 'Env', path: '.env')
final class ReleaseEnv implements AppEnv, AppEnvFields {
  ReleaseEnv();

  @override
  @EnviedField(varName: 'GRAPHQL_API_URL')
  final String graphQLApiUrl = _Env.graphQLApiUrl;
}
