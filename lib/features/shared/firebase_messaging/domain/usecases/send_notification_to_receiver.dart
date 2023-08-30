import 'package:worlds_away/core/resources/data_state.dart';
import 'package:worlds_away/core/usecase/usecase.dart';
import 'package:worlds_away/features/shared/firebase_messaging/domain/entities/firebase_notification.dart';
import 'package:worlds_away/features/shared/firebase_messaging/domain/repository/firebase_messaging_repository.dart';

class SendNotificationToReceiverUseCase
    implements UseCase<DataState, FirebaseNotificationEntity> {
  final FirebaseMessagingRepository _firebaseMessagingRepository;

  SendNotificationToReceiverUseCase(this._firebaseMessagingRepository);

  @override
  Future<DataState> call({FirebaseNotificationEntity? params}) async {
    return _firebaseMessagingRepository.sendNotificationToReceiver(params!);
  }
}
