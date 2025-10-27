import 'package:cricklo/core/errors/failure.dart';
import 'package:cricklo/core/usecase/usecase.dart';
import 'package:cricklo/features/tournament/domain/entities/create_group_table_response_entity.dart';

import 'package:cricklo/features/tournament/domain/repo/tournament_repo.dart';
import 'package:dartz/dartz.dart';

class CreateGroupTableUsecase
    extends UseCase<CreateGroupTableResponseEntity, String> {
  final TournamentRepo _tournamentRepo;

  CreateGroupTableUsecase(this._tournamentRepo);

  @override
  Future<Either<Failure, CreateGroupTableResponseEntity>> call(String entity) {
    return _tournamentRepo.createMatches(entity);
  }
}
