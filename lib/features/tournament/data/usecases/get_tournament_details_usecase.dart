import 'package:cricklo/core/errors/failure.dart';
import 'package:cricklo/core/usecase/usecase.dart';
import 'package:cricklo/features/tournament/domain/entities/get_tournament_details_entity.dart';
import 'package:cricklo/features/tournament/domain/repo/tournament_repo.dart';
import 'package:dartz/dartz.dart';

class GetTournamentDetailsUsecase
    extends UseCase<GetTournamentDetailsEntity, String> {
  final TournamentRepo _tournamentRepo;

  GetTournamentDetailsUsecase(this._tournamentRepo);

  @override
  Future<Either<Failure, GetTournamentDetailsEntity>> call(String entity) {
    return _tournamentRepo.getTournamentDetails(entity);
  }
}
