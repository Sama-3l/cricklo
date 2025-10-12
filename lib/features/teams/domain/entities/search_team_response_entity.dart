// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cricklo/features/teams/domain/entities/team_entity.dart';

class SearchTeamResponseEntity {
  final bool success;
  final List<TeamEntity>? teams;
  final String? message;
  final int? status;
  final String? errorCode;
  final String? errorMessage;

  SearchTeamResponseEntity({
    required this.success,
    this.teams,
    this.message,
    this.status,
    this.errorCode,
    this.errorMessage,
  });
}
