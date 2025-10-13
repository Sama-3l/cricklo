class TeamInviteResponseResponseEntity {
  final bool success;

  final String? message;
  final int? status;
  final String? errorCode;
  final String? errorMessage;

  TeamInviteResponseResponseEntity({
    required this.success,
    this.message,
    this.status,
    this.errorCode,
    this.errorMessage,
  });
}
