import 'package:cricklo/core/errors/failure.dart';
import 'package:cricklo/core/usecase/usecase.dart';
import 'package:cricklo/features/matches/data/entities/create_match_usecase_entity.dart';
import 'package:cricklo/features/matches/domain/entities/create_match_response_entity.dart';
import 'package:cricklo/features/matches/domain/repo/match_repo.dart';
import 'package:dartz/dartz.dart';

class CreateMatchUsecase
    extends UseCase<CreateMatchResponseEntity, CreateMatchUsecaseEntity> {
  final MatchRepo repository;

  CreateMatchUsecase(this.repository);

  @override
  Future<Either<Failure, CreateMatchResponseEntity>> call(
    CreateMatchUsecaseEntity query,
  ) {
    return repository.createMatch(query);
  }
}
