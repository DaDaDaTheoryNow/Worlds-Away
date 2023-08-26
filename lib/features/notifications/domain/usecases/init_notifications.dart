import 'package:worlds_away/core/usecase/usecase.dart';
import 'package:worlds_away/features/notifications/domain/repository/notifications_repository.dart';

class InitNotificationsUseCase implements UseCase<void, void> {
  final NotificationsRepository _notificationsRepository;

  InitNotificationsUseCase(this._notificationsRepository);

  @override
  Future<void> call({void params}) async {
    return _notificationsRepository.initNotifications();
  }
}
