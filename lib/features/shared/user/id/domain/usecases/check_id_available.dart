import 'package:worlds_away/core/resources/data_state.dart';
import 'package:worlds_away/core/usecase/usecase.dart';
import 'package:worlds_away/features/shared/user/id/domain/repository/id_repository.dart';

class CheckIdAvailableUseCase implements UseCase<DataState<bool?>, String> {
  final IdRepository _idRepository;

  CheckIdAvailableUseCase(this._idRepository);

  @override
  Future<DataState<bool?>> call({String? params}) async {
    return _idRepository.checkIdAvailable(params!);
  }
}
