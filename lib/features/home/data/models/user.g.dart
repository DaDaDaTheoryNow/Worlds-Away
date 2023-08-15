// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserModel _$$_UserModelFromJson(Map<String, dynamic> json) => _$_UserModel(
      email: json['email'] as String?,
      uniqueUid: json['uniqueUid'] as String?,
      id: json['id'] as String?,
      name: json['name'] as String?,
      photoUrl: json['photoUrl'] as String?,
      about: json['about'] as String?,
    );

Map<String, dynamic> _$$_UserModelToJson(_$_UserModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'uniqueUid': instance.uniqueUid,
      'id': instance.id,
      'name': instance.name,
      'photoUrl': instance.photoUrl,
      'about': instance.about,
    };
