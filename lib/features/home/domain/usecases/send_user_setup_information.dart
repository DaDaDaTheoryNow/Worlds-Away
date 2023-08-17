import 'package:worlds_away/core/resources/user_setup_data_state.dart';
import 'package:worlds_away/core/usecase/usecase.dart';
import 'package:worlds_away/features/home/domain/entities/user_setup_information.dart';
import 'package:worlds_away/features/home/domain/repository/user_setup_repository.dart';

class SendUserSetupInformationUseCase
    implements UseCase<UserSetupDataState, UserSetupInformationEntity> {
  final UserSetupRepository _initSetupRepository;

  SendUserSetupInformationUseCase(this._initSetupRepository);

  @override
  Future<UserSetupDataState> call({UserSetupInformationEntity? params}) async {
    return _initSetupRepository.sendUserSetupInformation(params!);
  }
}
