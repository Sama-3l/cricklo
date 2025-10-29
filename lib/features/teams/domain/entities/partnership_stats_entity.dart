class PartnershipStatsEntity {
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

  PartnershipStatsEntity({
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
}
