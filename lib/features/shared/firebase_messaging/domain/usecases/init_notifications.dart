import 'package:worlds_away/core/resources/data_state.dart';
import 'package:worlds_away/core/usecase/usecase.dart';
import 'package:worlds_away/features/shared/firebase_messaging/domain/repository/firebase_messaging_repository.dart';

class InitNotificationsUseCase implements UseCase<DataState, void> {
  final FirebaseMessagingRepository _firebaseMessagingRepository;

  InitNotificationsUseCase(this._firebaseMessagingRepository);

  @override
  Future<DataState> call({params}) async {
    return _firebaseMessagingRepository.initNotifications();
  }
}
