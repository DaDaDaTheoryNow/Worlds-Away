import 'package:equatable/equatable.dart';

abstract class ChangeEvent extends Equatable {
  final String? name;
  final String? about;

  final String? id;

  const ChangeEvent({this.about, this.name, this.id});

  @override
  List<Object?> get props => [about, name, id];
}

class ChangeName extends ChangeEvent {
  const ChangeName(String name) : super(name: name);
}

class ChangeAbout extends ChangeEvent {
  const ChangeAbout(String about) : super(about: about);
}

class ChangeId extends ChangeEvent {
  const ChangeId(String id) : super(id: id);
}

class ChangeInititState extends ChangeEvent {}

class ChangeCheckIdAvailable extends ChangeEvent {
  const ChangeCheckIdAvailable(String id) : super(id: id);
}
