import 'package:worlds_away/core/resources/data_state.dart';
import 'package:worlds_away/core/usecase/usecase.dart';
import 'package:worlds_away/features/profile/domain/repository/profile_repository.dart';

class ChangeAvatarUseCase implements UseCase<DataState<void>, void> {
  final ProfileRepository _profileRepository;

  ChangeAvatarUseCase(this._profileRepository);

  @override
  Future<DataState<void>> call({void params}) async {
    return _profileRepository.changeAvatar();
  }
}
