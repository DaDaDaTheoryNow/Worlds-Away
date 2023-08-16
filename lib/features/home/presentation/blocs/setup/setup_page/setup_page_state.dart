import 'package:equatable/equatable.dart';
import 'package:worlds_away/features/common/domain/entity/user.dart';

class SetupPageState extends Equatable {
  final UserEntity? user;
  final bool? idIsAvailable;
  final String? error;

  const SetupPageState({this.user, this.error, this.idIsAvailable});

  @override
  List<Object?> get props => [user, error];
}

class SetupPageDone extends SetupPageState {
  const SetupPageDone(UserEntity? user, bool? idIsAvailable)
      : super(user: user, idIsAvailable: idIsAvailable);
}

class SetupPageSendInformationDone extends SetupPageState {}

class SetupPageLoading extends SetupPageState {}

class SetupPageError extends SetupPageState {
  const SetupPageError(String error) : super(error: error);
}
