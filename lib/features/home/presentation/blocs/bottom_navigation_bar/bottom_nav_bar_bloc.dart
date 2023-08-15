import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:worlds_away/features/home/domain/repository/bottom_nav_bar_repository.dart';
import 'package:worlds_away/features/home/domain/usecases/bottom_nav_bar_on_tap.dart';
import 'package:worlds_away/features/home/presentation/blocs/bottom_navigation_bar/bottom_nav_bar_event.dart';
import 'package:worlds_away/features/home/presentation/blocs/bottom_navigation_bar/bottom_nav_bar_state.dart';

class BottomNavigationBarBloc
    extends Bloc<BottomNavigationBarEvent, BottomNavigationBarState> {
  final BottomNavigationBarRepository _bottomNavigationBarRepository;
  final BottomNavBarOnTapUseCase _bottomNavBarOnTapUseCase;

  BottomNavigationBarBloc(
      this._bottomNavigationBarRepository, this._bottomNavBarOnTapUseCase)
      : super(BottomNavigationBarState(
          pageController: _bottomNavigationBarRepository.pageController,
          currentIndex: 0,
        )) {
    on<OnTap>(onTap);
  }

  void onTap(OnTap event, Emitter emit) {
    _bottomNavBarOnTapUseCase.call(params: event.currentIndex!);

    emit(
      BottomNavigationBarState(
        pageController: _bottomNavigationBarRepository.pageController,
        currentIndex: event.currentIndex!,
      ),
    );
  }
}
