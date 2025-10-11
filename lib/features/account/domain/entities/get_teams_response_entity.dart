import 'package:cricklo/features/teams/domain/entities/team_entity.dart';

class GetTeamsResponseEntity {
  final bool success;
  final List<TeamEntity>? teams;
  final String? message;
  final int? status;
  final String? errorCode;
  final String? errorMessage;

  GetTeamsResponseEntity({
    required this.success,
    this.teams,
    this.message,
    this.status,
    this.errorCode,
    this.errorMessage,
  });
}
