import 'package:worlds_away/core/resources/data_state.dart';
import 'package:worlds_away/core/usecase/usecase.dart';
import 'package:worlds_away/features/shared/firebase_messaging/domain/entities/firebase_notification.dart';
import 'package:worlds_away/features/shared/firebase_messaging/domain/repository/firebase_messaging_repository.dart';

class SendMessageToReceiverUseCase
    implements UseCase<DataState, FirebaseNotificationEntity> {
  final FirebaseMessagingRepository _firebaseMessagingRepository;

  SendMessageToReceiverUseCase(this._firebaseMessagingRepository);

  @override
  Future<DataState> call({FirebaseNotificationEntity? params}) async {
    return _firebaseMessagingRepository.sendMessageToReceiver(params!);
  }
}
