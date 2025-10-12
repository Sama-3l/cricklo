// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cricklo/features/matches/domain/entities/match_entity.dart';

class GetUserMatchesResponseEntity {
  final bool success;
  final List<MatchEntity> matches;
  final String? message;
  final int? status;
  final String? errorCode;
  final String? errorMessage;

  GetUserMatchesResponseEntity({
    required this.success,
    required this.matches,
    this.message,
    this.status,
    this.errorCode,
    this.errorMessage,
  });
}
