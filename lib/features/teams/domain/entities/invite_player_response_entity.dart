import 'package:cricklo/features/teams/domain/entities/invite_entity.dart';

class InvitePlayerResponseEntity {
  final bool success;
  final List<InviteEntity>? invites;
  final String? message;
  final int? status;
  final String? errorCode;
  final String? errorMessage;

  InvitePlayerResponseEntity({
    required this.success,
    this.invites,
    this.message,
    this.status,
    this.errorCode,
    this.errorMessage,
  });
}
