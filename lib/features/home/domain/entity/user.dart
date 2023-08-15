class UserEntity {
  final String? email;
  final String? uniqueUid;
  final String? id;
  final String? name;
  final String? about;
  final String? photoUrl;

  const UserEntity({
    required this.email,
    required this.uniqueUid,
    required this.id,
    this.name,
    this.about,
    this.photoUrl,
  });
}
