import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:worlds_away/features/home/domain/entity/user.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class UserModel extends UserEntity with _$UserModel {
  const factory UserModel({
    String? email,
    String? uniqueUid,
    String? id,
    String? name,
    String? photoUrl,
    String? about,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
