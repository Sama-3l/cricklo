import 'package:cricklo/core/errors/failure.dart';
import 'package:cricklo/core/usecase/usecase.dart';
import 'package:cricklo/features/scorer/data/entities/scorer_request_usecase_entity.dart';
import 'package:cricklo/features/scorer/domain/entities/scorer_response_entity.dart';
import 'package:cricklo/features/scorer/domain/repo/scorer_repo.dart';
import 'package:dartz/dartz.dart';

class ScorerUpdateUsecase
    extends UseCase<ScorerResponseEntity, ScorerRequestUsecaseEntity> {
  final ScorerRepo repository;

  ScorerUpdateUsecase(this.repository);

  @override
  Future<Either<Failure, ScorerResponseEntity>> call(
    ScorerRequestUsecaseEntity params,
  ) {
    return repository.updateScoring(params);
  }
}
