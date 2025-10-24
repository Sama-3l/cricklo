import 'package:cricklo/core/errors/failure.dart';
import 'package:cricklo/core/usecase/usecase.dart';
import 'package:cricklo/features/notifications/data/entities/team_response_invite_usecase_entity.dart';
import 'package:cricklo/features/notifications/domain/entities/invite_response_response_entity.dart';
import 'package:cricklo/features/notifications/domain/repo/notification_repo.dart';
import 'package:dartz/dartz.dart';

class TournamentResponseInviteUsecase
    extends UseCase<InviteResponseResponseEntity, ResponseInviteUsecaseEntity> {
  final NotificationRepository _mainAppRepository;

  TournamentResponseInviteUsecase(this._mainAppRepository);

  @override
  Future<Either<Failure, InviteResponseResponseEntity>> call(
    ResponseInviteUsecaseEntity entity,
  ) {
    return _mainAppRepository.respondToTournamentInvite(
      entity.id,
      entity.inviteId,
      entity.action,
    );
  }
}
