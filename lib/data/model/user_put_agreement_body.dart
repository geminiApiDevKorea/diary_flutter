import 'package:json_annotation/json_annotation.dart';
part 'user_put_agreement_body.g.dart';

@JsonSerializable()
class UserPutAgreementBody {
  bool? agreement;

  UserPutAgreementBody({
    this.agreement,
  });

  factory UserPutAgreementBody.fromJson(Map<String, dynamic> json) =>
      _$UserPutAgreementBodyFromJson(json);

  Map<String, dynamic> toJson() => _$UserPutAgreementBodyToJson(this);

  UserPutAgreementBody copyWith({
    bool? agreement,
  }) {
    return UserPutAgreementBody(
      agreement: agreement ?? this.agreement,
    );
  }
}
