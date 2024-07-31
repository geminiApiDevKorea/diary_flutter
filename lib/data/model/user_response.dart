import 'package:json_annotation/json_annotation.dart';
part 'user_response.g.dart';

@JsonSerializable()
class UserResponse {
  String name;
  String? email;
  bool? agreement;
  int? code;

  bool get isAgreed => agreement ?? false;

  UserResponse({
    required this.name,
    this.email,
    this.agreement,
    this.code,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}
