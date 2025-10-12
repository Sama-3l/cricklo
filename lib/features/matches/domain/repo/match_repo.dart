import 'package:cricklo/core/errors/failure.dart';
import 'package:cricklo/features/matches/data/entities/create_match_usecase_entity.dart';
import 'package:cricklo/features/matches/domain/entities/create_match_response_entity.dart';
import 'package:cricklo/features/matches/domain/entities/get_user_matches_response_entity.dart';
import 'package:dartz/dartz.dart';

abstract class MatchRepo {
  Future<Either<Failure, CreateMatchResponseEntity>> createMatch(
    CreateMatchUsecaseEntity entity,
  );
  Future<Either<Failure, GetUserMatchesResponseEntity>> getUserMatches();
}
