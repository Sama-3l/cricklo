import 'package:cricklo/core/errors/failure.dart';
import 'package:cricklo/core/usecase/usecase.dart';
import 'package:cricklo/features/account/domain/entities/get_teams_response_entity.dart';
import 'package:cricklo/features/teams/domain/repo/team_repo.dart';
import 'package:dartz/dartz.dart';

class GetTeamsUsecase extends UseCase<GetTeamsResponseEntity, NoParams> {
  final TeamRepo _teamRepo;

  GetTeamsUsecase(this._teamRepo);

  @override
  Future<Either<Failure, GetTeamsResponseEntity>> call(NoParams entity) {
    return _teamRepo.getTeams();
  }
}
