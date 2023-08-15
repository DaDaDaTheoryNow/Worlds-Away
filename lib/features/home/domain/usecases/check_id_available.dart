import 'package:worlds_away/core/resources/id_available_data_state.dart';
import 'package:worlds_away/core/usecase/usecase.dart';
import 'package:worlds_away/features/home/domain/repository/user_setup_repository.dart';

class CheckIdAvailableUseCase
    implements UseCase<IdAvailableleDataState<bool?>, String> {
  final UserSetupRepository _userSetupRepository;

  CheckIdAvailableUseCase(this._userSetupRepository);

  @override
  Future<IdAvailableleDataState<bool?>> call({String? params}) async {
    return _userSetupRepository.checkIdAvailable(params!);
  }
}
