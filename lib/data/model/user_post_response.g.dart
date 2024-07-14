// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_post_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPostResponse _$UserPostResponseFromJson(Map<String, dynamic> json) =>
    UserPostResponse(
      name: json['name'] as String?,
      email: json['email'] as String?,
      agreement: json['agreement'] as bool?,
      code: json['code'] as String?,
    );

Map<String, dynamic> _$UserPostResponseToJson(UserPostResponse instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'agreement': instance.agreement,
      'code': instance.code,
    };
