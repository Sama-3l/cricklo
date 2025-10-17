import 'package:cricklo/core/errors/failure.dart';
import 'package:cricklo/core/usecase/stream_usecase.dart';
import 'package:cricklo/features/scorer/domain/entities/broadcast_wrapper_entity.dart';
import 'package:cricklo/features/scorer/domain/repo/scorer_repo.dart';
import 'package:dartz/dartz.dart';

class ListenToMatchStreamUsecase
    extends StreamUseCase<BroadcastWrapperEntity, String> {
  final ScorerRepo repository;

  ListenToMatchStreamUsecase(this.repository);

  @override
  Stream<Either<Failure, BroadcastWrapperEntity>> call(String matchId) {
    return repository.listenToMatchStream(matchId);
  }
}
