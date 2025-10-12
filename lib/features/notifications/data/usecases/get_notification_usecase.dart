import 'package:cricklo/core/errors/failure.dart';
import 'package:cricklo/core/usecase/stream_usecase.dart';
import 'package:cricklo/features/notifications/domain/repo/notification_repo.dart';
import 'package:dartz/dartz.dart';

class GetNotificationsUseCase
    extends StreamUseCase<Map<String, dynamic>, NoParams> {
  final NotificationRepository repository;

  GetNotificationsUseCase(this.repository);

  @override
  Stream<Either<Failure, Map<String, dynamic>>> call(NoParams params) async* {
    try {
      await for (final notification in repository.notifications()) {
        yield Right(notification);
      }
    } catch (e) {
      yield Left(ServerFailure(message: e.toString()));
    }
  }
}
