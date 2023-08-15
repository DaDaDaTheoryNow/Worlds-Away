import 'package:equatable/equatable.dart';

abstract class BottomNavigationBarEvent extends Equatable {
  final int? currentIndex;
  const BottomNavigationBarEvent({this.currentIndex});

  @override
  List<Object?> get props => [currentIndex];
}

class OnTap extends BottomNavigationBarEvent {
  const OnTap(int index) : super(currentIndex: index);
}
