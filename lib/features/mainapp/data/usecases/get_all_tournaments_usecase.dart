import 'package:cricklo/core/errors/failure.dart';
import 'package:cricklo/core/usecase/usecase.dart';
import 'package:cricklo/features/tournament/domain/entities/get_all_tournaments_entity.dart';
import 'package:cricklo/features/tournament/domain/repo/tournament_repo.dart';
import 'package:dartz/dartz.dart';

class GetAllTournamentsUsecase
    extends UseCase<GetAllTournamentsEntity, NoParams> {
  final TournamentRepo _tournamentRepo;

  GetAllTournamentsUsecase(this._tournamentRepo);

  @override
  Future<Either<Failure, GetAllTournamentsEntity>> call(NoParams entity) {
    return _tournamentRepo.getAllTournaments();
  }
}
