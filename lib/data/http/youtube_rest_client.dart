import 'package:diary_flutter/data/http/youtube_search_response.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

part 'youtube_rest_client.g.dart';

@RestApi()
abstract class YoutubeRestClient {
  factory YoutubeRestClient(Dio dio) = _YoutubeRestClient;

  // curl \
  // 'https://youtube.googleapis.com/youtube/v3/search?part=snippet&maxResults=1&q=%EC%95%84%EC%9D%B4%EC%9C%A0%2C%EB%B0%A4%ED%8E%B8%EC%A7%80&type=video&key=[YOUR_API_KEY]' \
  // --header 'Authorization: Bearer [YOUR_ACCESS_TOKEN]' \
  // --header 'Accept: application/json' \
  // --compressed
  @GET('/search')
  @Headers(<String, dynamic>{
    'Accept': 'application/json',
  })
  Future<YoutubeSearchResponse> search(
    @Query('part') String part,
    @Query('maxResults') int? maxResults,
    @Query('q') String q,
    @Query('type') String type,
    @Query('key') String key,
  );
}
