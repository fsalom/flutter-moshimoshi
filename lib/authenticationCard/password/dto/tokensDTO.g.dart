// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tokensDTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenDTO _$TokenDTOFromJson(Map<String, dynamic> json) => TokenDTO(
      json['access_token'] as String,
      json['refresh_token'] as String,
      json['expires_in'] as int,
    );

Map<String, dynamic> _$TokenDTOToJson(TokenDTO instance) => <String, dynamic>{
      'access_token': instance.access_token,
      'refresh_token': instance.refresh_token,
      'expires_in': instance.expires_in,
    };
