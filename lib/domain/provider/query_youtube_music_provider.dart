import 'package:diary_flutter/data/http/youtube_search_response.dart';
import 'package:diary_flutter/data/provider/youtube_rest_client_provider.dart';
import 'package:diary_flutter/env/env.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'query_youtube_music_provider.g.dart';

sealed class QueryYoutubeMusicState {}

class InitialQueryYoutubeMusicState extends QueryYoutubeMusicState {}

class LoadingQueryYoutubeMusicState extends QueryYoutubeMusicState {}

class SuccessQueryYoutubeMusicState extends QueryYoutubeMusicState {
  final YoutubeItem item;
  SuccessQueryYoutubeMusicState({required this.item});
}

@Riverpod(keepAlive: false)
class QueryYoutubeMusic extends _$QueryYoutubeMusic {
  @override
  QueryYoutubeMusicState build() {
    return InitialQueryYoutubeMusicState();
  }

  request({required String query}) async {
    state = LoadingQueryYoutubeMusicState();
    final youtubeRestClient = ref.read(youtubeRestClientProvider);
    final response = await youtubeRestClient.search(
      'snippet',
      1,
      query,
      'video',
      Env.youtubeDataApiKey,
    );
    state = SuccessQueryYoutubeMusicState(item: response.items.first);
  }
}
