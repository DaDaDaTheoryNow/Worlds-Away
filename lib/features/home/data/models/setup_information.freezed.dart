// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'setup_information.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$UserSetupInformationModel {
  String? get email => throw _privateConstructorUsedError;
  String? get uniqueUid => throw _privateConstructorUsedError;
  String? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get photoUrl => throw _privateConstructorUsedError;
  String? get about => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UserSetupInformationModelCopyWith<UserSetupInformationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserSetupInformationModelCopyWith<$Res> {
  factory $UserSetupInformationModelCopyWith(UserSetupInformationModel value,
          $Res Function(UserSetupInformationModel) then) =
      _$UserSetupInformationModelCopyWithImpl<$Res, UserSetupInformationModel>;
  @useResult
  $Res call(
      {String? email,
      String? uniqueUid,
      String? id,
      String? name,
      String? photoUrl,
      String? about});
}

/// @nodoc
class _$UserSetupInformationModelCopyWithImpl<$Res,
        $Val extends UserSetupInformationModel>
    implements $UserSetupInformationModelCopyWith<$Res> {
  _$UserSetupInformationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = freezed,
    Object? uniqueUid = freezed,
    Object? id = freezed,
    Object? name = freezed,
    Object? photoUrl = freezed,
    Object? about = freezed,
  }) {
    return _then(_value.copyWith(
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      uniqueUid: freezed == uniqueUid
          ? _value.uniqueUid
          : uniqueUid // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      photoUrl: freezed == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      about: freezed == about
          ? _value.about
          : about // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UserSetupInformationModelCopyWith<$Res>
    implements $UserSetupInformationModelCopyWith<$Res> {
  factory _$$_UserSetupInformationModelCopyWith(
          _$_UserSetupInformationModel value,
          $Res Function(_$_UserSetupInformationModel) then) =
      __$$_UserSetupInformationModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? email,
      String? uniqueUid,
      String? id,
      String? name,
      String? photoUrl,
      String? about});
}

/// @nodoc
class __$$_UserSetupInformationModelCopyWithImpl<$Res>
    extends _$UserSetupInformationModelCopyWithImpl<$Res,
        _$_UserSetupInformationModel>
    implements _$$_UserSetupInformationModelCopyWith<$Res> {
  __$$_UserSetupInformationModelCopyWithImpl(
      _$_UserSetupInformationModel _value,
      $Res Function(_$_UserSetupInformationModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = freezed,
    Object? uniqueUid = freezed,
    Object? id = freezed,
    Object? name = freezed,
    Object? photoUrl = freezed,
    Object? about = freezed,
  }) {
    return _then(_$_UserSetupInformationModel(
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      uniqueUid: freezed == uniqueUid
          ? _value.uniqueUid
          : uniqueUid // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      photoUrl: freezed == photoUrl
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      about: freezed == about
          ? _value.about
          : about // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_UserSetupInformationModel implements _UserSetupInformationModel {
  const _$_UserSetupInformationModel(
      {this.email,
      this.uniqueUid,
      this.id,
      this.name,
      this.photoUrl,
      this.about});

  @override
  final String? email;
  @override
  final String? uniqueUid;
  @override
  final String? id;
  @override
  final String? name;
  @override
  final String? photoUrl;
  @override
  final String? about;

  @override
  String toString() {
    return 'UserSetupInformationModel(email: $email, uniqueUid: $uniqueUid, id: $id, name: $name, photoUrl: $photoUrl, about: $about)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserSetupInformationModel &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.uniqueUid, uniqueUid) ||
                other.uniqueUid == uniqueUid) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl) &&
            (identical(other.about, about) || other.about == about));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, email, uniqueUid, id, name, photoUrl, about);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserSetupInformationModelCopyWith<_$_UserSetupInformationModel>
      get copyWith => __$$_UserSetupInformationModelCopyWithImpl<
          _$_UserSetupInformationModel>(this, _$identity);
}

abstract class _UserSetupInformationModel implements UserSetupInformationModel {
  const factory _UserSetupInformationModel(
      {final String? email,
      final String? uniqueUid,
      final String? id,
      final String? name,
      final String? photoUrl,
      final String? about}) = _$_UserSetupInformationModel;

  @override
  String? get email;
  @override
  String? get uniqueUid;
  @override
  String? get id;
  @override
  String? get name;
  @override
  String? get photoUrl;
  @override
  String? get about;
  @override
  @JsonKey(ignore: true)
  _$$_UserSetupInformationModelCopyWith<_$_UserSetupInformationModel>
      get copyWith => throw _privateConstructorUsedError;
}
