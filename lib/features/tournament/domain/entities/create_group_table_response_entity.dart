// lib/features/tournament/domain/entities/create_group_matches_response_entity.dart

import 'package:cricklo/features/matches/domain/entities/match_entity.dart';

class CreateGroupTableResponseEntity {
  final bool success;
  final String? message;
  final int? totalMatches;
  final int? groupMatchesLength;
  final int? playoffMatches;
  final Map<String, List<MatchEntity>> groupMatches;
  final List<MatchEntity> playoffs;
  final int? status;
  final String? errorCode;
  final String? errorMessage;

  const CreateGroupTableResponseEntity({
    required this.success,
    this.message,
    this.totalMatches,
    this.groupMatchesLength,
    this.playoffMatches,
    required this.groupMatches,
    required this.playoffs,
    this.status,
    this.errorCode,
    this.errorMessage,
  });
}
