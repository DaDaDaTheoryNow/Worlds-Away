import 'package:equatable/equatable.dart';

abstract class ChangeEvent extends Equatable {
  final String? name;
  final String? about;

  const ChangeEvent({this.about, this.name});

  @override
  List<Object?> get props => [about, name];
}

class ChangeName extends ChangeEvent {
  const ChangeName(String name) : super(name: name);
}

class ChangeAbout extends ChangeEvent {
  const ChangeAbout(String about) : super(about: about);
}
