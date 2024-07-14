import 'package:dio/dio.dart' hide Headers;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:retrofit/retrofit.dart';

part 'users_repository.g.dart';

@RestApi(baseUrl: "/users")
abstract class UsersRepository {
  factory UsersRepository(Dio dio) = _UsersRepository;

  @Headers({
    'idToken': 'true',
  })
  @POST('/')
  Future<dynamic> login(@Body() Map<String, dynamic> body);

  @GET('/me')
  Future<dynamic> me();
}
