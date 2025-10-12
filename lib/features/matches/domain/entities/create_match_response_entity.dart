// ignore_for_file: public_member_api_docs, sort_constructors_first

class CreateMatchResponseEntity {
  final bool success;
  final String matchId;
  final String? message;
  final int? status;
  final String? errorCode;
  final String? errorMessage;

  CreateMatchResponseEntity({
    required this.success,
    required this.matchId,
    this.message,
    this.status,
    this.errorCode,
    this.errorMessage,
  });
}
