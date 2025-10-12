import 'package:cricklo/core/errors/failure.dart';
import 'package:cricklo/core/usecase/usecase.dart';
import 'package:cricklo/features/teams/domain/entities/search_team_response_entity.dart';
import 'package:cricklo/features/teams/domain/repo/team_repo.dart';
import 'package:dartz/dartz.dart';

class SearchTeamsUseCase extends UseCase<SearchTeamResponseEntity, String> {
  final TeamRepo repository;

  SearchTeamsUseCase(this.repository);

  @override
  Future<Either<Failure, SearchTeamResponseEntity>> call(String query) {
    return repository.searchTeams(query);
  }
}
