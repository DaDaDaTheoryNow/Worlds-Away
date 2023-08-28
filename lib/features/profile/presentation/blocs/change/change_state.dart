import 'package:equatable/equatable.dart';

class ChangeState extends Equatable {
  final bool? idAvailableStatus;
  final String? error;

  const ChangeState({this.error, this.idAvailableStatus});

  @override
  List<Object?> get props => [error];
}

class ChangeLoading extends ChangeState {}

class ChangeDone extends ChangeState {}

class ChangeError extends ChangeState {
  const ChangeError(String error) : super(error: error);
}
