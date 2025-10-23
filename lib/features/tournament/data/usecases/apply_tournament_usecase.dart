import 'package:cricklo/core/errors/failure.dart';
import 'package:cricklo/core/usecase/usecase.dart';
import 'package:cricklo/features/notifications/domain/entities/invite_response_response_entity.dart';
import 'package:cricklo/features/tournament/data/entities/apply_tournament_usecase_entity.dart';
import 'package:cricklo/features/tournament/domain/repo/tournament_repo.dart';
import 'package:dartz/dartz.dart';

class ApplyTournamentUsecase
    extends
        UseCase<InviteResponseResponseEntity, ApplyTournamentUsecaseEntity> {
  final TournamentRepo _tournamentRepo;

  ApplyTournamentUsecase(this._tournamentRepo);

  @override
  Future<Either<Failure, InviteResponseResponseEntity>> call(
    ApplyTournamentUsecaseEntity entity,
  ) {
    return _tournamentRepo.tournamentApply(entity.tournamentId, {
      "teamId": entity.teamId,
    });
  }
}
