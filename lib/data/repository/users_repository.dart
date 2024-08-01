import 'package:diary_flutter/common/enums.dart';
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

@JsonSerializable()
class UsersRequestBody {
  String nickname;
  Gender gender;

  UsersRequestBody({
    required this.nickname,
    required this.gender,
  });

  factory UsersRequestBody.fromJson(Map<String, dynamic> json) =>
      _$UsersRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$UsersRequestBodyToJson(this);

  UsersRequestBody copyWith({
    String? nickname,
    Gender? gender,
  }) {
    return UsersRequestBody(
      nickname: nickname ?? this.nickname,
      gender: gender ?? this.gender,
    );
  }

  @override
  String toString() {
    return 'UsersRequestBody(nickname: $nickname, gender: $gender)';
  }
}

@RestApi()
abstract interface class UsersRepository {
  factory UsersRepository(Dio dio) = _UsersRepository;
  @POST('/users')
  Future<UserResponse> postUsers(
      {@Header('Authorization') required String bearerToken,
      @Body() required UsersRequestBody body});

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
