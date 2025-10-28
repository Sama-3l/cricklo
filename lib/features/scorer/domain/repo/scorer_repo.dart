import 'package:cricklo/core/errors/failure.dart';
import 'package:cricklo/features/scorer/data/entities/scorer_request_usecase_entity.dart';
import 'package:cricklo/features/scorer/domain/entities/broadcast_wrapper_entity.dart';
import 'package:cricklo/features/scorer/domain/entities/get_match_state_entity.dart';
import 'package:cricklo/features/scorer/domain/entities/scorer_response_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

abstract class ScorerRepo {
  Future<Either<Failure, ScorerResponseEntity>> startScoring(
    ScorerRequestUsecaseEntity body,
  );
  Future<Either<Failure, ScorerResponseEntity>> updateScoring(
    ScorerRequestUsecaseEntity body,
  );
  Future<Either<Failure, ScorerResponseEntity>> endOver(
    ScorerRequestUsecaseEntity body,
  );
  Future<Either<Failure, ScorerResponseEntity>> scorerInningsChange(
    ScorerRequestUsecaseEntity request,
  );

  Future<Either<Failure, ScorerResponseEntity>> scorerComplete(
    ScorerRequestUsecaseEntity request,
  );
  Future<Either<Failure, GetMatchStateResponseEntity>> getMatchState(
    String matchId,
  );
  Stream<Either<Failure, BroadcastWrapperEntity>> listenToMatchStream(
    String matchId,
    BuildContext context,
  );
}
