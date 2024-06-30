import 'package:diary_flutter/data/http/youtube_rest_client.dart';
import 'package:diary_flutter/data/provider/dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'youtube_rest_client_provider.g.dart';

@Riverpod(keepAlive: false)
YoutubeRestClient youtubeRestClient(YoutubeRestClientRef ref) {
  return YoutubeRestClient(
    ref.read(
      dioProvider(baseUrl: 'https://youtube.googleapis.com/youtube/v3'),
    ),
  );
}
