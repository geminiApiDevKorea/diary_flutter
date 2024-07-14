import 'package:json_annotation/json_annotation.dart';
part 'user_put_agreement_response.g.dart';

@JsonSerializable()
class UserPutAgreementResponse {
  String? name;
  String? email;
  bool? agreement;
  String? code;

  UserPutAgreementResponse({
    this.name,
    this.email,
    this.agreement,
    this.code,
  });

  factory UserPutAgreementResponse.fromJson(Map<String, dynamic> json) =>
      _$UserPutAgreementResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserPutAgreementResponseToJson(this);

  UserPutAgreementResponse copyWith({
    String? name,
    String? email,
    bool? agreement,
    String? code,
  }) {
    return UserPutAgreementResponse(
      name: name ?? this.name,
      email: email ?? this.email,
      agreement: agreement ?? this.agreement,
      code: code ?? this.code,
    );
  }
}
