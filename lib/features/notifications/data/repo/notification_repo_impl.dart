import 'package:cricklo/features/notifications/data/datasource/notification_datasource.dart';
import 'package:cricklo/features/notifications/domain/repo/notification_repo.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDataSource remoteDataSource;

  NotificationRepositoryImpl({required this.remoteDataSource});

  @override
  Stream<Map<String, dynamic>> notifications() {
    return remoteDataSource.getNotificationStream();
  }
}
