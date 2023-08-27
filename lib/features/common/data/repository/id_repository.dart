import 'package:worlds_away/core/resources/data_state.dart';
import 'package:worlds_away/features/common/data/data_sources/id/remote_id_repository.dart';
import 'package:worlds_away/features/common/domain/repository/id_repository.dart';

class IdRepositoryImpl implements IdRepository {
  final RemoteIdRepository _remoteIdRepository;

  IdRepositoryImpl(this._remoteIdRepository);

  @override
  Future<DataState<bool>> checkIdAvailable(String id) async {
    try {
      final bool? isAvailable = await _remoteIdRepository.checkIdAvailable(id);

      if (isAvailable != null) {
        return DataSuccess(isAvailable);
      }
    } catch (e) {
      return const DataFailed("Error: Нужно Интернет Соединение");
    }

    return const DataSuccess(false);
  }
}
