import 'package:cricklo/core/errors/failure.dart';
import 'package:cricklo/features/notifications/domain/entities/get_notifications_response_entity.dart';
import 'package:cricklo/features/notifications/domain/entities/invite_response_response_entity.dart';
import 'package:dartz/dartz.dart';

abstract class NotificationRepository {
  Stream<Map<String, dynamic>> notifications();
  Future<Either<Failure, GetNotificationsResponseEntity>> getNotifications();
  Future<Either<Failure, InviteResponseResponseEntity>> respondToTeamInvite(
    String teamId,
    String inviteId,
    String action,
  );
  Future<Either<Failure, InviteResponseResponseEntity>> respondToMatchInvite(
    String matchId,
    String inviteId,
    String action,
  );
}
