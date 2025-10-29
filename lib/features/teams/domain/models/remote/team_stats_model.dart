import 'package:cricklo/features/teams/domain/entities/team_stats_entity.dart';

class TeamStatsModel {
  final int matches;
  final int wins;
  final int losses;
  final int draws;
  final int abandoned;
  final double nrr;
  final int tossWins;
  final int batFirst;
  final int batFirstWins;
  final int batFirstLoss;
  final int bowlFirst;
  final int bowlFirstWins;
  final int bowlFirstLoss;

  final String? highestRunsScoredMatchId;
  final DateTime? highestRunsScoredDate;

  final String? lowestRunsScoredMatchId;
  final DateTime? lowestRunsScoredDate;

  final String? highestRunsConcededMatchId;
  final DateTime? highestRunsConcededDate;

  final String? lowestRunsConcededMatchId;
  final DateTime? lowestRunsConcededDate;

  TeamStatsModel({
    required this.matches,
    required this.wins,
    required this.losses,
    required this.draws,
    required this.abandoned,
    required this.nrr,
    required this.tossWins,
    required this.batFirst,
    required this.batFirstWins,
    required this.batFirstLoss,
    required this.bowlFirst,
    required this.bowlFirstWins,
    required this.bowlFirstLoss,
    this.highestRunsScoredMatchId,
    this.highestRunsScoredDate,
    this.lowestRunsScoredMatchId,
    this.lowestRunsScoredDate,
    this.highestRunsConcededMatchId,
    this.highestRunsConcededDate,
    this.lowestRunsConcededMatchId,
    this.lowestRunsConcededDate,
  });

  factory TeamStatsModel.fromJson(Map<String, dynamic> json) {
    return TeamStatsModel(
      matches: json['matches'] ?? 0,
      wins: json['wins'] ?? 0,
      losses: json['losses'] ?? 0,
      draws: json['draws'] ?? 0,
      abandoned: json['abandoned'] ?? 0,
      nrr: (json['nrr'] ?? 0).toDouble(),
      tossWins: json['tossWins'] ?? 0,
      batFirst: json['batFirst'] ?? 0,
      batFirstWins: json['batFirstWins'] ?? 0,
      batFirstLoss: json['batFirstLoss'] ?? 0,
      bowlFirst: json['bowlFirst'] ?? 0,
      bowlFirstWins: json['bowlFirstWins'] ?? 0,
      bowlFirstLoss: json['bowlFirstLoss'] ?? 0,
      highestRunsScoredMatchId: json['highestRunsScored']?['matchId'],
      highestRunsScoredDate: json['highestRunsScored']?['date'] != null
          ? DateTime.tryParse(json['highestRunsScored']['date'])
          : null,
      lowestRunsScoredMatchId: json['lowestRunsScored']?['matchId'],
      lowestRunsScoredDate: json['lowestRunsScored']?['date'] != null
          ? DateTime.tryParse(json['lowestRunsScored']['date'])
          : null,
      highestRunsConcededMatchId: json['highestRunsConceded']?['matchId'],
      highestRunsConcededDate: json['highestRunsConceded']?['date'] != null
          ? DateTime.tryParse(json['highestRunsConceded']['date'])
          : null,
      lowestRunsConcededMatchId: json['lowestRunsConceded']?['matchId'],
      lowestRunsConcededDate: json['lowestRunsConceded']?['date'] != null
          ? DateTime.tryParse(json['lowestRunsConceded']['date'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'matches': matches,
      'wins': wins,
      'losses': losses,
      'draws': draws,
      'abandoned': abandoned,
      'nrr': nrr,
      'tossWins': tossWins,
      'batFirst': batFirst,
      'batFirstWins': batFirstWins,
      'batFirstLoss': batFirstLoss,
      'bowlFirst': bowlFirst,
      'bowlFirstWins': bowlFirstWins,
      'bowlFirstLoss': bowlFirstLoss,
      'highestRunsScored': highestRunsScoredMatchId != null
          ? {
              'matchId': highestRunsScoredMatchId,
              'date': highestRunsScoredDate?.toIso8601String(),
            }
          : null,
      'lowestRunsScored': lowestRunsScoredMatchId != null
          ? {
              'matchId': lowestRunsScoredMatchId,
              'date': lowestRunsScoredDate?.toIso8601String(),
            }
          : null,
      'highestRunsConceded': highestRunsConcededMatchId != null
          ? {
              'matchId': highestRunsConcededMatchId,
              'date': highestRunsConcededDate?.toIso8601String(),
            }
          : null,
      'lowestRunsConceded': lowestRunsConcededMatchId != null
          ? {
              'matchId': lowestRunsConcededMatchId,
              'date': lowestRunsConcededDate?.toIso8601String(),
            }
          : null,
    };
  }

  /// Convert Model → Entity
  TeamStatsEntity toEntity() {
    return TeamStatsEntity(
      matches: matches,
      wins: wins,
      losses: losses,
      draws: draws,
      abandoned: abandoned,
      nrr: nrr,
      tossWins: tossWins,
      batFirst: batFirst,
      batFirstWins: batFirstWins,
      batFirstLoss: batFirstLoss,
      bowlFirst: bowlFirst,
      bowlFirstWins: bowlFirstWins,
      bowlFirstLoss: bowlFirstLoss,
      highestRunsScoredMatchId: highestRunsScoredMatchId,
      highestRunsScoredDate: highestRunsScoredDate,
      lowestRunsScoredMatchId: lowestRunsScoredMatchId,
      lowestRunsScoredDate: lowestRunsScoredDate,
      highestRunsConcededMatchId: highestRunsConcededMatchId,
      highestRunsConcededDate: highestRunsConcededDate,
      lowestRunsConcededMatchId: lowestRunsConcededMatchId,
      lowestRunsConcededDate: lowestRunsConcededDate,
    );
  }

  /// Convert Entity → Model
  factory TeamStatsModel.fromEntity(TeamStatsEntity entity) {
    return TeamStatsModel(
      matches: entity.matches,
      wins: entity.wins,
      losses: entity.losses,
      draws: entity.draws,
      abandoned: entity.abandoned,
      nrr: entity.nrr,
      tossWins: entity.tossWins,
      batFirst: entity.batFirst,
      batFirstWins: entity.batFirstWins,
      batFirstLoss: entity.batFirstLoss,
      bowlFirst: entity.bowlFirst,
      bowlFirstWins: entity.bowlFirstWins,
      bowlFirstLoss: entity.bowlFirstLoss,
      highestRunsScoredMatchId: entity.highestRunsScoredMatchId,
      highestRunsScoredDate: entity.highestRunsScoredDate,
      lowestRunsScoredMatchId: entity.lowestRunsScoredMatchId,
      lowestRunsScoredDate: entity.lowestRunsScoredDate,
      highestRunsConcededMatchId: entity.highestRunsConcededMatchId,
      highestRunsConcededDate: entity.highestRunsConcededDate,
      lowestRunsConcededMatchId: entity.lowestRunsConcededMatchId,
      lowestRunsConcededDate: entity.lowestRunsConcededDate,
    );
  }
}
