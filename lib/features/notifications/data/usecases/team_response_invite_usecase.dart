import 'package:cricklo/core/errors/failure.dart';
import 'package:cricklo/core/usecase/usecase.dart';
import 'package:cricklo/features/notifications/data/entities/team_response_invite_usecase_entity.dart';
import 'package:cricklo/features/notifications/domain/entities/team_invite_response_response_entity.dart';
import 'package:cricklo/features/notifications/domain/repo/notification_repo.dart';
import 'package:dartz/dartz.dart';

class TeamResponseInviteUsecase
    extends
        UseCase<
          TeamInviteResponseResponseEntity,
          TeamResponseInviteUsecaseEntity
        > {
  final NotificationRepository _mainAppRepository;

  TeamResponseInviteUsecase(this._mainAppRepository);

  @override
  Future<Either<Failure, TeamInviteResponseResponseEntity>> call(
    TeamResponseInviteUsecaseEntity entity,
  ) {
    return _mainAppRepository.respondToTeamInvite(
      entity.teamId,
      entity.inviteId,
      entity.action,
    );
  }
}
