import 'package:worlds_away/core/resources/data_state.dart';
import 'package:worlds_away/core/usecase/usecase.dart';
import 'package:worlds_away/features/user/profile/domain/repository/profile_repository.dart';

class ChangeNameUseCase implements UseCase<DataState<void>, String> {
  final ProfileRepository _profileRepository;

  ChangeNameUseCase(this._profileRepository);

  @override
  Future<DataState<void>> call({String? params}) async {
    return _profileRepository.changeName(params!);
  }
}
