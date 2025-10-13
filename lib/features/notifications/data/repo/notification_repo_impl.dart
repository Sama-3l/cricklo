import 'package:cricklo/core/errors/failure.dart';
import 'package:cricklo/features/notifications/data/datasource/notification_datasource.dart';
import 'package:cricklo/features/notifications/domain/entities/get_notifications_response_entity.dart';
import 'package:cricklo/features/notifications/domain/entities/team_invite_response_response_entity.dart';
import 'package:cricklo/features/notifications/domain/repo/notification_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDataSource remoteDataSource;

  NotificationRepositoryImpl({required this.remoteDataSource});

  @override
  Stream<Map<String, dynamic>> notifications() {
    return remoteDataSource.getNotificationStream();
  }

  @override
  Future<Either<Failure, GetNotificationsResponseEntity>>
  getNotifications() async {
    try {
      final response = await remoteDataSource.getNotifications();
      return Right(response.toEntity());
    } on DioException catch (e) {
      final data = e.response?.data;

      final code = data?['error']?['code'];
      final message = data?['error']?['message'];

      return Right(
        GetNotificationsResponseEntity(
          count: 0,
          teamNotifications: [],
          matchNotifications: [],
          success: false,
          message: message,
          errorCode: code,
        ),
      );
    } catch (e) {
      return Left(ServerFailure(message: "Unexpected error: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, TeamInviteResponseResponseEntity>> respondToTeamInvite(
    String teamId,
    String inviteId,
    String action,
  ) async {
    try {
      final response = await remoteDataSource.respondToTeamInvite(
        teamId,
        inviteId,
        action,
      );
      return Right(response.toEntity());
    } on DioException catch (e) {
      final data = e.response?.data;

      final code = data?['error']?['code'];
      final message = data?['error']?['message'];

      return Right(
        TeamInviteResponseResponseEntity(
          success: false,
          message: message,
          errorCode: code,
        ),
      );
    } catch (e) {
      return Left(ServerFailure(message: "Unexpected error: ${e.toString()}"));
    }
  }
}
