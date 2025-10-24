import 'package:cricklo/core/errors/failure.dart';
import 'package:cricklo/features/notifications/domain/entities/invite_response_response_entity.dart';
import 'package:cricklo/features/tournament/domain/entities/create_tournament_response_entity.dart';
import 'package:cricklo/features/tournament/domain/entities/get_all_tournaments_entity.dart';
import 'package:cricklo/features/tournament/domain/entities/get_tournament_details_entity.dart';
import 'package:cricklo/features/tournament/domain/entities/tournament_entity.dart';
import 'package:dartz/dartz.dart';

abstract class TournamentRepo {
  Future<Either<Failure, CreateTournamentResponseEntity>> createTournament(
    TournamentEntity entity,
  );
  Future<Either<Failure, GetAllTournamentsEntity>> getAllTournaments();
  Future<Either<Failure, InviteResponseResponseEntity>> inviteModerators(
    String tournamentId,
    Map<String, dynamic> body,
  );
  Future<Either<Failure, InviteResponseResponseEntity>> inviteTeams(
    String tournamentId,
    Map<String, dynamic> body,
  );
  Future<Either<Failure, InviteResponseResponseEntity>> tournamentApply(
    String tournamentId,
    Map<String, dynamic> body,
  );
  Future<Either<Failure, GetTournamentDetailsEntity>> getTournamentDetails(
    String tournamentId,
  );
  Future<Either<Failure, InviteResponseResponseEntity>> tournamentCreateGroup(
    String tournamentId,
    Map<String, dynamic> body,
  );
  Future<Either<Failure, InviteResponseResponseEntity>> addToGroup(
    String tournamentId,
    Map<String, dynamic> body,
  );
  Future<Either<Failure, InviteResponseResponseEntity>> deleteGroup(
    String tournamentId,
    Map<String, dynamic> body,
  );
}
