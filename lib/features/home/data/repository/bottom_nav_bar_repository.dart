import 'package:flutter/material.dart';
import 'package:worlds_away/features/home/domain/repository/bottom_nav_bar_repository.dart';
import 'package:worlds_away/injection_container.dart';

class BottomNavigatonBarRepositoryImpl
    implements BottomNavigationBarRepository {
  @override
  PageController get pageController => sl<PageController>();

  @override
  void onTap(int index) {
    return pageController.jumpToPage(index);
  }
}
