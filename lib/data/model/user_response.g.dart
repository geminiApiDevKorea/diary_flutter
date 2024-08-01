// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) => UserResponse(
      name: json['name'] as String,
      email: json['email'] as String?,
      agreement: json['agreement'] as bool?,
      nickname: json['nickname'] as String?,
      gender: json['gender'] as String?,
      code: (json['code'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'agreement': instance.agreement,
      'nickname': instance.nickname,
      'gender': instance.gender,
      'code': instance.code,
    };
