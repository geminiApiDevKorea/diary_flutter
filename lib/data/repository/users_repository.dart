import 'package:diary_flutter/data/model/user_post_response.dart';
import 'package:diary_flutter/data/model/user_put_agreement_response.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:retrofit/retrofit.dart';

part 'users_repository.g.dart';

@RestApi()
abstract class UsersRepository {
  factory UsersRepository(Dio dio) = _UsersRepository;
  @POST('/users')
  Future<UserPostResponse> createUser(
      {@Header('Authorization') required String bearerIdToken});

  @PUT('/users/agreement')
  Future<UserPutAgreementResponse> updateUserAgreement({
    @Body() required Map<String, dynamic> body,
  });
  @GET('/users/me')
  Future<dynamic> getCurrentUser();
}
