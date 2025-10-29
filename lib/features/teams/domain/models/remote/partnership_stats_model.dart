import 'package:cricklo/features/teams/domain/entities/partnership_stats_entity.dart';

class PartnershipStatsModel {
  final String partnershipId;
  final int totalRuns;
  final int totalBalls;

  // Batsman 1
  final String batsman1Id;
  final String batsman1Name;
  final String? batsman1Photo;
  final int batsman1Runs;
  final int batsman1Balls;

  // Batsman 2
  final String batsman2Id;
  final String batsman2Name;
  final String? batsman2Photo;
  final int batsman2Runs;
  final int batsman2Balls;

  // Match details
  final String matchId;
  final DateTime matchDate;

  PartnershipStatsModel({
    required this.partnershipId,
    required this.totalRuns,
    required this.totalBalls,
    required this.batsman1Id,
    required this.batsman1Name,
    this.batsman1Photo,
    required this.batsman1Runs,
    required this.batsman1Balls,
    required this.batsman2Id,
    required this.batsman2Name,
    this.batsman2Photo,
    required this.batsman2Runs,
    required this.batsman2Balls,
    required this.matchId,
    required this.matchDate,
  });

  factory PartnershipStatsModel.fromJson(Map<String, dynamic> json) {
    return PartnershipStatsModel(
      partnershipId: json['partnershipId'],
      totalRuns: json['totalRuns'],
      totalBalls: json['totalBalls'],
      batsman1Id: json['batsman1']['player']['profileId'],
      batsman1Name: json['batsman1']['player']['name'],
      batsman1Photo: json['batsman1']['player']['photo'],
      batsman1Runs: json['batsman1']['runs'],
      batsman1Balls: json['batsman1']['balls'],
      batsman2Id: json['batsman2']['player']['profileId'],
      batsman2Name: json['batsman2']['player']['name'],
      batsman2Photo: json['batsman2']['player']['photo'],
      batsman2Runs: json['batsman2']['runs'],
      batsman2Balls: json['batsman2']['balls'],
      matchId: json['match']['matchId'],
      matchDate: DateTime.parse(json['match']['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'partnershipId': partnershipId,
      'totalRuns': totalRuns,
      'totalBalls': totalBalls,
      'batsman1Id': batsman1Id,
      'batsman1Name': batsman1Name,
      'batsman1Photo': batsman1Photo,
      'batsman1Runs': batsman1Runs,
      'batsman1Balls': batsman1Balls,
      'batsman2Id': batsman2Id,
      'batsman2Name': batsman2Name,
      'batsman2Photo': batsman2Photo,
      'batsman2Runs': batsman2Runs,
      'batsman2Balls': batsman2Balls,
      'matchId': matchId,
      'matchDate': matchDate.toIso8601String(),
    };
  }

  PartnershipStatsEntity toEntity() {
    return PartnershipStatsEntity(
      partnershipId: partnershipId,
      totalRuns: totalRuns,
      totalBalls: totalBalls,
      batsman1Id: batsman1Id,
      batsman1Name: batsman1Name,
      batsman1Runs: batsman1Runs,
      batsman1Balls: batsman1Balls,
      batsman2Id: batsman2Id,
      batsman2Name: batsman2Name,
      batsman2Runs: batsman2Runs,
      batsman2Balls: batsman2Balls,
      matchId: matchId,
      matchDate: matchDate,
    );
  }

  factory PartnershipStatsModel.fromEntity(PartnershipStatsEntity entity) {
    return PartnershipStatsModel(
      partnershipId: entity.partnershipId,
      totalRuns: entity.totalRuns,
      totalBalls: entity.totalBalls,
      batsman1Id: entity.batsman1Id,
      batsman1Name: entity.batsman1Name,
      batsman1Runs: entity.batsman1Runs,
      batsman1Balls: entity.batsman1Balls,
      batsman2Id: entity.batsman2Id,
      batsman2Name: entity.batsman2Name,
      batsman2Runs: entity.batsman2Runs,
      batsman2Balls: entity.batsman2Balls,
      matchId: entity.matchId,
      matchDate: entity.matchDate,
    );
  }
}
