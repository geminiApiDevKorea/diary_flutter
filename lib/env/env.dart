import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'GEMENI_API_KEY')
  static const String geminiApiKey = _Env.geminiApiKey;
}
