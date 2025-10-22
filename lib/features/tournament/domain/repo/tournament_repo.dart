import 'package:cricklo/core/errors/failure.dart';
import 'package:cricklo/features/tournament/domain/entities/create_tournament_response_entity.dart';
import 'package:cricklo/features/tournament/domain/entities/tournament_entity.dart';
import 'package:dartz/dartz.dart';

abstract class TournamentRepo {
  Future<Either<Failure, CreateTournamentResponseEntity>> createTournament(
    TournamentEntity entity,
  );
}
