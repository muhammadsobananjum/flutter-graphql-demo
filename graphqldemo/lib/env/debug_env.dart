import 'package:envied/envied.dart';

import 'app_env.dart';
import 'app_env_fields.dart';

part 'debug_env.g.dart';

@Envied(name: 'Env', path: '.env_debug')
final class DebugEnv implements AppEnv, AppEnvFields {
  DebugEnv();

  @override
  @EnviedField(varName: 'GRAPHQL_API_URL')
  final String graphQLApiUrl = _Env.graphQLApiUrl;
}
