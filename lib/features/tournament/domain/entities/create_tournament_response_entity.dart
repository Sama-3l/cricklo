class CreateTournamentResponseEntity {
  final bool success;
  final String? tournamentId;
  final String? message;
  final int? status;
  final String? errorCode;
  final String? errorMessage;

  CreateTournamentResponseEntity({
    required this.success,
    this.tournamentId,
    this.message,
    this.status,
    this.errorCode,
    this.errorMessage,
  });
}
