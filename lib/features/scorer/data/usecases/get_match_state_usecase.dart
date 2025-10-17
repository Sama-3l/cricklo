import 'package:cricklo/core/errors/failure.dart';
import 'package:cricklo/core/usecase/usecase.dart';
import 'package:cricklo/features/scorer/domain/entities/get_match_state_entity.dart';
import 'package:cricklo/features/scorer/domain/repo/scorer_repo.dart';
import 'package:dartz/dartz.dart';

class GetMatchStateUsecase
    extends UseCase<GetMatchStateResponseEntity, String> {
  final ScorerRepo repository;

  GetMatchStateUsecase(this.repository);

  @override
  Future<Either<Failure, GetMatchStateResponseEntity>> call(String matchId) {
    return repository.getMatchState(matchId);
  }
}
