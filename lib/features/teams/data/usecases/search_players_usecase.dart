import 'package:cricklo/core/errors/failure.dart';
import 'package:cricklo/core/usecase/usecase.dart';
import 'package:cricklo/features/teams/domain/entities/search_players_response_entity.dart';
import 'package:cricklo/features/teams/domain/repo/team_repo.dart';
import 'package:dartz/dartz.dart';

class SearchPlayersUsecase
    extends UseCase<SearchPlayersResponseEntity, String> {
  final TeamRepo _teamRepo;

  SearchPlayersUsecase(this._teamRepo);

  @override
  Future<Either<Failure, SearchPlayersResponseEntity>> call(String entity) {
    return _teamRepo.searchPlayers(entity);
  }
}
