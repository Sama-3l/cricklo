import 'package:cricklo/core/errors/failure.dart';
import 'package:cricklo/core/usecase/usecase.dart';
import 'package:cricklo/features/teams/domain/entities/get_team_details_response_entity.dart';
import 'package:cricklo/features/teams/domain/repo/team_repo.dart';
import 'package:dartz/dartz.dart';

class GetTeamDetailsUsecase
    extends UseCase<GetTeamDetailsResponseEntity, String> {
  final TeamRepo _teamRepo;

  GetTeamDetailsUsecase(this._teamRepo);

  @override
  Future<Either<Failure, GetTeamDetailsResponseEntity>> call(String entity) {
    return _teamRepo.getTeamDetails(entity);
  }
}
