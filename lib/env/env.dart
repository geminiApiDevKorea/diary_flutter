import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'GEMENI_API_KEY')
  static const String geminiApiKey = _Env.geminiApiKey;

  @EnviedField(varName: 'YOUTUBE_DATA_API_KEY')
  static const String youtubeDataApiKey = _Env.youtubeDataApiKey;

  @EnviedField(varName: 'BASE_URL')
  static const String baseUrl = _Env.baseUrl;
}
