import 'package:cricklo/core/errors/failure.dart';
import 'package:cricklo/core/usecase/usecase.dart';
import 'package:cricklo/features/notifications/domain/entities/get_notifications_response_entity.dart';
import 'package:cricklo/features/notifications/domain/repo/notification_repo.dart';
import 'package:dartz/dartz.dart';

class FetchNotificationsUsecase
    extends UseCase<GetNotificationsResponseEntity, NoParams> {
  final NotificationRepository _mainAppRepository;

  FetchNotificationsUsecase(this._mainAppRepository);

  @override
  Future<Either<Failure, GetNotificationsResponseEntity>> call(
    NoParams entity,
  ) {
    return _mainAppRepository.getNotifications();
  }
}
