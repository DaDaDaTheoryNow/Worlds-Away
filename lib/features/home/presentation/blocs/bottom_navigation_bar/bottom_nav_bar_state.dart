import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class BottomNavigationBarState extends Equatable {
  final int? currentIndex;
  final PageController? pageController;

  const BottomNavigationBarState({this.currentIndex, this.pageController});

  @override
  List<Object?> get props => [currentIndex, pageController];
}
