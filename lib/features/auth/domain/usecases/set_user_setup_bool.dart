import 'package:worlds_away/core/usecase/usecase.dart';
import 'package:worlds_away/features/home/domain/repository/user_setup_repository.dart';

class SetUserSetupBoolUseCase implements UseCase<void, bool> {
  final UserSetupRepository _initSetupRepository;

  SetUserSetupBoolUseCase(this._initSetupRepository);

  @override
  Future<void> call({bool? params}) async {
    return _initSetupRepository.setUserSetupBool(params!);
  }
}
