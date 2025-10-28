import 'package:cricklo/core/errors/failure.dart';
import 'package:cricklo/core/usecase/usecase.dart';
import 'package:cricklo/features/notifications/domain/entities/invite_response_response_entity.dart';
import 'package:cricklo/features/tournament/data/entities/moderator_update_match_usecase_entity.dart';
import 'package:cricklo/features/tournament/domain/repo/tournament_repo.dart';
import 'package:dartz/dartz.dart';

class ModeratorUpdateMatchUsecase
    extends
        UseCase<
          InviteResponseResponseEntity,
          ModeratorUpdateMatchUsecaseEntity
        > {
  final TournamentRepo _tournamentRepo;

  ModeratorUpdateMatchUsecase(this._tournamentRepo);

  @override
  Future<Either<Failure, InviteResponseResponseEntity>> call(
    ModeratorUpdateMatchUsecaseEntity entity,
  ) {
    return _tournamentRepo.moderatorUpdateMatch(entity.tournamentId, {
      "matchId": entity.matchId,
      "locationId": entity.venueId,
      "scorerId": entity.scorerId,
      'date':
          "${entity.date.year}-${entity.date.month.toString().padLeft(2, '0')}-${entity.date.day.toString().padLeft(2, '0')}",
      'time':
          "${entity.time.hour.toString().padLeft(2, '0')}:${entity.time.minute.toString().padLeft(2, '0')}",
    });
  }
}
