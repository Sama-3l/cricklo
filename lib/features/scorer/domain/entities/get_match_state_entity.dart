import 'package:cricklo/features/scorer/domain/entities/match_center_entity.dart';

class GetMatchStateResponseEntity {
  final bool success;
  final String? message;
  final MatchCenterEntity? match;
  final bool? live;
  final String? source;
  final int? status;
  final String? errorCode;
  final String? errorMessage;

  GetMatchStateResponseEntity({
    required this.success,
    this.message,
    this.match,
    this.live,
    this.source,
    this.status,
    this.errorCode,
    this.errorMessage,
  });
}
