import 'package:equatable/equatable.dart';

class UserSetupInformationEntity extends Equatable {
  final String? id;
  final String? name;
  final String? about;

  const UserSetupInformationEntity({
    required this.id,
    required this.name,
    required this.about,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        about,
      ];
}
