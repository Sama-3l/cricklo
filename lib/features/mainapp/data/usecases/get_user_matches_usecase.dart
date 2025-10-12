import 'package:cricklo/core/errors/failure.dart';
import 'package:cricklo/core/usecase/usecase.dart';
import 'package:cricklo/features/matches/domain/entities/get_user_matches_response_entity.dart';
import 'package:cricklo/features/matches/domain/repo/match_repo.dart';
import 'package:dartz/dartz.dart';

class GetUserMatchesUsecase
    extends UseCase<GetUserMatchesResponseEntity, NoParams> {
  final MatchRepo repository;

  GetUserMatchesUsecase(this.repository);

  @override
  Future<Either<Failure, GetUserMatchesResponseEntity>> call(NoParams query) {
    return repository.getUserMatches();
  }
}
