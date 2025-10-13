class InviteResponseResponseEntity {
  final bool success;

  final String? message;
  final int? status;
  final String? errorCode;
  final String? errorMessage;

  InviteResponseResponseEntity({
    required this.success,
    this.message,
    this.status,
    this.errorCode,
    this.errorMessage,
  });
}
