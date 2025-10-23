import 'package:cricklo/core/errors/failure.dart';
import 'package:cricklo/core/usecase/usecase.dart';
import 'package:cricklo/features/notifications/domain/entities/invite_response_response_entity.dart';
import 'package:cricklo/features/tournament/data/entities/invite_moderators_usecase_entity.dart';
import 'package:cricklo/features/tournament/domain/repo/tournament_repo.dart';
import 'package:dartz/dartz.dart';

class InviteModeratorsUsecase
    extends
        UseCase<InviteResponseResponseEntity, InviteModeratorsUsecaseEntity> {
  final TournamentRepo _tournamentRepo;

  InviteModeratorsUsecase(this._tournamentRepo);

  @override
  Future<Either<Failure, InviteResponseResponseEntity>> call(
    InviteModeratorsUsecaseEntity entity,
  ) {
    return _tournamentRepo.inviteModerators(entity.tournamentId, {
      "profileIds": entity.users.map((e) => e.playerId).toList(),
    });
  }
}
