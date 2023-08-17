import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? email;
  final String? uniqueUid;
  final String? id;
  final String? name;
  final String? about;
  final String? photoUrl;

  const UserEntity({
    this.email,
    this.uniqueUid,
    this.id,
    this.name,
    this.about,
    this.photoUrl,
  });

  @override
  List<Object?> get props => [email, uniqueUid, id, name, about, photoUrl];
}
