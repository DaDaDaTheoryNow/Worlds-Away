import 'package:worlds_away/features/notifications/data/data_sources/remote/remote_notifications_repository.dart';
import 'package:worlds_away/features/notifications/domain/repository/notifications_repository.dart';

class NotificationsRepositoryImpl implements NotificationsRepository {
  final RemoteNotificationsRepository _remoteNotificationsRepository;

  NotificationsRepositoryImpl(this._remoteNotificationsRepository);

  @override
  Future<void> initNotifications() async {
    await _remoteNotificationsRepository.initNotifications();
  }
}
