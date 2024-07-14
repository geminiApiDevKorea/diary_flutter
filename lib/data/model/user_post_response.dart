import 'package:json_annotation/json_annotation.dart';
part 'user_post_response.g.dart';

@JsonSerializable()
class UserPostResponse {
  String? name;
  String? email;
  bool? agreement;
  String? code;

  UserPostResponse({
    this.name,
    this.email,
    this.agreement,
    this.code,
  });

  factory UserPostResponse.fromJson(Map<String, dynamic> json) =>
      _$UserPostResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserPostResponseToJson(this);

  UserPostResponse copyWith({
    String? name,
    String? email,
    bool? agreement,
    String? code,
  }) {
    return UserPostResponse(
      name: name ?? this.name,
      email: email ?? this.email,
      agreement: agreement ?? this.agreement,
      code: code ?? this.code,
    );
  }
}
