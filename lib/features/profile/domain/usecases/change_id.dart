import 'package:worlds_away/core/resources/data_state.dart';
import 'package:worlds_away/core/usecase/usecase.dart';
import 'package:worlds_away/features/profile/domain/repository/profile_repository.dart';

class ChangeIdUseCase implements UseCase<DataState<void>, String> {
  final ProfileRepository _profileRepository;

  ChangeIdUseCase(this._profileRepository);

  @override
  Future<DataState<void>> call({String? params}) async {
    return _profileRepository.changeId(params!);
  }
}
