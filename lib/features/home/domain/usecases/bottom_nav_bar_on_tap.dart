import 'package:worlds_away/core/usecase/usecase.dart';
import 'package:worlds_away/features/home/domain/repository/bottom_nav_bar_repository.dart';

class BottomNavBarOnTapUseCase implements UseCase<void, int> {
  final BottomNavigationBarRepository _bottomNavigationBarRepository;

  BottomNavBarOnTapUseCase(this._bottomNavigationBarRepository);

  @override
  Future<void> call({int? params}) async {
    return _bottomNavigationBarRepository.onTap(params!);
  }
}
