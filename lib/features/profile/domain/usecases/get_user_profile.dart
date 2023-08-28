import 'package:worlds_away/core/resources/data_state.dart';
import 'package:worlds_away/core/usecase/usecase.dart';
import 'package:worlds_away/features/common/domain/entities/user.dart';
import 'package:worlds_away/features/profile/domain/repository/profile_repository.dart';

class GetUserProfileUseCase
    implements UseCase<DataState<Stream<UserEntity>>, String> {
  final ProfileRepository _profileRepository;

  GetUserProfileUseCase(this._profileRepository);

  @override
  Future<DataState<Stream<UserEntity>>> call({String? params}) async {
    return _profileRepository.getUserProfileStream(params!);
  }
}
