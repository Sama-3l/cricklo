import 'package:cricklo/features/tournament/domain/entities/tournament_entity.dart';

class GetTournamentDetailsEntity {
  final bool success;
  final TournamentEntity? tournamentEntity;
  final String? message;
  final int? status;
  final String? errorCode;
  final String? errorMessage;

  GetTournamentDetailsEntity({
    required this.success,
    this.tournamentEntity,
    this.message,
    this.status,
    this.errorCode,
    this.errorMessage,
  });
}
