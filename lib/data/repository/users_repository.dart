import 'package:diary_flutter/data/model/user_response.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';

part 'users_repository.g.dart';

@JsonSerializable()
class UsersAgreementBody {
  final bool agreement;
  Map<String, dynamic> toJson() => _$UsersAgreementBodyToJson(this);
  UsersAgreementBody({required this.agreement});
}

@RestApi()
abstract interface class UsersRepository {
  factory UsersRepository(Dio dio) = _UsersRepository;
  @POST('/users')
  Future<UserResponse> postUsers({
    @Header('Authorization') required String bearerToken,
  });

  @PUT('/users/agreement')
  Future<UserResponse> putUsersAgreement({
    @Header('Authorization') required String bearerToken,
    @Body() required UsersAgreementBody body,
  });
  @GET('/users/me')
  Future<UserResponse> getCurrentUser({
    @Header('Authorization') required String bearerToken,
  });
}
