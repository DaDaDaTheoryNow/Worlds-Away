import 'package:equatable/equatable.dart';
import 'package:worlds_away/features/home/domain/entity/user.dart';

class SetupPageEvent extends Equatable {
  final String? name;
  final String? id;
  final String? about;

  final UserEntity? user;
  final String? idForAvailableCheck;

  const SetupPageEvent(
      {this.name, this.id, this.about, this.user, this.idForAvailableCheck});

  @override
  List<Object?> get props => [name, id, about, user];
}

class SendSetupInformation extends SetupPageEvent {
  const SendSetupInformation(String name, String id, String about)
      : super(name: name, id: id, about: about);
}

class GetSetupPageInformation extends SetupPageEvent {}

class CheckIdAvailable extends SetupPageEvent {
  const CheckIdAvailable(String idForAvailableCheck)
      : super(idForAvailableCheck: idForAvailableCheck);
}
