import 'package:cricklo/core/errors/failure.dart';
import 'package:cricklo/core/usecase/usecase.dart';
import 'package:cricklo/features/teams/domain/entities/create_team_response_entity.dart';
import 'package:cricklo/features/teams/domain/entities/team_entity.dart';
import 'package:cricklo/features/teams/domain/models/remote/team_model.dart';
import 'package:cricklo/features/teams/domain/repo/team_repo.dart';
import 'package:dartz/dartz.dart';

class CreateTeamUsecase extends UseCase<CreateTeamResponseEntity, TeamEntity> {
  final TeamRepo _teamRepo;

  CreateTeamUsecase(this._teamRepo);

  @override
  Future<Either<Failure, CreateTeamResponseEntity>> call(TeamEntity entity) {
    return _teamRepo.createTeam(TeamModel.fromEntity(entity));
  }
}
