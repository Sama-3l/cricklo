import 'package:cricklo/core/errors/failure.dart';
import 'package:cricklo/core/usecase/usecase.dart';
import 'package:cricklo/features/tournament/domain/entities/create_tournament_response_entity.dart';
import 'package:cricklo/features/tournament/domain/entities/tournament_entity.dart';
import 'package:cricklo/features/tournament/domain/repo/tournament_repo.dart';
import 'package:dartz/dartz.dart';

class CreateTournamentUsecase
    extends UseCase<CreateTournamentResponseEntity, TournamentEntity> {
  final TournamentRepo _tournamentRepo;

  CreateTournamentUsecase(this._tournamentRepo);

  @override
  Future<Either<Failure, CreateTournamentResponseEntity>> call(
    TournamentEntity entity,
  ) {
    return _tournamentRepo.createTournament(entity);
  }
}
