import 'package:equatable/equatable.dart';

abstract class UserSetupEvent extends Equatable {
  final String? name;
  final String? id;
  final String? about;

  const UserSetupEvent({this.name, this.id, this.about});

  @override
  List<Object?> get props => [name, id, about];
}

class GetUserSetup extends UserSetupEvent {
  const GetUserSetup();
}
