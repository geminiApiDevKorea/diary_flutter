import 'package:json_annotation/json_annotation.dart';
part 'user_put_agreement_response.g.dart';

@JsonSerializable()
class UserPutAgreementResponse {
  String? name;
  String? email;
  bool? agreement;
  int? code;

  UserPutAgreementResponse({
    this.name,
    this.email,
    this.agreement,
    this.code,
  });

  factory UserPutAgreementResponse.fromJson(Map<String, dynamic> json) =>
      _$UserPutAgreementResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserPutAgreementResponseToJson(this);
}
