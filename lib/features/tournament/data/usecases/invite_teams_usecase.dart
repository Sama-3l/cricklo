import 'package:cricklo/core/errors/failure.dart';
import 'package:cricklo/core/usecase/usecase.dart';
import 'package:cricklo/features/notifications/domain/entities/invite_response_response_entity.dart';
import 'package:cricklo/features/tournament/data/entities/invite_teams_usecase_entity.dart';
import 'package:cricklo/features/tournament/domain/repo/tournament_repo.dart';
import 'package:dartz/dartz.dart';

class InviteTeamsUsecase
    extends UseCase<InviteResponseResponseEntity, InviteTeamsUsecaseEntity> {
  final TournamentRepo _tournamentRepo;

  InviteTeamsUsecase(this._tournamentRepo);

  @override
  Future<Either<Failure, InviteResponseResponseEntity>> call(
    InviteTeamsUsecaseEntity entity,
  ) {
    return _tournamentRepo.inviteTeams(entity.tournamentId, {
      "teamIds": entity.teams.map((e) => e.id).toList(),
    });
  }
}
