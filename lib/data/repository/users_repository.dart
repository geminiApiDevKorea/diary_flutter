import 'package:dio/dio.dart' hide Headers;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:retrofit/retrofit.dart';

part 'users_repository.g.dart';

@RestApi()
abstract class UsersRepository {
  factory UsersRepository(Dio dio) = _UsersRepository;

  // @Headers({
  //   'idToken': 'true',
  // })
  @POST('/users')
  Future<dynamic> login(
      {@Header('Authorization') required String bearerIdToken});

  @GET('/users/me')
  Future<dynamic> me();
}
