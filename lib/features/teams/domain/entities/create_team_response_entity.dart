// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cricklo/features/teams/domain/entities/team_entity.dart';

class CreateTeamResponseEntity {
  final bool success;
  final TeamEntity? team;
  final String? message;
  final int? status;
  final String? errorCode;
  final String? errorMessage;

  CreateTeamResponseEntity({
    required this.success,
    this.team,
    this.message,
    this.status,
    this.errorCode,
    this.errorMessage,
  });
}
