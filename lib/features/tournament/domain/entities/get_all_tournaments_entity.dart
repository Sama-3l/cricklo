import 'package:cricklo/features/tournament/domain/entities/tournament_entity.dart';

class GetAllTournamentsEntity {
  final bool success;
  final List<TournamentEntity>? tournaments;
  final String? message;
  final int? status;
  final String? errorCode;
  final String? errorMessage;

  GetAllTournamentsEntity({
    required this.success,
    this.tournaments,
    this.message,
    this.status,
    this.errorCode,
    this.errorMessage,
  });
}
