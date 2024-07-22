// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_put_agreement_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPutAgreementResponse _$UserPutAgreementResponseFromJson(
        Map<String, dynamic> json) =>
    UserPutAgreementResponse(
      name: json['name'] as String?,
      email: json['email'] as String?,
      agreement: json['agreement'] as bool?,
      code: (json['code'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UserPutAgreementResponseToJson(
        UserPutAgreementResponse instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'agreement': instance.agreement,
      'code': instance.code,
    };
